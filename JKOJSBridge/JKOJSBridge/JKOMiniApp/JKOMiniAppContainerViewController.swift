//
//  JKOMiniAppContainerViewController.swift
//  JKOJSBridge
//
//  Created by chiehchun.lee on 2020/11/25.
//

import UIKit
import WebKit
/**
Life Cycle :
onLaunch
onShow
onHide
onError
 */

public class JKOMiniAppContainerViewController: UIViewController {
    var renderer = JKOMiniAppRenderer()
    var dispatcher : JKBDispatcher =  JKBDispatcher()
    var logicHandler = JKOMiniAppLogicHandler()
    var nativeFrameworks : [JKBNativeFrameworkProtocol] = [
        JKBAccount(),
        JKBJSBridgeFramework(),
        JKBMonitorFramework(),
    ]
    var appID : String?
    let firstPageID = "index"

    var launcher : miniAppLauncher?

    public override func viewDidLoad() {
        super.viewDidLoad()

        launcher = miniAppLauncher(appID: appID ?? "",
                                   firstPageID: firstPageID,
                                   container: self,
                                   logicHandler: logicHandler,
                                   dispatcher: dispatcher,
                                   renderer: renderer,
                                   nativeFrameworks: nativeFrameworks)
        launcher?.launch()

        //user stuffs
        JKOUserSourceLoader.shared.loadUserAppJS(to:logicHandler)
        JKOUserSourceLoader.shared.loadUserPage("index",to:renderer)
        JKOUserSourceLoader.shared.loadUserPageJS("index",to:logicHandler)
        
        logicHandler.appLifeCycleHandler.callOnLaunch()
    }

    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        JKOMiniAppContainerManager.currentActiveMiniApp = self
        logicHandler.appLifeCycleHandler.callOnShow()
    }
    public override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        logicHandler.appLifeCycleHandler.callOnHide()
    }

}
