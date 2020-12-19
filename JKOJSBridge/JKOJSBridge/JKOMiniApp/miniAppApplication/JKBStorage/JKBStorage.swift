//
//  JKBStorage.swift
//  JKOJSBridge
//
//  Created by chiehchun.lee on 2020/12/15.
//

import Foundation
@objc public protocol JKBStorageProtocol : JKOJSExport {
    static func setGlobalData(_ appID : String, _ object : Any)
    static func getGlobalData(_ appID: String)->Any?
}
@objc public class JKBStorage : NSObject,JKBStorageProtocol {
    public static func setGlobalData(_ appID: String, _ object: Any) {
        DataBinderHandlerManager.dataBinder(appID: appID).update(object, with: JKO_GlobalDataKey_20201217(appID))
    }

    public static func getGlobalData(_ appID: String) -> Any? {
        return JKOMiniAppContainerManager.shared.miniAppPage(with: appID).logicHandler?.getGlobalData()
    }

}
public class JKBStorageFramework : NSObject, JKBNativeFrameworkProtocol {
    public var jsScript : String? = nil
    public var interfaceClass : AnyClass = JKBStorage.self
    public var keyedSubscript : String = "JKBStorage"
}
