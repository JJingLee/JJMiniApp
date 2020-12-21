//
//  JKOMiniAppLogicHandler+LifeCycle.swift
//  JKOJSBridge
//
//  Created by chiehchun.lee on 2020/12/13.
//

import Foundation

public protocol AppLifeCycleProtocol : NSObject {
    func appOnLaunch()
    func appOnShow()
    func appOnHide()
    func appOnError()
}

extension JKOMiniAppLogicHandler : AppLifeCycleProtocol {
    public func appOnLaunch() {
        appWorker.callOnLaunch()
    }
    public func appOnShow() {
        appWorker.callOnShow()
    }
    public func appOnHide() {
        appWorker.callOnHide()
    }
    public func appOnError() {
        appWorker.callOnError()
    }
}

public protocol PageLifeCycleProtocol : NSObject {
    func pageOnLoad()
    func pageOnShow()
    func pageOnReady()
    func pageOnHide()
    func pageOnError()
}

extension JKOMiniAppLogicHandler : PageLifeCycleProtocol {
    public func pageOnLoad() {
        pageWorker.callOnLoad()
    }

    public func pageOnShow() {
        pageWorker.callOnShow()
    }

    public func pageOnReady() {
        pageWorker.callOnReady()
    }

    public func pageOnHide() {
        pageWorker.callOnHide()
    }

    public func pageOnError() {
        pageWorker.callOnError()
    }
}
