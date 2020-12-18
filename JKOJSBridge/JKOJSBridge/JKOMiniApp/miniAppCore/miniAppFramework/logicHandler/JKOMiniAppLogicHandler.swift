//
//  JKOMiniAppLogicHandler.swift
//  JKOJSBridge
//
//  Created by chiehchun.lee on 2020/11/24.
//

import Foundation
public class JKOMiniAppLogicHandler : NSObject {

    public private(set) var appID : String = ""
    //MARK: Runtime
    lazy var appLifeCycleHandler : JKOMiniAppLifeCycleHandler = JKOMiniAppLifeCycleHandler(worker: appWorker)
    lazy var pageLifeCycleHandler : PageLifeCycleHandler = PageLifeCycleHandler(worker: pageWorker)
    public var appWorker = JKOJSWorker()  //app layer jscore
    public var pageWorker = JKOJSWorker()  //page layer jscore

    private var pageWorkerFrameworks : [JKBNativeFrameworkProtocol] = []
    public func activeAppWorker(with appID : String) {
        self.appID = appID
        appLifeCycleHandler.configAppID(appID)
        bindApp()
    }
    public func activePageWorker(with appID : String, pageID:String) {
        pageLifeCycleHandler.configAppID(appID, pageID)
        let currentGlobalData = appWorker.getGlobalData()
        pageWorker.updateData(currentGlobalData)
        bindPage()
    }
    public func pageLoadFrameworks(_ frameworks : [JKBNativeFrameworkProtocol]) {
        pageWorker.importNativeFrameworks(frameworks)
    }
    public func appLoadFrameworks(_ frameworks : [JKBNativeFrameworkProtocol]) {
        JKB_log("miniapp launching native frameworks...")
        appWorker.importNativeFrameworks(frameworks)
        pageWorkerFrameworks = frameworks
        JKB_log("miniapp native frameworks launch done")
    }
    public func refreshPageWorker(with appID : String, pageID:String) {
        pageWorker = JKOJSWorker()
        pageLoadFrameworks(pageWorkerFrameworks)
        pageLifeCycleHandler = PageLifeCycleHandler(worker: pageWorker)
        activePageWorker(with: appID, pageID: pageID)
    }
    //MARK: - data binder
    weak var dataBinder : DataBindingHandler?
    public func bindGlobalData(to binder: DataBindingHandler) {
        self.dataBinder = binder
        bindPage()
        bindApp()
    }
    public func getGlobalData()->Any? {
        return appWorker.getGlobalData()
    }
    private func bindPage() {
        if let binder = dataBinder {
            binder.addObserver(pageWorker, with: JKO_GlobalDataKey_20201217)
        }
    }
    private func bindApp() {
        if let binder = dataBinder {
            binder.addObserver(appWorker, with: JKO_GlobalDataKey_20201217)
        }
    }
}
