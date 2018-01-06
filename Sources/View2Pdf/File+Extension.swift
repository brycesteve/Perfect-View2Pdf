//
//  File+Extension.swift
//  View2Pdf
//
//  Created by Steve Bryce on 06/01/2018.
//

import Foundation
import PerfectLib

extension TemporaryFile {
    public convenience init(withPrefix: String, withExtension ext: String) {
        let template = withPrefix + "XXXXXX" + ".\(ext)"
        let utf8 = template.utf8
        let name = UnsafeMutablePointer<Int8>.allocate(capacity: utf8.count + 1)
        var i = utf8.startIndex
        for index in 0..<utf8.count {
            name[index] = Int8(utf8[i])
            i = utf8.index(after: i)
        }
        name[utf8.count] = 0
        
        let fd = mkstemps(name, Int32(ext.count + 1))
        let tmpFileName = String(validatingUTF8: name)!
        
        name.deallocate(capacity: utf8.count + 1)
        
        self.init(tmpFileName, fd: fd)
    }
}
