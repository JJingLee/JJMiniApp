//
//  JKBMonitor.swift
//  JKOJSBridge
//
//  Created by chiehchun.lee on 2020/12/1.
//

import Foundation
@objc public protocol JKBMonitorProtocol : JKOJSExport {
    static func log(_ msg : String)
}
@objc public class JKBMonitor : NSObject,JKBMonitorProtocol {
    public static func log(_ msg : String) {
        JKB_userlog(msg)
    }
}
public class JKBMonitorFramework : NSObject, JKBNativeFrameworkProtocol {
    public var jsScript : String? = nil
    public var interfaceClass : AnyClass = JKBMonitor.self
    public var keyedSubscript : String = "JKMonitor"
}
