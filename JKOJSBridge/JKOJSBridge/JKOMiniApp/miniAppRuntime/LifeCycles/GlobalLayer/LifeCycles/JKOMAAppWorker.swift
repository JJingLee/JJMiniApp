//
//  JKOMAAppWorker.swift
//  JKOJSBridge
//
//  Created by chiehchun.lee on 2020/12/1.
//

import Foundation
public class JKOMAAppWorker : JKOJSWorker {
    override init(appID: String) {
        super.init(appID: appID)
        moduleHandler.launchFile("AppLifeCycle")
        callInit()
        bindToGlobalDataBinder()
    }
    private func bindToGlobalDataBinder() {
        let binder = DataBinderHandlerManager.shared.dataBinder(appID: appID)
        binder.addObserver(self, with: JKO_GlobalDataKey_20201217(appID))
    }
    private func callInit() {
        _ = self.callJSFunction("initialAppLifeCycle", with: [appID])
    }
    public func callOnLaunch() {
        _ = self.callJSFunction("onLaunch", with: [])
    }
    public func callOnShow() {
        _ = self.callJSFunction("onShow", with: [])
    }
    public func callOnHide() {
        _ = self.callJSFunction("onHide", with: [])
    }
    public func callOnError() {
        _ = self.callJSFunction("onError", with: [])
    }
    public func rebootGlobalData() {
        self.evaluateJS("miniapp.rebootGlobalData()")
    }
    
}
