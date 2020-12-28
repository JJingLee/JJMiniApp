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

    var jkTabBar: (UIView & JKTabBarProtocol)?
    lazy var jkNavigator: JKNavigatorProtocol? = {
        return JKContainer.createNavigator(self, config: sourceProvider.globalAppJSON())
    }()

    lazy var launcher : miniAppLauncher = {
        let _launcher = miniAppLauncher(container: self,
                                   logicHandler: logicHandler,
                                   dispatcher: dispatcher,
                                   renderer: renderer,
                                   sourceProvider: sourceProvider,
                                   jkTabBar: jkTabBar)
        return _launcher
    }()


    init(appID : String) {
        self.appID = appID
        logicHandler = JKOMiniAppLogicHandler(appID:appID)
        pageRouter = JKOMiniAppPageRouter(renderer, logicHandler, sourceProvider)
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    public override func viewDidLoad() {
        super.viewDidLoad()
        initial()
    }
    private func initial() {
        if let data = sourceProvider.globalAppJSON() {
            if let tabData = data["tabBar"] as? [String:Any] {
                jkTabBar = JKContainer.createTabBar(tabData)
                pageRouter._jkTabBar = jkTabBar
            }
            pageRouter._jkNavigator = jkNavigator
            jkNavigator?.setConfig(data)
        }

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

extension JKOMiniAppContainerViewController: WKNavigationDelegate, WKUIDelegate {

    public func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        logicHandler.pageOnReady()
        print("webViewDelegater didFinish")
    }

}
