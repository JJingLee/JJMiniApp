//
//  JKOJSWorker.swift
//  JKOJSBridge
//
//  Created by chiehchun.lee on 2020/11/23.
//
import Foundation
import JavaScriptCore

public class JKOJSWorker : NSObject {
    public var appID : String
    public let jsVM = JSVirtualMachine()
    public lazy var moduleHandler : JKBCodeModuleHandler = {
        return JKBCodeModuleHandler(worker: self)
    }()
    
    lazy var context : JSContext? = {
        let contxt = JSContext(virtualMachine: jsVM)
        return contxt
    }()
    init(appID : String) {
        self.appID = appID
    }
    public func evaluateJS(_ javaScriptStr : String) {
        context?.evaluateScript(javaScriptStr)
    }
    //Export
    func importFramework(_ classType:AnyClass, keyedSubscript:String) {
        guard let _context = context else {return}
        _context.setObject(classType, forKeyedSubscript: keyedSubscript as NSString)
    }
    func callJSFunction(_ functionName:String, with arguments:[Any])->JSValue? {
        guard let _context = context else {return nil}
        guard let function = _context.objectForKeyedSubscript(functionName)else {return nil}
        return function.call(withArguments: arguments)
    }
}

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
//        let moduleHandler = JKBCodeModuleHandler(worker: self)
        if hasImportedAppLifeCycle()==false {
            moduleHandler.launchFile("AppLifeCycle")
            setImportedAppLifeCycle()
        }
        //bind
        let binder = DataBinderHandlerManager.dataBinder(appID: appID)
        binder.addObserver(self, with: JKO_GlobalDataKey_20201217(appID))
        //init
        _ = self.callJSFunction("initialAppLifeCycle", with: [appID])
    }
    public func updateGlobalData(_ data:Any?) {
        updateData(data)
    }
    public func updateData(_ data: Any?) {
        guard let _data = data else {return}
        _ = self.callJSFunction("updateGlobalData", with: [_data])
    }
    public func getGlobalData() ->Any? {
        guard let value = self.callJSFunction("getGlobalData", with: [])?.toDictionary() else {return nil}
        return value
    }
}
