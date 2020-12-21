//
//  DataBinderHandlerManager.swift
//  JKOJSBridge
//
//  Created by chiehchun.lee on 2020/12/19.
//

import Foundation
public class DataBinderHandlerManager : NSObject {
    public static let shared : DataBinderHandlerManager = DataBinderHandlerManager()
    private var dataBinders : [String : DataBindingHandler] = [:]
    public func dataBinder(appID : String)->DataBindingHandler {
        defer { objc_sync_exit(self) }
        objc_sync_enter(self)
        guard let dataBinder = dataBinders[appID] else {
            let newBinder = DataBindingHandler(appID: appID)
            dataBinders[appID] = newBinder
            return newBinder
        }
        return dataBinder
    }
    //Not requied actually, swift array is imp by struct, only for remind
    public func releaseDataBinder(appID : String) {
        defer { objc_sync_exit(self) }
        objc_sync_enter(self)
        dataBinders[appID] = nil
    }
}
