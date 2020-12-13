//
//  JKOMiniAppLogicHandler+CallFunctionHandler.swift
//  JKOJSBridge
//
//  Created by chiehchun.lee on 2020/12/12.
//

import Foundation
import JavaScriptCore

extension JKOMiniAppLogicHandler : JKBDispatcherPageCallFunctionHandler {
    public func handleCallFunctionEvent(_ functionName:String, with arguments:[Any])->JSValue? {
        return self.pageWorker.callJSFunction(functionName, with: arguments)
    }
}
