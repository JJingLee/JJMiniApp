//
//  JKOUserSourceLoader.swift
//  JKOJSBridge
//
//  Created by chiehchun.lee on 2020/12/11.
//

import Foundation

public protocol JKOUserSourceLoaderRendererProtocol : NSObject {
    func render(with htmlURL : URL)
}

public protocol JKOUserSourceLoaderLogicHandlerProtocol : NSObject {
    func appLoadJS(_ js : String)
    func pageLoadJS(_ js : String)
}

public class JKOUserSourceLoader : NSObject {
    public func globalAppJS()->String? {
        return Bundle.main.fetchJSScript(with: "app")
    }
    public func globalAppJSON() -> [String: Any]? {
        return Bundle.main.fetchJSONDocument(with: "app")
    }
    public func getPageHTML(with route:String)->URL? {
        return Bundle.main.fetchHTMLDocumentURL(with: route)
    }
    public func getPageJS(with route:String)->String? {
        return Bundle.main.fetchJSScript(with: route)
    }
    public func loadUserAppJS(to logicHandler : JKOUserSourceLoaderLogicHandlerProtocol) {
        if let userAppJS = globalAppJS() {
            logicHandler.appLoadJS(userAppJS)
        }
    }
    public func loadUserPage(_ pageRoute:String,to renderer:JKOUserSourceLoaderRendererProtocol) {
        if let pageHTML = getPageHTML(with: pageRoute) {
            renderer.render(with:pageHTML)
        }
    }
    public func loadUserPageJS(_ pageRoute:String,to logicHandler : JKOUserSourceLoaderLogicHandlerProtocol) {
        if let pageJS = getPageJS(with: pageRoute) {
            logicHandler.pageLoadJS(pageJS)
        }
    }
}
