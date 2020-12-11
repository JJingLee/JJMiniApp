//
//  FileFetcher.swift
//  JKOJSBridge
//
//  Created by chiehchun.lee on 2020/12/9.
//

import Foundation

extension Bundle {
    public func fetchJSScriptURL(with fileName:String)->URL? {
        return Bundle.main.url(forResource: fileName, withExtension: "js")
    }
    public func fetchJSScript(with fileName:String)->String? {
        guard fileName.count > 0 else {return nil}
        guard let fileURL = fetchJSScriptURL(with: fileName) else {return nil}
        let fileText = try? String(contentsOf: fileURL, encoding: .utf8)
        return fileText
    }
    public func fetchHTMLDocumentURL(with fileName:String)->URL? {
        return self.url(forResource: fileName, withExtension: "html")
    }
    public func fetchHTMLDocument(with fileName:String)->String? {
        guard fileName.count > 0 else {return nil}
        guard let fileURL = fetchHTMLDocumentURL(with: fileName) else {return nil}
        let fileText = try? String(contentsOf: fileURL, encoding: .utf8)
        return fileText
    }
}

