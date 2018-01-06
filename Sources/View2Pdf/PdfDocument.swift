//
//  PdfDocument.swift
//  View2Pdf
//
//  Created by Steve Bryce on 05/01/2018.
//

import Foundation
import PerfectLib

#if os(Linux)
    import SwiftGlibc
#else
    import Darwin
#endif

/**
 Class to represent the Pdf Document to render
 */
public class PdfDocument {
    /**
     Default document zoom level
     Adjust this if document renders incorrectly
    */
    public static var zoom: String = "1.3"
    
    let topMargin: Int
    let rightMargin: Int
    let bottomMargin: Int
    let leftMargin: Int
    
    /**
        Document Paper Size - Supports standard paper sizes (e.g. A4, Legal, Letter)
    */
    let paperSize: String
    
    public var pages: [PdfPage] = []
    
    public init(size: String = "A4", margins all: Int? = nil, top: Int? = nil, right: Int? = nil, bottom: Int? = nil, left: Int? = nil) {
        paperSize = size
        topMargin = all ?? top ?? 20
        rightMargin = all ?? right ?? 20
        bottomMargin = all ?? bottom ?? 20
        leftMargin = all ?? left ?? 20
    }
    
    /**
    Generates pdf data from document
    */
    public func toPdf() throws -> Bytes {
        var genArgs: [String] = [
            "--zoom", PdfDocument.zoom,
            "--quiet",
            "-s", paperSize,
            "-T", "\(topMargin)mm",
            "-R", "\(rightMargin)mm",
            "-B", "\(bottomMargin)mm",
            "-L", "\(leftMargin)mm",
        ]
        var pageFiles = [File]()
        do {
            pageFiles = try pages.map {
                page in
                let f = TemporaryFile(withPrefix: "View2Pdf", withExtension: "html")
                //let f = File("\(workingDirectory)/View2Pdf\(UUID().uuidString).html")
                try f.write(bytes: page.content.exportBytes(count: page.content.availableExportBytes))
                return f
            }
            
        }
        catch {
            throw PdfError.fileWriteError
        }
        defer {
            pageFiles.forEach { (file) in
                file.delete()
            }
        }
        //Add pages to process
        genArgs.append(contentsOf: pageFiles.map({ (f) -> String in
            return f.realPath
        }))
        //Sets output to standard out
        genArgs.append("-")
        
        let envs = [("PATH", "/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin")]
        // These paths may not be universal
        #if os(Linux)
            let proc = try SysProcess("/usr/bin/wkhtmltopdf", args: genArgs, env: envs)
        #else
            let proc = try SysProcess("/usr/local/bin/wkhtmltopdf", args: genArgs, env: envs)
        #endif
        let pdfData = Bytes()
        while true {
            do {
                guard let s = try proc.stdout?.readSomeBytes(count: 1024), s.count > 0 else {
                    break
                }
                pdfData.importBytes(from: s)
            }
            catch PerfectLib.PerfectError.fileError {
                throw PdfError.stdOutReadFailure
            }
        }
        let res = try proc.wait(hang: true)
        if res != 0 {
            let e = try proc.stderr?.readString()
            throw PdfError.renderingError(res, e!)
        }
        return pdfData
    }
}
