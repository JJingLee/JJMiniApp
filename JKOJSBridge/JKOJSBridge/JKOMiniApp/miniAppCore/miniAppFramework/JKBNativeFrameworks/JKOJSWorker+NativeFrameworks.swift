//
//  JKOJSWorker+NativeFrameworks.swift
//  JKOJSBridge
//
//  Created by chiehchun.lee on 2020/11/24.
//

import Foundation
import WebKit

extension JKOJSWorker {
    public func importNativeFrameworks(_ frameworks : [JKBNativeFrameworkProtocol]) {
        for framework in frameworks {
            JKB_log("launching \(framework.keyedSubscript)...")
            self.importFramework(framework.interfaceClass, keyedSubscript: framework.keyedSubscript)
            if let script = framework.jsScript {
                self.evaluateJS(script)
            }
        }
    }
}
