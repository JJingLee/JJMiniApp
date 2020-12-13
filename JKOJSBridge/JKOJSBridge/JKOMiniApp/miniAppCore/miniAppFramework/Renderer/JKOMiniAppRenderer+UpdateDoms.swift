//
//  JKOMiniAppRenderer+updateDoms.swift
//  JKOJSBridge
//
//  Created by chiehchun.lee on 2020/12/12.
//

import Foundation

extension JKOMiniAppRenderer : JKBDispatcherRendererImp {
    public func updateInnerHTML(componentKey : String, context : String) {
        self.webView.evaluateJavaScript("document.getElementById('\(componentKey)').innerHTML = '\(context)';") { (_, _) in }
    }
}
