//
//  JKBJSBridge.swift
//  JKOJSBridge
//
//  Created by chiehchun.lee on 2020/11/25.
//

import Foundation
@objc public protocol JKBDomProtocol : JKOJSExport {
    static func updateComponent(_ componentKey : String, _ context : String)
}
@objc public class JKBDom : NSObject,JKBDomProtocol {
    public class func updateComponent(_ componentKey : String, _ context : String) {
        JKOMiniAppContainerManager.shared.currentActiveMiniApp?.dispatcher.updateComponentValue(componentKey: componentKey, context: context)
    }
}
public class JKBJSBridgeFramework : NSObject, JKBNativeFrameworkProtocol {
    public var jsScript : String? = nil
    public var interfaceClass : AnyClass = JKBDom.self
    public var keyedSubscript : String = "JKBDom"
}
