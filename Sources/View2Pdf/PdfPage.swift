//
//  PdfPage.swift
//  View2Pdf
//
//  Created by Steve Bryce on 05/01/2018.
//

import Foundation
import PerfectLib

/**
 Struct representing a page within a PdfDocument
*/
public struct PdfPage {
    /**
     Page content to be rendered
    */
    let content: Bytes
    
    /**
     Initializer for creating a PdfPage from a Byte Array
     */
    public init(_ content: Bytes){
        self.content = content
    }
    
    /**
     Initializer for creating a PdfPage from an html string
    */
    public init(_ content: String){
        self.content = Bytes(existingBytes: [UInt8](content.utf8))
    }
}
