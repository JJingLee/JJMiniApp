//
//  JKMAPageWorker.swift
//  JKOJSBridge
//
//  Created by chiehchun.lee on 2020/12/10.
//

import Foundation
public class JKMAPageWorker : JKOJSWorker {
    var pageID : String = ""
    init(appID: String, pageID:String) {
        super.init(appID: appID)
        self.pageID = pageID
        moduleHandler.launchFile("PageLifeCycle")
        callInit()
        listensToGlobalData()
    }
    private func callInit() {
        _ = self.callJSFunction("JKInitialPageLifeCycle", with: [appID, pageID])
    }
    public func callOnLoad() {
        _ = self.callJSFunction("JKPageOnLoad", with: [])
    }
    public func callOnShow() {
        _ = self.callJSFunction("JKPageOnShow", with: [])
    }
    public func callOnReady() {
        _ = self.callJSFunction("JKPageOnReady", with: [])
    }
    public func callOnHide() {
        _ = self.callJSFunction("JKPageOnHide", with: [])
    }
    public func callOnError() {
        _ = self.callJSFunction("JKPageOnError", with: [])
    }
}
