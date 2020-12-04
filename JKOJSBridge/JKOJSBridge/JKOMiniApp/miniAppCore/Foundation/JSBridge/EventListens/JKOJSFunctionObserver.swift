//
//  JKOJSFunctionObserver.swift
//  JKOJSBridge
//
//  Created by chiehchun.lee on 2020/11/23.
//

import Foundation
import WebKit
/** Delegation of JSHandler for web */
public class JKOJSFunctionObserver : NSObject, WKScriptMessageHandler {
    var _observer : (Any)->Void
    var _key : String
    init(with key : String, observer: @escaping (Any)->Void) {
        _observer = observer
        _key = key
    }
    public func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        if message.name == _key {
            _observer(message.body)
        }
    }
}
