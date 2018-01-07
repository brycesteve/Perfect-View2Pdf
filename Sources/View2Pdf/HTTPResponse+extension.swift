//
//  HTTPResponse+extension.swift
//  View2Pdf
//
//  Created by Steve Bryce on 07/01/2018.
//

import Foundation
import PerfectHTTP
import PerfectMustache
import PerfectLib

extension HTTPResponse{
    /**
     Creates a pdf from a mustache template and outputs it to the browser
     - Parameters:
        - template: The path the the mustache template
        - context:  The values to popuplate the mustache template
        - documentRoot: Optional parameter to set the location of your document root.
     */
    public func renderPdfView(template: String, context: [String: Any] = [String: Any](), documentRoot:String = "./webroot") throws {
        let html = self.getHtmlFromMustache(template: template, context: context, documentRoot: documentRoot)
        let document = PdfDocument()
        let page = PdfPage(html)
        
        document.pages = [page]
        
        var pdf:Bytes = Bytes()
        do{
            pdf = try document.toPdf()
        }
        catch {
            throw PdfError.unknownError
        }
        addHeader(HTTPResponseHeader.Name.contentType, value: "application/pdf")
        status = .ok
        setBody(bytes: (pdf.exportBytes(count: (pdf.availableExportBytes))))
        completed()
    }
    
    /**
     Creates an pdf from a mustache template and sends it to the browser for download as a file
     - Parameters:
        - template: The path the the mustache template to render
        - downloadFileName: The name of the file to send to the browser (e.g. "MyFile.pdf")
        - context:  The values to popuplate the mustache template
        - documentRoot: Optional parameter to set the location of your document root.
     */
    public func renderPdfFile(template: String, downloadFileName:String, context: [String: Any] = [String: Any](), documentRoot:String = "./webroot/") throws {
        let html = self.getHtmlFromMustache(template: template, context: context, documentRoot: documentRoot)
        let document = PdfDocument()
        let page = PdfPage(html)
        
        document.pages = [page]
        
        var pdf:Bytes = Bytes()
        do{
            pdf = try document.toPdf()
        }
        catch {
            throw PdfError.unknownError
        }
        addHeader(HTTPResponseHeader.Name.contentType, value: "application/pdf")
        addHeader(HTTPResponseHeader.Name.contentDisposition, value: "attachment; filename=\(downloadFileName);")
        status = .ok
        setBody(bytes: (pdf.exportBytes(count: (pdf.availableExportBytes))))
        completed()
    }
    
    private func getHtmlFromMustache(template: String, context: [String:Any] = [String:Any](), documentRoot: String = "./webroot/")->String{
        let templatePath = documentRoot + (template.hasSuffix(".mustache") ? template : template + ".mustache")
        
        let d = context
        let context = MustacheEvaluationContext(templatePath: templatePath, map: d)
        let collector = MustacheEvaluationOutputCollector()
        let responseString = try? context.formulateResponse(withCollector: collector)
        return responseString ?? ""
    }
}
