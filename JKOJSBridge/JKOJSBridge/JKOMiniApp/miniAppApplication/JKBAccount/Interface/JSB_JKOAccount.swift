//
//  JSB_JKOAccount.swift
//  JKOJSBridge
//
//  Created by chiehchun.lee on 2020/11/24.
//

import Foundation

@objc public protocol JSB_JKOAccountProtocol : JKOJSExport {
    static func getName()->String
    static func getAccountID()->String
    static func getGender()->Int
}
@objc public class JSB_JKOAccount : NSObject,JSB_JKOAccountProtocol {
    public class func getName()->String {
        return "杰駿"
    }
    public class func getAccountID()->String {
        return "9010627178"
    }
    public class func getGender()->Int {
        return 1
    }
}
