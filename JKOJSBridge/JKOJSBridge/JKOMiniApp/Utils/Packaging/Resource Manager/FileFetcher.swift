//
//  FileFetcher.swift
//  JKOJSBridge
//
//  Created by chiehchun.lee on 2020/12/9.
//

import Foundation

extension Bundle {
    public func fetchJSScript(with fileName:String)->String? {
        guard fileName.count > 0 else {return nil}
        guard let fileURL = Bundle.main.url(forResource: fileName, withExtension: "js") else {return nil}
        let fileText = try? String(contentsOf: fileURL, encoding: .utf8)
        return fileText
    }
}

