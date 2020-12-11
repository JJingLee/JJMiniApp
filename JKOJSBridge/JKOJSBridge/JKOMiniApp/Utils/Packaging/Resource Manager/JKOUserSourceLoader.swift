//
//  JKOUserSourceLoader.swift
//  JKOJSBridge
//
//  Created by chiehchun.lee on 2020/12/11.
//

import Foundation

public class JKOUserSourceLoader : NSObject {
    public static let shared = JKOUserSourceLoader()
    public func globalAppJS()->String? {
        return Bundle.main.fetchJSScript(with: "app")
    }
    public func getPageHTML(with route:String)->URL? {
        return Bundle.main.fetchHTMLDocumentURL(with: route)
    }
    public func getPageJS(with route:String)->String? {
        return Bundle.main.fetchJSScript(with: route)
    }
}
