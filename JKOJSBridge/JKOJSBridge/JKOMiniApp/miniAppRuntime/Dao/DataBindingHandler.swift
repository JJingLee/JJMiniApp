//
//  DataBindingHandler.swift
//  JKOJSBridge
//
//  Created by chiehchun.lee on 2020/12/17.
//

import Foundation

public protocol miniAppDataBindingObserver:NSObject {
    func updateData(_ data:Any?)
}

public class DataBindingHandler : NSObject {
    var appID : String
    var observers : Dictionary<String,[miniAppDataBindingObserver]> = [:]

    init(appID : String) {
        self.appID = appID
    }
    func addObserver(_ observer : miniAppDataBindingObserver, with key:String) {
        defer { objc_sync_exit(self) }
        objc_sync_enter(self)
        var keyObservers = observers[key] ?? []
        if keyObservers.contains(where: {$0===observer}) == false {
            keyObservers.append(observer)
        }
        guard keyObservers.count > 0 else {return}
        observers[key] = keyObservers
    }

    func update(_ data:Any, with key:String) {
        defer { objc_sync_exit(self) }
        objc_sync_enter(self)
        guard let keyObservers = observers[key] else {return}
        for observer in keyObservers {
            observer.updateData(data)
        }
    }

}
