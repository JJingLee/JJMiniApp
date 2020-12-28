//
//  JKOJSWorker+GlobalData.swift
//  JKOJSBridge
//
//  Created by chiehchun.lee on 2020/12/20.
//

import Foundation

extension JKOJSWorker : miniAppDataBindingObserver {
    static let kHasImportedAppLifeCycle = "kHasImportedAppLifeCycle"
    func hasImportedAppLifeCycle()->Bool {
        return objc_getAssociatedObject(self, JKOJSWorker.kHasImportedAppLifeCycle) != nil
    }
    func setImportedAppLifeCycle() {
        objc_setAssociatedObject(self, JKOJSWorker.kHasImportedAppLifeCycle, true, objc_AssociationPolicy.OBJC_ASSOCIATION_ASSIGN)
    }

    public func listensToGlobalData() {
        //import
        if hasImportedAppLifeCycle()==false {
            moduleHandler.launchFile("AppLifeCycle")
            setImportedAppLifeCycle()
        }
        //bind
        let binder = DataBinderHandlerManager.shared.dataBinder(appID: appID)
        binder.addObserver(self, with: JKO_GlobalDataKey_20201217(appID))
        //init
        _ = self.callJSFunction("initialAppLifeCycle", with: [appID])
    }
    public func updateGlobalData(_ data:Any?) {
        updateData(JKO_GlobalDataKey_20201217(appID),data)
    }
    public func updateData(_ key:String, _ data: Any?) {
        guard let _data = data else {return}
        _ = self.callJSFunction("updateGlobalData", with: [_data])
    }
    public func getGlobalData() ->Any? {
        guard let value = self.callJSFunction("getGlobalData", with: [])?.toDictionary() else {return nil}
        return value
    }
}
