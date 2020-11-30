//
//  JKBNativeFrameworkProtocol.swift
//  JKOJSBridge
//
//  Created by chiehchun.lee on 2020/11/24.
//

import Foundation

public protocol JKBNativeFrameworkProtocol {
    var jsScript : String? { get set }
    var interfaceClass : AnyClass { get set }
    var keyedSubscript : String { get set }
}
