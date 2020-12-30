//
//  JKMAPageWorker.swift
//  JKOJSBridge
//
//  Created by chiehchun.lee on 2020/12/10.
//

import Foundation
public class JKMAPageWorker : JKOJSWorker {
    public var pageID : String = ""
    public let pageSimpleDataBinder = PageSimpleDataBinder()
    init(appID: String, pageID:String) {
        super.init(appID: appID)
        self.pageID = pageID
        moduleHandler.launchFile("PageLifeCycle")
        callInit()
        listensToGlobalData()
    }
    private func callInit() {
        _ = self.callJSFunction("JKInitialPageLifeCycle", with: [appID, pageID])
    }
    public func callOnLoad() {
        _ = self.callJSFunction("JKPageOnLoad", with: [])
    }
    public func callOnShow() {
        _ = self.callJSFunction("JKPageOnShow", with: [])
    }
    public func callOnReady() {
        _ = self.callJSFunction("JKPageOnReady", with: [])
    }
    public func callOnHide() {
        _ = self.callJSFunction("JKPageOnHide", with: [])
    }
    public func callOnError() {
        _ = self.callJSFunction("JKPageOnError", with: [])
    }

    //Page Datas
    public func getPageData()->[String: Any]? {
        return self.callJSFunction("getPageData", with: [])?.toDictionary() as? [String:Any]
    }
    public func setPageData(_ newPageData : [String:Any]) {
        _ = self.callJSFunction("setPageData", with: [newPageData])
    }

    //Page Data Binder stuffs
    public func renewHTMLCopy(html:String) {
        self.pageSimpleDataBinder.renew(html: html)
    }
    public func configPageDataListeners() {
//        DispatchQueue(label: "PageBind", qos: .background, attributes: .concurrent).async{[weak self] in
            self.pageSimpleDataBinder.config()
//        }
        DataBinderHandlerManager.shared.dataBinder(appID: appID).addObserver(self.pageSimpleDataBinder, with: JKO_PageSimpleBindingDataKey_20201217(appID))
    }
    public func configHTML(with sourceData : [String:Any], from pageHTMLStr:String)->String {
        pageSimpleDataBinder.refreshPage(pageHTMLStr, with: sourceData)
    }
}
