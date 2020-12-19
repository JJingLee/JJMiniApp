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
