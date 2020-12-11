//
//  JKOJSBridgeWebViewDSL.swift
//  JKOJSBridge
//
//  Created by chiehchun.lee on 2020/11/23.
//

import Foundation
import WebKit

/** Use case

 // Launch --> inject framework JS
 webView.jko_jsbridge.registJSScript(script)

 // dispatcher --> listening
 webView.jko_jsbridge.addHandler(with: "clickHandler") { (data) in print("clickHandler : \(data)") }

*/
public class JKOJSBridgeWebViewDSL:NSObject {
    let webView : WKWebView
    var contentController : WKUserContentController?
    public init(webview : WKWebView) {
        webView = webview
        contentController = webview.configuration.userContentController
    }

    //MARK: - registScript
    public func registJSScript(_ scriptString:String) {
        let script = WKUserScript(source: scriptString, injectionTime: .atDocumentStart, forMainFrameOnly: true)
        contentController?.addUserScript(script)
    }
    public func registJSScript(_ script:WKUserScript) {
        contentController?.addUserScript(script)
    }
    //MARK: - handler
    //Handle event from js.
    public func addHandler(with key:String, subscribe subscriber:@escaping(Any)->Void){
        let newObserver = JKOJSFunctionObserver(with: key, observer: subscriber)
        webView.setJSFunctionCallingObserver(newObserver, with: key) //retain it.
        contentController?.add(newObserver, name: key)
    }
    public func addHandler(with key:String, customDelegate:WKScriptMessageHandler){
        contentController?.add(customDelegate, name: key)
    }

    //MARK: - MiniApp
//    public func asMiniApp()->JKOMiniApp {
//        return JKOMiniApp(webview: webView)
//    }
}
