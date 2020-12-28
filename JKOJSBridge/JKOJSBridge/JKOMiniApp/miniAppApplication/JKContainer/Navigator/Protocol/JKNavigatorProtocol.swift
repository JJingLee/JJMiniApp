//
//  JKNavigatorProtocol.swift
//  JKOJSBridge
//
//  Created by Lien-Tai Kuo on 2020/12/21.
//

import Foundation

protocol JKNavigatorProtocol:NSObject {

    func setConfig(_ data: [String : Any])

    func setNavigationBarTitle(_ title: String)
    func setNavigationBarColor(_ backgroundColor: String)
    func hideHomeButton()

    func setBackBehavior(_ backCompletion: @escaping (() -> Void))
}
