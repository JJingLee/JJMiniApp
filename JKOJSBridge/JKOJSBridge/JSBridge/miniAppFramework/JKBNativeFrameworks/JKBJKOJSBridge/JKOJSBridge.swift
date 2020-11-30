//
//  JKBJSBridge.swift
//  JKOJSBridge
//
//  Created by chiehchun.lee on 2020/11/25.
//

import Foundation
@objc public protocol JKBJSBridgeProtocol : JKOJSExport {
    static func updateComponent(_ componentKey : String, _ context : String)
}
@objc public class JKBJSBridge : NSObject,JKBJSBridgeProtocol {
    public class func updateComponent(_ componentKey : String, _ context : String) {
        JKOMiniApp.currentActiveMiniApp?.runtime?.updateComponentValue(componentKey: componentKey, context: context)
    }
}
public class JKBJSBridgeFramework : NSObject, JKBNativeFrameworkProtocol {
    public var jsScript : String? = nil
    public var interfaceClass : AnyClass = JKBJSBridge.self
    public var keyedSubscript : String = "JSBridge"
}
