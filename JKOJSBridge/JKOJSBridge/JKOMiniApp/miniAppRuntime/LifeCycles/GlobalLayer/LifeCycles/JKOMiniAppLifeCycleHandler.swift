//
//  JKOMiniAppLifeCycleHandler.swift
//  JKOJSBridge
//
//  Created by chiehchun.lee on 2020/12/1.
//

import Foundation

public class JKOMiniAppLifeCycleHandler : NSObject {
    private weak var worker : JKOJSWorker?
    private var appID : String?
    init(worker:JKOJSWorker) {
        super.init()
        self.worker = worker
        let ApplifeCycle = Bundle.main.fetchJSScript(with: "AppLifeCycle") ?? ""
        worker.evaluateJS(ApplifeCycle)
    }
    public func configAppID(_ appID : String) {
        _ = worker?.callJSFunction("initialAppLifeCycle", with: [appID])
        self.appID = appID
    }
    public func callOnLaunch() {
        _ = worker?.callJSFunction("onLaunch", with: [])
    }
    public func callOnShow() {
        _ = worker?.callJSFunction("onShow", with: [])
    }
    public func callOnHide() {
        _ = worker?.callJSFunction("onHide", with: [])
    }
    public func callOnError() {
        _ = worker?.callJSFunction("onError", with: [])
    }
}
