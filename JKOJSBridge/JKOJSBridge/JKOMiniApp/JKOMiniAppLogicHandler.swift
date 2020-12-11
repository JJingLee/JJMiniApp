//
//  JKOMiniAppLogicHandler.swift
//  JKOJSBridge
//
//  Created by chiehchun.lee on 2020/11/24.
//

import Foundation
import WebKit
import JavaScriptCore

public class JKOMiniAppLogicHandler : NSObject {

    public private(set) var appID : String = ""

    //MARK: Runtime
    public lazy var appLifeCycleHandler : JKOMiniAppLifeCycleHandler = JKOMiniAppLifeCycleHandler(worker: appWorker)
    public lazy var pageLifeCycleHandler : PageLifeCycleHandler = PageLifeCycleHandler(worker: pageWorker)
    public var appWorker = JKOJSWorker()  //app layer jscore
    public var pageWorker = JKOJSWorker()  //page layer jscore

    //MARK: Kernel
//    public var dispatcher : JKBDispatcher? //WebKit

    //MARK: Utils
//    private lazy var launcher = miniAppLauncher(miniApp: self)

    //MARK: - Launch
    public func activeAppWorker(with appID : String) {
        self.appID = appID
//        launcher.launchMiniAppFrameworks()
        appLifeCycleHandler.configAppID(appID)
    }
    public func activePageWorker(with appID : String, pageID:String) {
        pageLifeCycleHandler.configAppID(appID, pageID)
    }
    public func pageLoadJS(_ js : String) {
        pageWorker.evaluateJS(js)
    }
    public func pageLoadFrameworks(_ frameworks : [JKBNativeFrameworkProtocol]) {
        pageWorker.importNativeFrameworks(frameworks)
    }
    public func appLoadJS(_ js : String) {
        appWorker.evaluateJS(js)
    }
    public func appLoadFrameworks(_ frameworks : [JKBNativeFrameworkProtocol]) {
        JKB_log("miniapp launching native frameworks...")
        appWorker.importNativeFrameworks(frameworks)
        JKB_log("miniapp native frameworks launch done")
    }
}

extension JKOMiniAppLogicHandler : JKBDispatcherPageCallFunctionHandler {
    public func handleCallFunctionEvent(_ functionName:String, with arguments:[Any])->JSValue? {
        return self.pageWorker.callJSFunction(functionName, with: arguments)
    }
    
}
