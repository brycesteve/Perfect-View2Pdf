// swift-tools-version:4.0
//
//  Package.swift
//  Perfect-View2Pdf
//
//  Created by Steve Bryce on 2018-01-05.
//  Copyright © 2017 Steve Bryce. All rights reserved.

import PackageDescription

let package = Package(
    name: "View2Pdf",
    products: [
        .library(
            name: "View2Pdf",
            targets: ["View2Pdf"]
        )
    ],
    dependencies: [
        .package(
            url: "https://github.com/PerfectlySoft/Perfect.git",
            from: "3.0.0"
        )
    ],
    targets: [
        .target(
            name: "View2Pdf",
            dependencies: ["PerfectLib"]),
        .testTarget(
            name: "View2PdfTests",
            dependencies: ["View2Pdf"]),
    ]
    
    
)
