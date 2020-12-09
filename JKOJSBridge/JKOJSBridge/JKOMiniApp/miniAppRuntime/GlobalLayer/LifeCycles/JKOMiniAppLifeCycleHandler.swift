//
//  JKOMiniAppLifeCycleHandler.swift
//  JKOJSBridge
//
//  Created by chiehchun.lee on 2020/12/1.
//

import Foundation

public class JKOMiniAppLifeCycleHandler : NSObject {
    private weak var miniApp : JKOMiniApp?
    init(miniApp:JKOMiniApp) {
        super.init()
        self.miniApp = miniApp
        let ApplifeCycle = Bundle.main.fetchJSScript(with: "AppLifeCycle") ?? ""
        miniApp.worker.evaluateJS(ApplifeCycle)
    }
    public func configAppID(_ appID : String) {
        _ = miniApp?.worker.callJSFunction("initialAppLifeCycle", with: [appID])
    }
    public func callOnLaunch() {
        _ = miniApp?.worker.callJSFunction("onLaunch", with: [appID])
    }
    public func callOnShow() {
        _ = miniApp?.worker.callJSFunction("onShow", with: [appID])
    }
    public func callOnHide() {
        _ = miniApp?.worker.callJSFunction("onHide", with: [appID])
    }
    public func callOnError() {
        _ = miniApp?.worker.callJSFunction("onError", with: [appID])
    }
}
