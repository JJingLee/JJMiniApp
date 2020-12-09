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
let appID : String = "1"
class JKOMiniAppContainerViewController: UIViewController {

    var webView = WKWebView()
    var miniApp : JKOMiniApp?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        configWebView()
        launchMiniApp()
        loadUserAppConfigs()
        loadPackage()
        miniApp?.lifeCycleHandler.callOnLaunch()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        JKOMiniApp.currentActiveMiniApp = self.miniApp
        miniApp?.lifeCycleHandler.callOnShow()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        miniApp?.lifeCycleHandler.callOnHide()
    }

    private func configWebView() {
        self.view.addSubview(webView)
        webView.frame = self.view.bounds
    }

    //MARK: - launch
    private func launchMiniApp() {
        let _miniApp = webView.jko_jsbridge.asMiniApp()
        miniApp = _miniApp
        miniApp?.launchMiniAppFrameworks(with: appID)
    }

    //MARK: - Packaging
    private func loadUserAppConfigs() {
        loadLocalToWorker(forResource: "app", withExtension: "js")
    }
    private func loadPackage() {
        //HTML+CSS
        loadLocalToWeb(forResource: "index", withExtension: "html")

        //JS
        loadLocalToWorker(forResource: "index", withExtension: "js")
    }

    private func loadLocalToWeb(forResource resource: String, withExtension extensionType: String){
        let url = Bundle.main.url(forResource: resource, withExtension: extensionType)!
        webView.loadFileURL(url, allowingReadAccessTo: url)
        let request = URLRequest(url: url)
        webView.load(request)
    }
    private func loadLocalToWorker(forResource resource: String, withExtension extensionType: String){
        let fileURL = Bundle.main.url(forResource: resource, withExtension: extensionType)!
        do {
            let fileText = try String(contentsOf: fileURL, encoding: .utf8)
        miniApp?.worker.evaluateJS(fileText)
        }
        catch {/* error handling here */}
    }

}
