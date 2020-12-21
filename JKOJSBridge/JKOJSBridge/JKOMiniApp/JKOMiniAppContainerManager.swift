//
//  JKOMiniAppContainerManager.swift
//  JKOJSBridge
//
//  Created by chiehchun.lee on 2020/12/11.
//

import Foundation

public class JKOMiniAppContainerManager: NSObject {
    static public let shared = JKOMiniAppContainerManager()
    public var currentActiveMiniApp : JKOMiniAppContainerViewController? = nil
    private var miniApps : [String:JKOMiniAppContainerViewController] = [:]
    public func miniAppPage(with appID:String)->JKOMiniAppContainerViewController {
        guard let miniAppPage = miniApps[appID] else {
            let newPage = createMiniAppPage(with: appID)
            miniApps[appID] = newPage
            return newPage
        }
        return miniAppPage
    }
    private func createMiniAppPage(with appID:String)->JKOMiniAppContainerViewController {
        let miniapp = JKOMiniAppContainerViewController()
        miniapp.appID = appID
        return miniapp
    }
}
