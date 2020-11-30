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
    init(miniApp:JKOMiniApp) {
        super.init()
        self.miniApp = miniApp
    }
    public func launchMiniAppFrameworks() {
        JKB_log("start launching frameworks...")
        importJKBJSBridgeRuntime()
        importNativeFrameworks()
    }
    public func importJKBJSBridgeRuntime() {
        JKB_log("launching runtime...")
        guard let _miniApp = self.miniApp else {
            JKB_log("<!> runtime launch failed")
            return
        }
        _miniApp.runtime = JKBJSBridgeRuntime(webview:_miniApp.webView, worker:_miniApp.worker)
        _miniApp.runtime?.importCallFunctionAbility()
        JKB_log("runtime launch done")
    }
    private func importNativeFrameworks() {
        JKB_log("launching native frameworks...")
        miniApp?.worker.importNativeFrameworks([
            self.jkbAccount,
            self.jkbJsBridge,
        ])
        JKB_log("native frameworks launch done")
    }
}
