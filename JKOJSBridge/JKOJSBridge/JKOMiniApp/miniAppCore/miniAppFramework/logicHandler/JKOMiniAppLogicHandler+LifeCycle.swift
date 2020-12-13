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
        appLifeCycleHandler.callOnLaunch()
    }
    public func appOnShow() {
        appLifeCycleHandler.callOnShow()
    }
    public func appOnHide() {
        appLifeCycleHandler.callOnHide()
    }
    public func appOnError() {
        appLifeCycleHandler.callOnError()
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
        pageLifeCycleHandler.callOnLoad()
    }

    public func pageOnShow() {
        pageLifeCycleHandler.callOnShow()
    }

    public func pageOnReady() {
        pageLifeCycleHandler.callOnReady()
    }

    public func pageOnHide() {
        pageLifeCycleHandler.callOnHide()
    }

    public func pageOnError() {
        pageLifeCycleHandler.callOnError()
    }
}
