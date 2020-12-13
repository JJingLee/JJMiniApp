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
    }
    public func activePageWorker(with appID : String, pageID:String) {
        pageLifeCycleHandler.configAppID(appID, pageID)
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
}
