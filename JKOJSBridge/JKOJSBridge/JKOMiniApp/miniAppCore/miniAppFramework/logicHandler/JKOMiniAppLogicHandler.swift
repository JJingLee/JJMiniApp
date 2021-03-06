//
//  JKOMiniAppLogicHandler.swift
//  JKOJSBridge
//
//  Created by chiehchun.lee on 2020/11/24.
//

import Foundation
public class JKOMiniAppLogicHandler : NSObject {

    public var appID : String = ""
    //MARK: Workers
    public var appWorker : JKOMAAppWorker
    public var pageWorker : JKMAPageWorker

    init(appID:String) {
        self.appID = appID
        self.appWorker = JKOMAAppWorker(appID: appID)
        self.pageWorker = JKMAPageWorker(appID: appID, pageID: JKOMAFirstPageName)  //page layer jscore
        super.init()
        syncGlobalData(from: appWorker, to: pageWorker)
    }
    public func refreshPageWorker(with appID : String, pageID:String) {
        self.appID = appID
        let _domSetter : (String, String)->Void = pageWorker.pageSimpleDataBinder.domSetter
        pageWorker = JKMAPageWorker(appID: appID,pageID: pageID)
        pageWorker.pageSimpleDataBinder.domSetter = _domSetter
        syncGlobalData(from: appWorker, to: pageWorker)
    }
    public func syncGlobalData(from appworker : JKOMAAppWorker, to pageworker : JKMAPageWorker) {
        if let currentGlobalData = appworker.getGlobalData() {
            pageworker.updateGlobalData(currentGlobalData)
        }
    }
    //MARK: - data binder
    public func getGlobalData()->Any? {
        return appWorker.getGlobalData()
    }
    public func rebootGlobalData() {
        appWorker.rebootGlobalData()
    }
    public func setPageData(_ pageRouter : String, pageData : [String:Any]) {
        self.pageWorker.setPageData(pageData)
    }
    public func getPageData(_ pageRoute : String)->[String:Any]? {
        return self.pageWorker.getPageData()
    }
}
