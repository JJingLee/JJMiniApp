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
    var logicHandler : JKOMiniAppLogicHandler?
    let sourceProvider : JKOUserSourceLoader = JKOUserSourceLoader()
    var appID : String? {
        didSet {
            guard let _appID = appID else {return}
            if logicHandler == nil {
                logicHandler = JKOMiniAppLogicHandler(appID:_appID)
            }
            logicHandler?.appID = _appID
            if let _logicHandler = logicHandler {
                pageRouter = JKOMiniAppPageRouter(renderer, _logicHandler, sourceProvider, jkTabBar, jkNavigator)
            }
        }
    }

    var launcher : miniAppLauncher?
    var pageRouter : JKOMiniAppPageRouter?

    lazy var jkTabBar: (UIView & JKTabBarProtocol)? = JKContainer.createTabBar(sourceProvider.globalAppJSON())
    lazy var jkNavigator: JKNavigatorProtocol? = {
        return JKContainer.createNavigator(self, config: sourceProvider.globalAppJSON())
    }()
    

    public override func viewDidLoad() {
        super.viewDidLoad()

        if let data = sourceProvider.globalAppJSON() {
            jkNavigator?.setConfig(data)
        }

        launcher = miniAppLauncher(container: self,
                                   logicHandler: logicHandler,
                                   dispatcher: dispatcher,
                                   renderer: renderer,
                                   jkTabBar: jkTabBar)
        launcher?.launch()

        if let _logicHandler = logicHandler {
            sourceProvider.loadUserAppJS(to:_logicHandler)
        }
        logicHandler?.appOnLaunch()
        pageRouter?.initialize()
    }

    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        JKOMiniAppContainerManager.shared.currentActiveMiniApp = self
    }
    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        logicHandler?.appOnShow()
        logicHandler?.pageOnShow()
    }
    public override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        logicHandler?.pageOnHide()
        logicHandler?.appOnHide()
    }

}
