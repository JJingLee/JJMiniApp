//
//  JKOUserSourceLoader.swift
//  JKOJSBridge
//
//  Created by chiehchun.lee on 2020/12/11.
//

import Foundation

public protocol JKOUserSourceLoaderRendererProtocol : NSObject {
    func render(with htmlURL : URL)
    func renderByString(_ htmlString : String)
    func render(with cssPath: String)
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
    public func getPageHTMLString(with route:String)->String? {
        return Bundle.main.fetchHTMLDocument(with: route)
    }
    public func getPageJS(with route:String)->String? {
        return Bundle.main.fetchJSScript(with: route)
    }
    public func loadUserAppJS(to logicHandler : JKOUserSourceLoaderLogicHandlerProtocol) {
        if let userAppJS = globalAppJS() {
            logicHandler.appLoadJS(userAppJS)
        }
    }
    public func loadUserPage(_ pageRoute:String,to renderer:JKOUserSourceLoaderRendererProtocol, sourceWorker : JKMAPageWorker) {
        if let pageHTML = getPageHTML(with: pageRoute) {
            if let pageHTMLStr = getPageHTMLString(with: pageRoute) {
                sourceWorker.renewHTMLCopy(html: pageHTMLStr)
                sourceWorker.configPageDataListeners()
                let sourceData = sourceWorker.getPageData() ?? [:]
                let newHTML = sourceWorker.configHTML(with: sourceData, from: pageHTMLStr)
                renderer.renderByString(newHTML)
                return
            }
            renderer.render(with:pageHTML)
        }
        if let pageCSS = getPageCSS(with: pageRoute) {
            renderer.render(with: pageCSS)
        }
    }
    public func loadUserPageJS(_ pageRoute:String,to logicHandler : JKOUserSourceLoaderLogicHandlerProtocol) {
        if let pageJS = getPageJS(with: pageRoute) {
            logicHandler.pageLoadJS(pageJS)
        }
    }

    public func getPageCSS(with route: String) -> String? {
        return Bundle.main.fetchCSS(with: route)
    }
}
