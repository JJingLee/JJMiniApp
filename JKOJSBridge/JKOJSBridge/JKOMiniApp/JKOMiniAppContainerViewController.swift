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

    public override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        configRenderer()
        configLogicHandler()


        //binding
        dispatcher.bindRenderer(renderer)
        dispatcher.bindCallFunctionHandler(logicHandler)

        //app stuff
        logicHandler.appLoadFrameworks(nativeFrameworks)
        if let userAppJS = JKOUserSourceLoader.shared.globalAppJS() {
            logicHandler.appLoadJS(userAppJS)
        }

        //page stuff
        logicHandler.pageLoadFrameworks(nativeFrameworks)
        if let firstPageHTML = JKOUserSourceLoader.shared.getPageHTML(with: "index") {
            renderer.render(with:firstPageHTML)
        }

        if let firstPageJS = JKOUserSourceLoader.shared.getPageJS(with: "index") {
            logicHandler.pageLoadJS(firstPageJS)
        }

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

    private func configRenderer() {
        renderer.toggleRenderer { (renderView) in
            self.view.addSubview(renderView)
            renderView.translatesAutoresizingMaskIntoConstraints = false
            self.view.addConstraints([
                renderView.leftAnchor.constraint(equalTo: self.view.leftAnchor),
                renderView.rightAnchor.constraint(equalTo: self.view.rightAnchor),
                renderView.topAnchor.constraint(equalTo: self.view.topAnchor),
                renderView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            ])
        }
    }
    private func configLogicHandler() {
        guard let _appID = appID else {return}
        let firstPageID = "pageID"
        logicHandler.activeAppWorker(with: _appID)
        logicHandler.activePageWorker(with: _appID, pageID: firstPageID)
    }

}
