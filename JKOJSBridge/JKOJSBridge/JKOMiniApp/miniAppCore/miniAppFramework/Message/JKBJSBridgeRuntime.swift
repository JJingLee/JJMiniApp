//
//  JKBJSBridgeRuntime.swift
//  JKOJSBridge
//
//  Created by chiehchun.lee on 2020/11/24.
//

import Foundation
import WebKit

public class JKBJSBridgeRuntime: NSObject {
    var webView : WKWebView
    var worker : JKOJSWorker

    public init(webview : WKWebView, worker:JKOJSWorker) {
        self.webView = webview
        self.worker = worker
    }

    //MARK: - update Value
    public func updateComponentValue(componentKey : String, context : String) {
        self.webView.evaluateJavaScript("document.getElementById('\(componentKey)').innerHTML = '\(context)';") { (_, _) in }
    }

    //MARK: - callFunctions
    private let callFunctionBridgeScript : String = """
                function callFunc(component,funcName, ...args) {
                    var componentKey = component.id;
                    var argsStr = args.join(',');
                    // 從JS傳送資訊到App裡設定的callbackHandler。
                    window.webkit.messageHandlers.callFunction.postMessage(componentKey + "," + funcName + "," + argsStr);
                }
        """
    func importCallFunctionAbility() {
        webView.jko_jsbridge.registJSScript(callFunctionBridgeScript)
        addCallFunctionEventHandler()
    }
    private func addCallFunctionEventHandler() {
        webView.jko_jsbridge.addHandler(with: "callFunction") { [weak self](data) in
            JKB_log("callFunction : \(data)")
            guard let params = self?.parseCallFunctionMsg(data) else {return}
            self?.handlesCallFuntionAction(callerID: params.0, functionName: params.1, args: params.2)
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
    private func handlesCallFuntionAction(callerID : String, functionName : String, args:[Any]) {
        if let result = self.worker.callJSFunction(functionName, with: args)?.toBool() {
            print("result : \(result)")
        }
    }
}
