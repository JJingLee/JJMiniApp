//
//  miniAppLauncher.swift
//  JKOJSBridge
//
//  Created by chiehchun.lee on 2020/11/25.
//

import Foundation

public class miniAppLauncher : NSObject {
    private weak var miniApp : JKOMiniApp?
    //frameworks
    private var jkbAccount = JKBAccount()
    private var jkbJsBridge = JKBJSBridgeFramework()
    private var jkbMonitor = JKBMonitorFramework()
    init(miniApp:JKOMiniApp) {
        super.init()
        self.miniApp = miniApp
    }
    public func launchMiniAppFrameworks() {
        JKB_log("start launching frameworks...")
        importJKBDispatcher()
        importNativeFrameworks()
    }
    public func importJKBDispatcher() {
        JKB_log("launching dispatcher...")
        guard let _miniApp = self.miniApp else {
            JKB_log("<!> dispatcher launch failed")
            return
        }
        _miniApp.dispatcher = JKBDispatcher(webview:_miniApp.webView, worker:_miniApp.worker)
        _miniApp.dispatcher?.importCallFunctionAbility()
        JKB_log("dispatcher launch done")
    }
    private func importNativeFrameworks() {
        JKB_log("launching native frameworks...")
        miniApp?.worker.importNativeFrameworks([
            self.jkbAccount,
            self.jkbJsBridge,
            self.jkbMonitor,
        ])
        JKB_log("native frameworks launch done")
    }
}
