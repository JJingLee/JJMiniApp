//
//  JKContainer.swift
//  JKOJSBridge
//
//  Created by Lien-Tai Kuo on 2020/12/15.
//

import Foundation
import UIKit

class JKContainer: NSObject {

    static public func createTabBar(_ config: [String : Any]?) -> (UIView & JKTabBarProtocol)? {
        let jkTabBar = JKMiniTabBarHandler(data: config)
        return jkTabBar
    }

    static public func createNavigator(_ viewController: UIViewController, config: [String : Any]?) -> JKNavigatorProtocol {
        let jkNavigator = JKNavigatorHandler(viewController: viewController)
        if let data = config {
            jkNavigator.setConfig(data)
        }
        return jkNavigator

    }
}
