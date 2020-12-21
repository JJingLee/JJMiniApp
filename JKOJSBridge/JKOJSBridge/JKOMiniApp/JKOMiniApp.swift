//
//  JKOMiniApp.swift
//  JKOJSBridge
//
//  Created by chiehchun.lee on 2020/12/19.
//

import Foundation

public class JKOMiniApp:NSObject {
    public static func miniAppPage(with appID:String)->JKOMiniAppContainerViewController {
        let miniapp = JKOMiniAppContainerManager.shared.miniAppPage(with: appID)
        return miniapp
    }
}
