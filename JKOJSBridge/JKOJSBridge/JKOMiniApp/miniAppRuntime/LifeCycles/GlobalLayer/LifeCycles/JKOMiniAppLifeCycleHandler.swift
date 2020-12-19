//
//  JKOMiniAppLifeCycleHandler.swift
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
        let binder = DataBinderHandlerManager.dataBinder(appID: appID)
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
    
}
//public class JKOMiniAppLifeCycleHandler : NSObject {
//    private weak var worker : JKOJSWorker?
//    private var appID : String?
//    init(worker:JKOJSWorker) {
//        super.init()
//        self.worker = worker
//        let ApplifeCycle = Bundle.main.fetchJSScript(with: "AppLifeCycle") ?? ""
//        worker.evaluateJS(ApplifeCycle)
//    }
//    public func config() {
//        guard let _appID = worker?.appID else {return}
//        self.appID = _appID
//        _ = worker?.callJSFunction("initialAppLifeCycle", with: [_appID])
//
//    }
//    public func callOnLaunch() {
//        _ = worker?.callJSFunction("onLaunch", with: [])
//    }
//    public func callOnShow() {
//        _ = worker?.callJSFunction("onShow", with: [])
//    }
//    public func callOnHide() {
//        _ = worker?.callJSFunction("onHide", with: [])
//    }
//    public func callOnError() {
//        _ = worker?.callJSFunction("onError", with: [])
//    }
//}
