//
//  JKBDispatcher.swift
//  JKOJSBridge
//
//  Created by chiehchun.lee on 2020/11/24.
//

import Foundation
import WebKit
import JavaScriptCore

public protocol JKBDispatcherRendererImp : NSObject {
    func updateInnerHTML(componentKey : String, context : String)
}
public protocol JKBDispatcherPageCallFunctionHandler : NSObject {
    func handleCallFunctionEvent(_ functionName:String, with arguments:[Any])->JSValue?
}
public class JKBDispatcher: NSObject {
    weak var renderer : JKBDispatcherRendererImp?
    weak var pageCallFunctionHandler : JKBDispatcherPageCallFunctionHandler?

    //MARK: - update Value
    public func updateComponentValue(componentKey : String, context : String) {
        renderer?.updateInnerHTML(componentKey: componentKey, context: context)
    }
    public func bindRenderer(_ renderer : JKOMiniAppRenderer) {
        self.renderer = renderer
        renderer.callFunctionListener = self
        renderer.startListensCallFunction()
    }
    public func bindCallFunctionHandler(_ callFunHandler:JKBDispatcherPageCallFunctionHandler) {
        self.pageCallFunctionHandler = callFunHandler
    }
}
extension JKBDispatcher : JKOMiniAppRendererCallFuncListener {
    public func handlesCallFuntionAction(callerID : String, functionName : String, args:[Any]) {
        if let result = self.pageCallFunctionHandler?.handleCallFunctionEvent(functionName, with: args)?.toBool() {
            print("result : \(result)")
        }
    }
}
