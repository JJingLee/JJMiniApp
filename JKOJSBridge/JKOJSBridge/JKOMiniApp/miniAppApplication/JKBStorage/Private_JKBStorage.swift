//
//  Private_JKBStorage.swift
//  JKOJSBridge
//
//  Created by chiehchun.lee on 2020/12/15.
//

import Foundation
@objc public protocol Private_JKBStorageProtocol : JKOJSExport {
    static func setGlobalData(_ appID : String, _ object : Any)
    static func getGlobalData(_ appID: String)->Any?
    static func updatePageData(_ appID : String, _ pageRoute : String, _ key:String, _ object : Any)
    static func getPageData(_ appID : String,_ pageRoute: String)->Any?
}
@objc public class Private_JKBStorage : NSObject,Private_JKBStorageProtocol {
    public static func setGlobalData(_ appID: String, _ object: Any) {
        DataBinderHandlerManager.shared.dataBinder(appID: appID).update(object, with: JKO_GlobalDataKey_20201217(appID))
    }
    public static func getGlobalData(_ appID: String) -> Any? {
        return JKOMiniAppContainerManager.shared.miniAppPage(with: appID).logicHandler.getGlobalData()
    }
    public static func updatePageData(_ appID : String, _ pageRoute : String, _ key:String, _ object : Any) {
        if let _object = object as? [String:Any] {
            let pageData = PageDataUpdateStruct(updateKey: key, dataObject: _object)
            DataBinderHandlerManager.shared.dataBinder(appID: appID).update(pageData, with: JKO_PageSimpleBindingDataKey_20201217(appID))
        }
    }
    public static func getPageData(_ appID : String,_ pageRoute: String)->Any? {
        return JKOMiniAppContainerManager.shared.miniAppPage(with: appID).logicHandler.getPageData(pageRoute)
    }
}
public class Private_JKBStorageFramework : NSObject, JKBNativeFrameworkProtocol {
    public var jsScript : String? = nil
    public var interfaceClass : AnyClass = Private_JKBStorage.self
    public var keyedSubscript : String = "Private_JKBStorage"
}
