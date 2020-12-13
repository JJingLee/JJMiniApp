//
//  PageLifeCycleHandler.swift
//  JKOJSBridge
//
//  Created by chiehchun.lee on 2020/12/10.
//

import Foundation

public class PageLifeCycleHandler : NSObject {
    private var appID : String?
    private weak var worker : JKOJSWorker?
    init(worker:JKOJSWorker) {
        super.init()
        self.worker = worker
        let PageLifeCycle = Bundle.main.fetchJSScript(with: "PageLifeCycle") ?? ""
        worker.evaluateJS(PageLifeCycle)
    }
    public func configAppID(_ appID : String, _ pageID : String) {
        _ = worker?.callJSFunction("JKInitialPageLifeCycle", with: [appID, pageID])
        self.appID = appID
    }
    public func callOnLoad() {
        _ = worker?.callJSFunction("JKPageOnLoad", with: [])
    }
    public func callOnShow() {
        _ = worker?.callJSFunction("JKPageOnShow", with: [])
    }
    public func callOnReady() {
        _ = worker?.callJSFunction("JKPageOnReady", with: [])
    }
    public func callOnHide() {
        _ = worker?.callJSFunction("JKPageOnHide", with: [])
    }
    public func callOnError() {
        _ = worker?.callJSFunction("JKPageOnError", with: [])
    }
}
