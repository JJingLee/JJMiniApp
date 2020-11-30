//
//  JKOMiniAppContainerViewController.swift
//  JKOJSBridge
//
//  Created by chiehchun.lee on 2020/11/25.
//

import UIKit
import WebKit

class JKOMiniAppContainerViewController: UIViewController {

    var webView = WKWebView()
    var miniApp : JKOMiniApp?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        configWebView()
        launchMiniApp()
        loadPackage()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        JKOMiniApp.currentActiveMiniApp = self.miniApp
    }
    private func configWebView() {
        self.view.addSubview(webView)
        webView.frame = self.view.bounds
    }

    //MARK: - launch
    private func launchMiniApp() {
        miniApp = webView.jko_jsbridge.asMiniApp()
        miniApp?.launchMiniAppFrameworks()
    }

    //MARK: - Packaging
    private func loadPackage() {
        //HTML+CSS
        let url = Bundle.main.url(forResource: "DemoUserHTML", withExtension: "html")!
        webView.loadFileURL(url, allowingReadAccessTo: url)
        let request = URLRequest(url: url)
        webView.load(request)

        //JS
        let demoUserJS = """
            function readMoreClicked(id) {
              if (id == "readme") {
                var name = JKOAccount.getName();
                JSBridge.updateComponent(id,name);
                return 1;
              }
              return 0;
            }
        """
        JKOJSWorker.default.evaluateJS(demoUserJS)
    }

}
