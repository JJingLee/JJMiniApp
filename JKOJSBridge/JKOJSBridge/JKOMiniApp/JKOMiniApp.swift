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

    public private(set) var appID : String = ""

    //MARK: Runtime
    public var lifeCycleHandler : JKOMiniAppLifeCycleHandler?

    //MARK: Kernel
    public var worker = JKOJSWorker.default  //jscore
    public var runtime : JKBJSBridgeRuntime? //WebKit

    //MARK: Utils
    private lazy var launcher = miniAppLauncher(miniApp: self)

    public init(webview : WKWebView) {
        self.webView = webview
    }
    //MARK: - Launch
    public func launchMiniAppFrameworks(with appID : String) {
        self.appID = appID
        launcher.launchMiniAppFrameworks()
    }
}
