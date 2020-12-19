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
    let sourceProvider : JKOUserSourceLoader = JKOUserSourceLoader()
    var appID : String?

    var launcher : miniAppLauncher?
    lazy var pageRouter = JKOMiniAppPageRouter(renderer, logicHandler, sourceProvider)

    public override func viewDidLoad() {
        super.viewDidLoad()

        launcher = miniAppLauncher(appID: appID ?? "",
                                   container: self,
                                   logicHandler: logicHandler,
                                   dispatcher: dispatcher,
                                   renderer: renderer)
        launcher?.launch()

        sourceProvider.loadUserAppJS(to:logicHandler)
        logicHandler.appOnLaunch()

        pageRouter.initialize()
    }

    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        JKOMiniAppContainerManager.shared.currentActiveMiniApp = self
    }
    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        logicHandler.appOnShow()
        logicHandler.pageOnShow()
    }
    public override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        logicHandler.pageOnHide()
        logicHandler.appOnHide()
    }

}
