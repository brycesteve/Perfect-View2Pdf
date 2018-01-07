//
//  Errors.swift
//  View2Pdf
//
//  Created by Steve Bryce on 05/01/2018.
//

import Foundation

public enum PdfError : Error {
    case noTempDirectory
    case fileWriteError
    case stdOutReadFailure
    case renderingError(Int32, String)
    case unknownError
}
