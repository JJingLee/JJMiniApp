//
//  JKMiniTabBarHandler.swift
//  JKOJSBridge
//
//  Created by Lien-Tai Kuo on 2020/12/15.
//

import Foundation
import UIKit

class JKMiniTabBarHandler: UIView, JKTabBarProtocol {

    let tabBar: UITabBar = UITabBar()
    let safeAreaView: UIView = UIView()

    // MARK: - Properties
    var tabBarItemDict: [String: UITabBarItem] = [:]
    weak var customDelegate: JKTabBarDelegate?

    // MARK: - Initializer
    init(data: [String : Any]) {
        super.init(frame: .zero)
        initLayout()
        let tabBarObject = data//["tabBar"]
        setConfig(tabBarObject)
        tabBar.delegate = self
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func initLayout() {
        let containerStack = UIStackView(arrangedSubviews: [tabBar, safeAreaView])
        containerStack.axis = .vertical

        tabBar.translatesAutoresizingMaskIntoConstraints = false
        tabBar.heightAnchor.constraint(equalToConstant: 49).isActive = true

        let bottomPadding = UIApplication.shared.windows.filter {$0.isKeyWindow}.first?.safeAreaInsets.bottom ?? 0
        safeAreaView.translatesAutoresizingMaskIntoConstraints = false
        safeAreaView.heightAnchor.constraint(equalToConstant: bottomPadding).isActive = true

        addSubview(containerStack)
        containerStack.translatesAutoresizingMaskIntoConstraints = false
        containerStack.topAnchor.constraint(equalTo: topAnchor).isActive = true
        containerStack.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        containerStack.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        containerStack.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
    }

    // MARK: - Public methods
    func setConfig(_ tabBarObject: [String : Any]) {

        tabBar.isTranslucent = false

        if let hexColor = tabBarObject["color"] as? String {
            tabBar.unselectedItemTintColor = UIColor.hexStringToUIColor(hex: hexColor)
        }

        if let hexColor = tabBarObject["backgroundColor"] as? String {
            tabBar.barTintColor = UIColor.hexStringToUIColor(hex: hexColor)
        }

        if let selectedHexColor = tabBarObject["selectedColor"] as? String {
            tabBar.tintColor = UIColor.hexStringToUIColor(hex: selectedHexColor)
        }

        guard let lists = tabBarObject["list"] as? [[String: Any]] else { return }

        setPageConfig(lists)
    }

    func setPageConfig(_ lists: [[String : Any]]) {
        let keys = lists.compactMap({ $0["pagePath"] as? String })
        let tabBarItems = lists.map({ createTabBarItem(object: $0) })
        tabBar.setItems(tabBarItems, animated: true)
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
        tabBar.unselectedItemTintColor = UIColor.hexStringToUIColor(hex: color)
        tabBar.tintColor = UIColor.hexStringToUIColor(hex: selectedColor)
        tabBar.barTintColor = UIColor.hexStringToUIColor(hex: backgroundColor)
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
        tabBar.selectedItem = tabBarItem
    }

    func getIndexWithRoute(_ url: String) -> Int? {
        guard let tabBarItem = tabBarItemDict[url],
              let index = tabBar.items?.firstIndex(where: { $0 == tabBarItem }) else { return nil }
        return index
    }

    func getPagesCount() -> Int? {
        return tabBar.items?.count
    }

    func getRouteWithIndex(_ index: Int) -> String? {
        guard let count = tabBar.items?.count,
            count > index,
            let item = tabBar.items?[index] else { return nil }
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
        guard let items = tabBar.items,
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
