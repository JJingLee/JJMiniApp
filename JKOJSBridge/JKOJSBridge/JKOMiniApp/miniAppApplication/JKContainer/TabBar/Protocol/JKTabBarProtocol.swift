//
//  JKTabBarProtocol.swift
//  JKOJSBridge
//
//  Created by Lien-Tai Kuo on 2020/12/15.
//

import Foundation

protocol JKTabBarDelegate: AnyObject {
    func tabBar(_ route: String)
}

protocol JKTabBarProtocol {
    var customDelegate: JKTabBarDelegate? { get set }

    func setConfig(_ tabBarObject: [String : Any])
    func setPageConfig(_ lists: [[String : Any]])

    func showTabBarRedDot(_ index: Int)
    func showTabBar(_ animation: Bool)
    func setTabBarStyle(_ color: String, selectedColor: String, backgroundColor: String, borderStyle: String)
    func setTabBarItem(_ index: Int, text: String, iconPath: String, selectedIconPath: String)
    func setTabBarBadge(_ index: Int, text: String)
    func removeTabBarBadge(_ index: Int)
    func hideTabBarRedDot(_ index: Int)
    func hideTabBar(_ animation: Bool)

    func setSelectedPage(_ url: String)
    func getIndexWithRoute(_ url: String) -> Int?
    func getPagesCount() -> Int?
    func getRouteWithIndex(_ index: Int) -> String?
}
