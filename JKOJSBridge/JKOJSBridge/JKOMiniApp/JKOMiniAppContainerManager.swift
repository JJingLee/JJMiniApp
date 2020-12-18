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
    public func miniApp(by appID:String)->JKOMiniAppContainerViewController? {
        return currentActiveMiniApp//TODO:Manage by ID
    }
}
