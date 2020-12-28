//
//  JKOMiniAppRenderer.swift
//  JKOJSBridge
//
//  Created by chiehchun.lee on 2020/12/11.
//

import Foundation
import WebKit

public protocol JKOMiniAppRendererCallFuncListener:NSObject {
    func handlesCallFuntionAction(callerID : String, functionName : String, args:[Any])
}

public class JKOMiniAppRenderer : NSObject  {
    public var webView = WKWebView()
    public func toggleRenderer(_ toggle:@escaping(UIView)->Void) {
        toggle(webView)
    }

    public func setRenderDelegate(navigationDelegate: WKNavigationDelegate?) {
        guard let _navigationDelegate = navigationDelegate else { return }
        webView.navigationDelegate = _navigationDelegate
    }

    weak var callFunctionListener : JKOMiniAppRendererCallFuncListener?
    public func startListensCallFunction() {
        registCallFuncInterfaceInWebView()
        listenCallFuncEventInWebView()
    }
}
//TODO: WKBackForwardList
class webViewDelegater : NSObject, WKNavigationDelegate, WKUIDelegate {

}
