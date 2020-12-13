//
//  JKOMiniAppLogicHandler+UserSourceLoader.swift
//  JKOJSBridge
//
//  Created by chiehchun.lee on 2020/12/12.
//

import Foundation
extension JKOMiniAppLogicHandler : JKOUserSourceLoaderLogicHandlerProtocol {
    public func appLoadJS(_ js : String) {
        appWorker.evaluateJS(js)
    }
    public func pageLoadJS(_ js : String) {
        pageWorker.evaluateJS(js)
    }
}
