//
//  JKContainer.swift
//  JKOJSBridge
//
//  Created by Lien-Tai Kuo on 2020/12/15.
//

import Foundation
import UIKit

class JKContainer: NSObject {

    static public func createTabBar(_ config: [String : Any]?) -> (UITabBar & JKTabBarProtocol)? {
        let jkTabBar = JKMiniTabBarHandler(data: config)
        return jkTabBar
    }
}
