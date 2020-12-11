//
//  miniAppLauncher.swift
//  JKOJSBridge
//
//  Created by chiehchun.lee on 2020/11/25.
//

import Foundation

public class miniAppLauncher : NSObject {
    private weak var logicHandler : JKOMiniAppLogicHandler?
    private weak var dispatcher : JKBDispatcher?
    private var nativeFrameworks : [JKBNativeFrameworkProtocol]?
    private weak var renderer : JKOMiniAppRenderer?
    
    init(logicHandler : JKOMiniAppLogicHandler,
         dispatcher : JKBDispatcher,
         renderer : JKOMiniAppRenderer,
         nativeFrameworks : [JKBNativeFrameworkProtocol]) {
        super.init()
        self.logicHandler = logicHandler
        self.dispatcher = dispatcher
        self.nativeFrameworks = nativeFrameworks
        self.renderer = renderer
    }
    public func start() {
        JKB_log("start launching frameworks...")
        
    }
//    public func launchMiniAppFrameworks() {
//        JKB_log("start launching frameworks...")
//        importJKBDispatcher()
//        importNativeFrameworks()
//    }
//    public func importJKBDispatcher() {
//        JKB_log("launching dispatcher...")
////        guard let _logicHandler = self.logicHandler else {
////            JKB_log("<!> dispatcher launch failed")
////            return
////        }
////        _logicHandler.dispatcher = JKBDispatcher(webview:_logicHandler.webView, worker:_logicHandler.appWorker)
////        _logicHandler.dispatcher?.importCallFunctionAbility()
//        JKB_log("dispatcher launch done")
//    }
//    private func importNativeFrameworks() {
//        JKB_log("launching native frameworks...")
//        logicHandler?.appWorker.importNativeFrameworks([
//            self.jkbAccount,
//            self.jkbJsBridge,
//            self.jkbMonitor,
//        ])
//        JKB_log("native frameworks launch done")
//    }
}
