//
//  JKBInterface.swift
//  JKOJSBridge
//
//  Created by Lien-Tai Kuo on 2020/12/22.
//

import Foundation

@objc public protocol JKBInterfaceProtocol : JKOJSExport {
    static func showTabBarRedDot(_ index: Int)
    static func showTabBar(_ animation: Bool)
    static func setTabBarStyle(_ color: String, _ selectedColor: String, _ backgroundColor: String, _ borderStyle: String)
    static func setTabBarItem(_ index: Int, _ text: String, _ iconPath: String, _ selectedIconPath: String)
    static func setTabBarBadge(_ index: Int, _ text: String)
    static func removeTabBarBadge(_ index: Int)
    static func hideTabBarRedDot(_ index: Int)
    static func hideTabBar(_ animation: Bool)
}
@objc public class JKBInterface : NSObject,JKBInterfaceProtocol {
    public static func showTabBarRedDot(_ index: Int) {
        JKOMiniAppContainerManager.shared.currentActiveMiniApp?.jkTabBar?.showTabBarRedDot(index)
    }

    public static func showTabBar(_ animation: Bool) {
        JKOMiniAppContainerManager.shared.currentActiveMiniApp?.jkTabBar?.showTabBar(animation)
    }

    public static func setTabBarStyle(_ color: String, _ selectedColor: String, _ backgroundColor: String, _ borderStyle: String) {
        JKOMiniAppContainerManager.shared.currentActiveMiniApp?.jkTabBar?.setTabBarStyle(color, selectedColor: selectedColor, backgroundColor: backgroundColor, borderStyle: borderStyle)
    }

    public static func setTabBarItem(_ index: Int, _ text: String, _ iconPath: String, _ selectedIconPath: String) {
        JKOMiniAppContainerManager.shared.currentActiveMiniApp?.jkTabBar?.setTabBarItem(index, text: text, iconPath: iconPath, selectedIconPath: selectedIconPath)
    }

    public static func setTabBarBadge(_ index: Int, _ text: String) {
        JKOMiniAppContainerManager.shared.currentActiveMiniApp?.jkTabBar?.setTabBarBadge(index, text: text)
    }

    public static func removeTabBarBadge(_ index: Int) {
        JKOMiniAppContainerManager.shared.currentActiveMiniApp?.jkTabBar?.removeTabBarBadge(index)
    }

    public static func hideTabBarRedDot(_ index: Int) {
        JKOMiniAppContainerManager.shared.currentActiveMiniApp?.jkTabBar?.hideTabBarRedDot(index)
    }

    public static func hideTabBar(_ animation: Bool) {
        JKOMiniAppContainerManager.shared.currentActiveMiniApp?.jkTabBar?.hideTabBar(animation)
    }
}
public class JKBInterfaceFramework : NSObject, JKBNativeFrameworkProtocol {
    public var jsScript : String? = nil
    public var interfaceClass : AnyClass = JKBInterface.self
    public var keyedSubscript : String = "JKBInterface"
}
