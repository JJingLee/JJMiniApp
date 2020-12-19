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
    public lazy var appWorker = JKOMAAppWorker(appID: appID)  //app layer jscore
    public lazy var pageWorker : JKMAPageWorker = {
        let worker = JKMAPageWorker(appID: appID, pageID: JKOMAFirstPageName)  //page layer jscore
        syncGlobalData(from: appWorker, to: worker)
        return worker
    }()

    private var pageWorkerFrameworks : [JKBNativeFrameworkProtocol] = []

    public func refreshPageWorker(with appID : String, pageID:String) {
        self.appID = appID
        pageWorker = JKMAPageWorker(appID: appID,pageID: pageID)
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
}
