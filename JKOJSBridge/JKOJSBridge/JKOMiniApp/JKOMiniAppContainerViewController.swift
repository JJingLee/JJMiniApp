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
    var dataBinder : DataBindingHandler = DataBindingHandler()
    var renderer = JKOMiniAppRenderer()
    var dispatcher : JKBDispatcher =  JKBDispatcher()
    var logicHandler = JKOMiniAppLogicHandler()
    var nativeFrameworks : [JKBNativeFrameworkProtocol] = [
        JKBAccount(),
        JKBJSBridgeFramework(),
        JKBMonitorFramework(),
        JKBRouterFramework(),
        JKBStorageFramework(),
    ]
    let sourceProvider : JKOUserSourceLoader = JKOUserSourceLoader()
    var appID : String?
    let firstPageID = "index"

    var launcher : miniAppLauncher?
    lazy var pageRouter = JKOMiniAppPageRouter(renderer, logicHandler, sourceProvider)

    public override func viewDidLoad() {
        super.viewDidLoad()

        launcher = miniAppLauncher(appID: appID ?? "",
                                   firstPageID: firstPageID,
                                   container: self,
                                   logicHandler: logicHandler,
                                   dataBinder: dataBinder,
                                   dispatcher: dispatcher,
                                   renderer: renderer,
                                   nativeFrameworks: nativeFrameworks)
        launcher?.launch()

        sourceProvider.loadUserAppJS(to:logicHandler)
        logicHandler.appOnLaunch()

        pageRouter.initialize()

    }

    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        JKOMiniAppContainerManager.shared.currentActiveMiniApp = self
        logicHandler.appOnShow()
    }
    public override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        logicHandler.appOnHide()
    }

}
