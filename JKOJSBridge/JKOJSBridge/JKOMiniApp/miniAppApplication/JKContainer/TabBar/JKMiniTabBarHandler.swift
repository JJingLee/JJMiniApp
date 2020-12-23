//
//  JKMiniTabBarHandler.swift
//  JKOJSBridge
//
//  Created by Lien-Tai Kuo on 2020/12/15.
//

import Foundation
import UIKit

class JKMiniTabBarHandler: UITabBar, JKTabBarProtocol {

    // MARK: - Properties
    var tabBarItemDict: [String: UITabBarItem] = [:]
    weak var customDelegate: JKTabBarDelegate?

    init?(data: [String : Any]?) {
        super.init(frame: .zero)
        guard let tabBarObject = data?["tabBar"] as? [String: Any] else { return nil }
        setConfig(tabBarObject)
        delegate = self
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Public methods
    func setConfig(_ tabBarObject: [String : Any]) {

        isTranslucent = false

        if let hexColor = tabBarObject["color"] as? String {
            unselectedItemTintColor = UIColor.hexStringToUIColor(hex: hexColor)
        }

        if let hexColor = tabBarObject["backgroundColor"] as? String {
            barTintColor = UIColor.hexStringToUIColor(hex: hexColor)
        }

        if let selectedHexColor = tabBarObject["selectedColor"] as? String {
            tintColor = UIColor.hexStringToUIColor(hex: selectedHexColor)
        }

        guard let lists = tabBarObject["list"] as? [[String: Any]] else { return }

        setPageConfig(lists)
    }

    func setPageConfig(_ lists: [[String : Any]]) {
        let keys = lists.compactMap({ $0["pagePath"] as? String })
        let tabBarItems = lists.map({ createTabBarItem(object: $0) })
        setItems(tabBarItems, animated: true)
        tabBarItems.enumerated().forEach { (object) in
            guard keys.count > object.offset else { return }
            tabBarItemDict[keys[object.offset]] = object.element
        }
    }

    func showTabBarRedDot(_ index: Int) {
        setTabBarBadge(index, text: " ")
    }

    func showTabBar(_ animation: Bool) {
        self.isHidden = false
    }

    func setTabBarStyle(_ color: String, selectedColor: String, backgroundColor: String, borderStyle: String) {
        // TODO: color
        unselectedItemTintColor = UIColor.hexStringToUIColor(hex: color)
        tintColor = UIColor.hexStringToUIColor(hex: selectedColor)
        barTintColor = UIColor.hexStringToUIColor(hex: backgroundColor)
    }

    func setTabBarItem(_ index: Int, text: String, iconPath: String, selectedIconPath: String) {
        guard let tabBarItem = getTabBarItem(index) else { return }
        tabBarItem.title = text
        tabBarItem.image = UIImage(named: iconPath)?.withRenderingMode(.alwaysOriginal)
        tabBarItem.selectedImage = UIImage(named: selectedIconPath)?.withRenderingMode(.alwaysOriginal)
    }

    func setTabBarBadge(_ index: Int, text: String) {
        guard let tabBarItem = getTabBarItem(index) else { return }
        tabBarItem.badgeValue = text
    }

    func removeTabBarBadge(_ index: Int) {
        guard let tabBarItem = getTabBarItem(index) else { return }
        tabBarItem.badgeValue = nil
    }

    func hideTabBarRedDot(_ index: Int) {
        guard let tabBarItem = getTabBarItem(index) else { return }
        tabBarItem.badgeValue = nil
    }

    func hideTabBar(_ animation: Bool) {
        self.isHidden = true
    }



    func setSelectedPage(_ url: String) {
        guard let tabBarItem = tabBarItemDict[url] else { return }
        selectedItem = tabBarItem
    }

    func getIndexWithRoute(_ url: String) -> Int? {
        guard let tabBarItem = tabBarItemDict[url],
              let index = items?.firstIndex(where: { $0 == tabBarItem }) else { return nil }
        return index
    }

    func getPagesCount() -> Int? {
        return items?.count
    }

    func getRouteWithIndex(_ index: Int) -> String? {
        guard let count = items?.count,
            count > index,
            let item = items?[index] else { return nil }
        return tabBarItemDict.first(where: { $0.value == item })?.key
    }

    // MARK: - Private methods
    private func createTabBarItem(object: [String: Any]) -> UITabBarItem {
        let title = object["text"] as? String
        let iconName = object["iconPath"] as? String
        let image = UIImage(named: iconName ?? "")?.withRenderingMode(.alwaysOriginal)
        let selectedIconName = object["selectedIconPath"] as? String
        let selectedImage = UIImage(named: selectedIconName ?? "")?.withRenderingMode(.alwaysOriginal)
        return UITabBarItem(title: title, image: image, selectedImage: selectedImage)
    }

    private func getTabBarItem(_ index: Int) -> UITabBarItem? {
        guard let items = items,
              items.count > index else { return nil }
        return items[index]
    }
}

extension JKMiniTabBarHandler: UITabBarDelegate {
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        var route: String?
        _ = tabBarItemDict.first { (dict) -> Bool in
            if dict.value == item {
                route = dict.key
                return true
            }
            return false
        }
        guard let _route = route else { return }
        customDelegate?.tabBar(_route)
    }
}
