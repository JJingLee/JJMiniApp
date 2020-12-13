//
//  JKOMiniAppRenderer+CallFunction.swift
//  JKOJSBridge
//
//  Created by chiehchun.lee on 2020/12/12.
//

import Foundation

extension JKOMiniAppRenderer {

    private static var callFunctionBridgeScript : String = { Bundle.main.fetchJSScript(with: "callFunctionEventPoster") ?? "" }()

    func registCallFuncInterfaceInWebView() {
        webView.jko_jsbridge.registJSScript(JKOMiniAppRenderer.callFunctionBridgeScript)
    }
    func listenCallFuncEventInWebView(){
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
