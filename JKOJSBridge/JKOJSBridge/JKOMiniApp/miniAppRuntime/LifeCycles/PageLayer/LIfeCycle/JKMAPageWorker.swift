//
//  JKMAPageWorker.swift
//  JKOJSBridge
//
//  Created by chiehchun.lee on 2020/12/10.
//

import Foundation
public class JKMAPageWorker : JKOJSWorker {
    var pageID : String = ""
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
}
//public class PageLifeCycleHandler : NSObject {
//    private var appID : String?
//    private weak var worker : JKOJSWorker?
//    init(worker:JKOJSWorker) {
//        super.init()
//        self.worker = worker
////        importAppLifeCycle()
//        let PageLifeCycle = Bundle.main.fetchJSScript(with: "PageLifeCycle") ?? ""
//        worker.evaluateJS(PageLifeCycle)
//
//    }
//    public func configAppID(_ pageID : String) {
//        guard let _appID = worker?.appID else {return}
//        self.appID = _appID
//        _ = worker?.callJSFunction("initialAppLifeCycle", with: [_appID])
//        _ = worker?.callJSFunction("JKInitialPageLifeCycle", with: [_appID, pageID])
//    }
//    public func callOnLoad() {
//        _ = worker?.callJSFunction("JKPageOnLoad", with: [])
//    }
//    public func callOnShow() {
//        _ = worker?.callJSFunction("JKPageOnShow", with: [])
//    }
//    public func callOnReady() {
//        _ = worker?.callJSFunction("JKPageOnReady", with: [])
//    }
//    public func callOnHide() {
//        _ = worker?.callJSFunction("JKPageOnHide", with: [])
//    }
//    public func callOnError() {
//        _ = worker?.callJSFunction("JKPageOnError", with: [])
//    }
//
//    private func importAppLifeCycle() {
//        let ApplifeCycle = Bundle.main.fetchJSScript(with: "AppLifeCycle") ?? ""
//        worker?.evaluateJS(ApplifeCycle)
//    }
//}
