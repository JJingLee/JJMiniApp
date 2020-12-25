//
//  JKOMiniAppRenderer+UserSourceLoader.swift
//  JKOJSBridge
//
//  Created by chiehchun.lee on 2020/12/12.
//

import Foundation
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
}
