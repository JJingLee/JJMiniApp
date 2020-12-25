//
//  JKBRouter.swift
//  JKOJSBridge
//
//  Created by chiehchun.lee on 2020/12/13.
//

import Foundation
@objc public protocol JKBRouterProtocol : JKOJSExport {
    static func navigateTo(_ route : String)
    static func navigateBack()
    static func switchTab(_ route: String)
}
@objc public class JKBRouter : NSObject,JKBRouterProtocol {
    public static func navigateTo(_ route : String) {
        JKOMiniAppContainerManager.shared.currentActiveMiniApp?.pageRouter?.navigateTo(route)
    }
    public static func navigateBack() {
        JKOMiniAppContainerManager.shared.currentActiveMiniApp?.pageRouter?.navigateBack()
    }
    public static func switchTab(_ route: String) {
        JKOMiniAppContainerManager.shared.currentActiveMiniApp?.pageRouter?.switchTab(route)
    }
}
public class JKBRouterFramework : NSObject, JKBNativeFrameworkProtocol {
    public var jsScript : String? = nil
    public var interfaceClass : AnyClass = JKBRouter.self
    public var keyedSubscript : String = "JKBRouter"
}
