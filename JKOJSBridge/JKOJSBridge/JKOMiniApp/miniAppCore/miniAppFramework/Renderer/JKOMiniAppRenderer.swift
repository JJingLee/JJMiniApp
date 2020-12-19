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

    weak var callFunctionListener : JKOMiniAppRendererCallFuncListener?
    public func startListensCallFunction() {
        registCallFuncInterfaceInWebView()
        listenCallFuncEventInWebView()
    }
}
//WKBackForwardList
class webViewDelegater : NSObject, WKNavigationDelegate, WKUIDelegate {

}