//
//  JKNavigatorHandler.swift
//  JKOJSBridge
//
//  Created by Lien-Tai Kuo on 2020/12/21.
//

import Foundation
import UIKit

enum JKNavigatorTextStype: String {
    case black = "black"
    case white = "white"

    var barStyle: UIBarStyle {
        switch self {
        case .black:
            return .default
        case .white:
            return .black
        }
    }
}

class JKNavigatorHandler: JKNavigatorProtocol {

    var navigationController: UINavigationController? {
        return viewController?.navigationController
    }
    weak var viewController: UIViewController?
    var backCompletion: (() -> Void)? {
        didSet {
            updateBackButtom()
        }
    }

    init(viewController: UIViewController) {
        self.viewController = viewController
    }

    func setConfig(_ data: [String : Any]) {

        guard let windowObject = data["window"] as? [String: Any] else { return }

        navigationController?.navigationBar.isTranslucent = false

        if let hexColor = windowObject["navigationBarBackgroundColor"] as? String {
            navigationController?.navigationBar.barTintColor = UIColor.hexStringToUIColor(hex: hexColor)
        }

        if let title = windowObject["navigationBarTitleText"] as? String {
            viewController?.title = title
        }

        if let textStyleStr = windowObject["navigationBarTextStyle"] as? String,
           let textStyle = JKNavigatorTextStype(rawValue: textStyleStr) {
            navigationController?.navigationBar.barStyle = textStyle.barStyle
        }
    }

    func setNavigationBarTitle(_ title: String) {
        viewController?.title = title
    }

    func setNavigationBarColor(_ backgroundColor: String) {
        navigationController?.navigationBar.barTintColor = UIColor.hexStringToUIColor(hex: backgroundColor)
    }

    func hideHomeButton() {
        viewController?.navigationItem.leftBarButtonItem = nil
        viewController?.navigationItem.hidesBackButton = true
    }

    func setBackBehavior(_ backCompletion: @escaping (() -> Void)) {
        self.backCompletion = backCompletion
    }

    func updateBackButtom() {
        if backCompletion != nil {
            let leftItem = UIBarButtonItem(image: UIImage(named: "icons8-back-24")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(handleBackTapped))
            viewController?.navigationItem.leftBarButtonItem = leftItem
        } else {
            hideHomeButton()
        }
    }

    @objc func handleBackTapped() {
        backCompletion?()
    }

}
