//
//  JKOMiniAppLifeCycleHandler.swift
//  JKOJSBridge
//
//  Created by chiehchun.lee on 2020/12/1.
//

import Foundation

public class JKOMiniAppLifeCycleHandler : NSObject {
    private weak var miniApp : JKOMiniApp?
    init(miniApp:JKOMiniApp) {
        super.init()
        self.miniApp = miniApp
        let ApplifeCycle = JKOMiniAppLifeCycleJSScripts.appLifeCycleCoreJS()
        miniApp.worker.evaluateJS(ApplifeCycle)
    }
    public func configAppID(_ appID : String) {
        let produceApp = JKOMiniAppLifeCycleJSScripts.initialAppLifeCycle(with:appID)
        miniApp?.worker.evaluateJS(produceApp)
    }
    public func callOnLaunch() {
        let callOnlaunch = JKOMiniAppLifeCycleJSScripts.callOnlaunchScript()
        miniApp?.worker.evaluateJS(callOnlaunch)
    }
    public func callOnShow() {
        let callOnShow = JKOMiniAppLifeCycleJSScripts.callOnShowScript()
        miniApp?.worker.evaluateJS(callOnShow)
    }
    public func callOnHide() {
        let callOnHide = JKOMiniAppLifeCycleJSScripts.callOnHideScript()
        miniApp?.worker.evaluateJS(callOnHide)
    }
    public func callOnError() {
        let callOnError = JKOMiniAppLifeCycleJSScripts.callOnErrorScript()
        miniApp?.worker.evaluateJS(callOnError)
    }
}
enum JKOMiniAppLifeCycleJSScripts {
    static func appLifeCycleCoreJS()->String {
        return """
            class ApplifeCycle {
              constructor(id) {
                this.appId = id
              }

              onLaunch(onLaunchClosure) {
                this.onLaunch = onLaunchClosure;
                return this;
              }
              onShow(onShowClosure) {
                this.onShow = onShowClosure;
                return this;
              }
              onHide(onHideClosure) {
                this.onHide = onHideClosure;
                return this;
              }
              onError(onErrorClosure) {
                this.onError = onErrorClosure;
                return this;
              }


              native_onLaunch() {
                if (typeof this.onLaunch === 'function'){
                    this.onLaunch();
                  }
              }
              native_onShow() {
                if (typeof this.onShow === 'function'){
                    this.onShow();
                  }
              }
              native_onHide() {
                if (typeof this.onHide === 'function'){
                    this.onHide();
                  }
              }
              native_onError() {
                if (typeof this.onError === 'function'){
                    this.onError();
                  }
              }

            };
        """
    }
    static func initialAppLifeCycle(with appID : String)->String {
        return """
            var miniapp = new ApplifeCycle("\(appID)");
        """
    }
    static func callOnlaunchScript()->String {
        return """
            miniapp.native_onLaunch()
        """
    }
    static func callOnShowScript()->String {
        return """
            miniapp.native_onShow()
        """
    }
    static func callOnHideScript()->String {
        return """
            miniapp.native_onHide()
        """
    }
    static func callOnErrorScript()->String {
        return """
            miniapp.native_onError()
        """
    }
}
