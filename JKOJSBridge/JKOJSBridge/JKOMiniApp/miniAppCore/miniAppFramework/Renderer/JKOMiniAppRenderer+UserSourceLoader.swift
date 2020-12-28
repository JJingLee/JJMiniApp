//
//  JKOMiniAppRenderer+UserSourceLoader.swift
//  JKOJSBridge
//
//  Created by chiehchun.lee on 2020/12/12.
//

import Foundation
import WebKit
extension JKOMiniAppRenderer : JKOUserSourceLoaderRendererProtocol {
    public func render(with htmlURL : URL) {
        webView.loadFileURL(htmlURL, allowingReadAccessTo: htmlURL)
        let request = URLRequest(url: htmlURL)
        webView.load(request)
    }
    public func renderByString(_ htmlString : String) {
        webView.loadHTMLString(htmlString, baseURL: nil)
//        webView.loadFileURL(htmlURL, allowingReadAccessTo: htmlURL)
//        let request = URLRequest(url: htmlURL)
//        webView.load(request)
    }

    public func render(with cssPath: String) {
        let cssStyle = """
                    javascript:(function() {
                    var parent = document.getElementsByTagName('head').item(0);
                    var style = document.createElement('style');
                    style.type = 'text/css';
                    style.innerHTML = window.atob('\(encodeStringTo64(fromString: cssPath)!)');
                    parent.appendChild(style)})()
                """
        let cssScript = WKUserScript(source: cssStyle, injectionTime: .atDocumentEnd, forMainFrameOnly: false)
        webView.configuration.userContentController.addUserScript(cssScript)
    }

    private func encodeStringTo64(fromString: String) -> String? {
        let plainData = fromString.data(using: .utf8)
        return plainData?.base64EncodedString(options: [])
    }
}
