//
//  JKOMiniAppRenderer+updateDoms.swift
//  JKOJSBridge
//
//  Created by chiehchun.lee on 2020/12/12.
//

import Foundation
import WebKit

extension JKOMiniAppRenderer : JKBDispatcherRendererImp {
    public func updateInnerHTML(componentKey : String, context : String) {
        //illegal character for js removed
//        var legalContext = context.replacingOccurrences(of: "\"", with: "\\\"")
//        self.webView.evaluateJavaScript("""
//                function changeElement(id,content) {
//                    document.getElementById(id).innerHTML = content;
//                }
//            """)
//        self.webView.evaluateJavaScript("changeElement(\(componentKey),\(context))")
//        let js = "document.getElementById('componentKey').innerHTML = 'context';"
//        self.webView.callAsyncJavaScript(js, arguments: [
//            "componentKey" : componentKey,
//            "context" : context
//        ],in: nil, in: .defaultClient) { (result) in
//
//        }
        self.webView.evaluateJavaScript("document.getElementById(\"\(componentKey)\").innerHTML = \"\(context)\";") { (_, _) in }
    }
}
