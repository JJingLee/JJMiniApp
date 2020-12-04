//
//  JKOJSBridgeWebExtensions.swift
//  JKOJSBridge
//
//  Created by chiehchun.lee on 2020/11/23.
//

import Foundation
import WebKit

extension WKWebView {
    @objc public var jko_jsbridge : JKOJSBridgeWebViewDSL { JKOJSBridgeWebViewDSL(webview: self) }
    @objc static public var jko_jsbridge : JKOJSBridgeWebViewDSL.Type { JKOJSBridgeWebViewDSL.self }
}

//MARK: - +Observers
extension WKWebView {

    private static let jkoJSMsgObserverKey = "jkoJSMsgObserverKey"
    func setJSFunctionCallingObserver(_ observer:JKOJSFunctionObserver, with key:String) {
        objc_setAssociatedObject(self, "\(WKWebView.jkoJSMsgObserverKey)_\(key)", observer, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    }
    func getJSFunctionCallingObserver(with key:String)->JKOJSFunctionObserver? {
       return objc_getAssociatedObject(self, "\(WKWebView.jkoJSMsgObserverKey)_\(key)") as? JKOJSFunctionObserver
    }
}
