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

    static func setStorage(_ appID: String, _ key:String, _ object:Any)
    static func getStorage(_ appID: String, _ key:String)->Any?
}
@objc public class JKBStorage : NSObject,JKBStorageProtocol {
    public static func setGlobalData(_ appID: String, _ object: Any) {
        DataBinderHandlerManager.shared.dataBinder(appID: appID).update(object, with: JKO_GlobalDataKey_20201217(appID))
    }
    public static func getGlobalData(_ appID: String) -> Any? {
        return JKOMiniAppContainerManager.shared.miniAppPage(with: appID).logicHandler?.getGlobalData()
    }
    private static let userDefault = UserDefaults.init(suiteName: "miniApp")
    public static func setStorage(_ appID: String, _ key:String, _ object:Any) {
        userDefault?.setValue(object, forKey: "\(appID)_\(key)")
    }
    public static func getStorage(_ appID: String, _ key:String)->Any? {
        userDefault?.object(forKey: "\(appID)_\(key)")
    }
}
public class JKBStorageFramework : NSObject, JKBNativeFrameworkProtocol {
    public var jsScript : String? = nil
    public var interfaceClass : AnyClass = JKBStorage.self
    public var keyedSubscript : String = "JKBStorage"
}
