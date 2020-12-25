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

    var appID : String
    var logicHandler : JKOMiniAppLogicHandler
    var pageRouter : JKOMiniAppPageRouter

    let sourceProvider : JKOUserSourceLoader = JKOUserSourceLoader()
    lazy var launcher : miniAppLauncher = {
        let _launcher = miniAppLauncher(container: self,
                                   logicHandler: logicHandler,
                                   dispatcher: dispatcher,
                                   renderer: renderer,
                                   sourceProvider: sourceProvider)
        return _launcher
    }()


    init(appID : String) {
        self.appID = appID
        logicHandler = JKOMiniAppLogicHandler(appID:appID)
        pageRouter = JKOMiniAppPageRouter(renderer, logicHandler, sourceProvider)
        super.init(nibName: nil, bundle: nil)
        initial()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public override func viewDidLoad() {
        super.viewDidLoad()
    }

    private func initial() {
        launcher.launch()

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
