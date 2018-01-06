//
//  View2PdfTests.swift
//  Perfect-View2Pdf
//
//  Created by Steve Bryce on 2018-01-05.
//  Copyright © 2017 Steve Bryce All rights reserved.


import XCTest
@testable import View2Pdf
@testable import PerfectLib

class View2PdfTests: XCTestCase {
    func testRender() {
        let doc = PdfDocument()
        let page = PdfPage("<p>This is a test</p>")
        
        doc.pages = [page]
        var pdf = Bytes()
        do{
            pdf = try doc.toPdf();
        }
        catch (let e){
            print(e)
            XCTFail()
        }
        
        XCTAssertNotNil(pdf)
    }


    static var allTests = [
        ("testRender", testRender),
    ]
}

