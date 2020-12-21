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
        JKBRouterFramework()
    ]
    var appID : String?
    let firstPageID = "index"

    var launcher : miniAppLauncher?
    lazy var pageRouter = JKOMiniAppPageRouter(renderer, logicHandler, jkTabBar)

    let sourceProvider : JKOUserSourceLoader = JKOUserSourceLoader()
    lazy var jkTabBar: (UITabBar & JKTabBarProtocol)? = JKContainer.createTabBar(sourceProvider.globalAppJSON())

    public override func viewDidLoad() {
        super.viewDidLoad()

        launcher = miniAppLauncher(appID: appID ?? "",
                                   firstPageID: firstPageID,
                                   container: self,
                                   logicHandler: logicHandler,
                                   dispatcher: dispatcher,
                                   renderer: renderer,
                                   nativeFrameworks: nativeFrameworks,
                                   jkTabBar: jkTabBar)
        launcher?.launch()

        pageRouter.initialize()

        logicHandler.appOnLaunch()
    }

    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        JKOMiniAppContainerManager.currentActiveMiniApp = self
        logicHandler.appOnShow()
    }
    public override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        logicHandler.appOnHide()
    }

}
