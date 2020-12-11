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
    public func render(with htmlURL : URL) {
        webView.loadFileURL(htmlURL, allowingReadAccessTo: htmlURL)
        let request = URLRequest(url: htmlURL)
        webView.load(request)
    }
}

extension JKOMiniAppRenderer : JKBDispatcherRendererImp {
    public func updateInnerHTML(componentKey : String, context : String) {
        self.webView.evaluateJavaScript("document.getElementById('\(componentKey)').innerHTML = '\(context)';") { (_, _) in }
    }
}
extension JKOMiniAppRenderer {

    private static let callFunctionBridgeScript : String = """
                function callFunc(component,funcName, ...args) {
                    var componentKey = component.id;
                    var argsStr = args.join(',');
                    // 從JS傳送資訊到App裡設定的callbackHandler。
                    window.webkit.messageHandlers.callFunction.postMessage(componentKey + "," + funcName + "," + argsStr);
                }
        """


    private func registCallFuncInterfaceInWebView() {
        webView.jko_jsbridge.registJSScript(JKOMiniAppRenderer.callFunctionBridgeScript)
    }
    private func listenCallFuncEventInWebView(){
        webView.jko_jsbridge.addHandler(with: "callFunction") { [weak self](data) in
            JKB_log("callFunction : \(data)")
            guard let params = self?.parseCallFunctionMsg(data) else {return}
            self?.callFunctionListener?.handlesCallFuntionAction(callerID: params.0, functionName: params.1, args: params.2)
        }
    }

    private func parseCallFunctionMsg(_ data : Any)->(callerID:String, functionName:String, args:[Any])? {
        guard let message = data as? String else {
            JKB_log("callFuntion with wrong argument formats.")
            return nil
        }
        var args = message.split(separator: ",")
        guard args.count >= 2 else {
            JKB_log("callFuntion with wrong argument formats.")
            return nil
        }
        let _callerID = String(args.removeFirst())
        let _functionName = String(args.removeFirst())
        let _otherArgs = args.reduce(Array<String>()) { (result, argSubtring) -> Array<String> in
            var newResult = result
            newResult.append(String(argSubtring))
            return newResult
        }
        return (_callerID, _functionName, _otherArgs)
    }
}
