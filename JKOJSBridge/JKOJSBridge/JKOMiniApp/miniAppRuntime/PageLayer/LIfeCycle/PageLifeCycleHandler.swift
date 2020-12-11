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
        let ApplifeCycle = Bundle.main.fetchJSScript(with: "PagelifeCycle") ?? ""
        worker.evaluateJS(ApplifeCycle)
    }
    public func configAppID(_ appID : String, _ pageID : String) {
        _ = worker?.callJSFunction("JKInitialPageLifeCycle", with: [appID, pageID])
        self.appID = appID
    }
    public func callOnLoad() {
        guard let appID = self.appID else {return}
        _ = worker?.callJSFunction("JKPageOnLoad", with: [appID])
    }
    public func callOnShow() {
        guard let appID = self.appID else {return}
        _ = worker?.callJSFunction("JKPageOnShow", with: [appID])
    }
    public func callOnReady() {
        guard let appID = self.appID else {return}
        _ = worker?.callJSFunction("JKPageOnReady", with: [appID])
    }
    public func callOnHide() {
        guard let appID = self.appID else {return}
        _ = worker?.callJSFunction("JKPageOnHide", with: [appID])
    }
    public func callOnError() {
        guard let appID = self.appID else {return}
        _ = worker?.callJSFunction("JKPageOnError", with: [appID])
    }
}
