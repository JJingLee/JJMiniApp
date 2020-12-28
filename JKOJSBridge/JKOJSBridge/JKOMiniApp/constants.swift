//
//  constants.swift
//  JKOJSBridge
//
//  Created by chiehchun.lee on 2020/12/17.
//

import Foundation
let JKOMAFirstPageName = "index"
func JKO_GlobalDataKey_20201217(_ appID : String)->String { return "JKO_GlobalDataKey_20201217_\(appID)" }//Key for data binding GlobalData
func JKO_PageSimpleBindingDataKey_20201217(_ appID:String)->String { return "JKO_PageSimpleBindingDataKey_20201217_\(appID)" }//Key for page data simple binding
let JKONativeFrameWorks : [JKBNativeFrameworkProtocol] = [
    JKBAccount(),
    JKBJSBridgeFramework(),
    JKBMonitorFramework(),
    JKBRouterFramework(),
    JKBStorageFramework(),
    Private_JKBStorageFramework(),
    JKBInterfaceFramework(),
]
