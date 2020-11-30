//
//  JKOMiniApp.swift
//  JKOJSBridge
//
//  Created by chiehchun.lee on 2020/11/24.
//

import Foundation
import WebKit

public class JKOMiniApp : NSObject {
    static var currentActiveMiniApp : JKOMiniApp? = nil
    let webView : WKWebView
    private lazy var launcher = miniAppLauncher(miniApp: self)
    public var worker = JKOJSWorker.default
    //js bridge ability
    public var runtime : JKBJSBridgeRuntime?

    public init(webview : WKWebView) {
        self.webView = webview
    }
    //MARK: - Launch
    public func launchMiniAppFrameworks() {
        launcher.launchMiniAppFrameworks()
    }
}
