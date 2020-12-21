//
//  miniAppLauncher.swift
//  JKOJSBridge
//
//  Created by chiehchun.lee on 2020/11/25.
//

import Foundation
import UIKit

public class miniAppLauncher : NSObject {
    var appID : String?
    var firstPageID : String?
    private weak var logicHandler : JKOMiniAppLogicHandler?
    private weak var dispatcher : JKBDispatcher?
    private weak var renderer : JKOMiniAppRenderer?
    private weak var container : JKOMiniAppContainerViewController?
    private var nativeFrameworks : [JKBNativeFrameworkProtocol]?
    private var jkTabBar: UITabBar?
    
    init(appID : String,
         firstPageID : String,
         container : JKOMiniAppContainerViewController,
         logicHandler : JKOMiniAppLogicHandler,
         dispatcher : JKBDispatcher,
         renderer : JKOMiniAppRenderer,
         nativeFrameworks : [JKBNativeFrameworkProtocol],
         jkTabBar: UITabBar?) {
        super.init()
        self.appID = appID
        self.firstPageID = firstPageID
        self.container = container
        self.logicHandler = logicHandler
        self.dispatcher = dispatcher
        self.nativeFrameworks = nativeFrameworks
        self.renderer = renderer
        self.jkTabBar = jkTabBar
    }
    public func launch() {
        JKB_log("start launching frameworks...")
        configRenderer()
        dataDispatchBinding()
        activeAppLifeCycle()
        activePageLifeCycle()

        appLoadNativeFramework()
        pageLoadNativeFramework()
    }

    private func configRenderer() {
        renderer?.toggleRenderer { [weak self](renderView) in
            guard let _container = self?.container else {return}

            // renderView
            let stackView = UIStackView(arrangedSubviews: [renderView])
            stackView.axis = .vertical
            _container.view.addSubview(stackView)
            stackView.translatesAutoresizingMaskIntoConstraints = false
            _container.view.addConstraints([
                stackView.leftAnchor.constraint(equalTo: _container.view.leftAnchor),
                stackView.rightAnchor.constraint(equalTo: _container.view.rightAnchor),
                stackView.topAnchor.constraint(equalTo: _container.view.topAnchor),
                stackView.bottomAnchor.constraint(equalTo: _container.view.bottomAnchor),
            ])

            // Tab bar
            if let tabBar = self?.jkTabBar {
                tabBar.translatesAutoresizingMaskIntoConstraints = false
                tabBar.heightAnchor.constraint(equalToConstant: 49).isActive = true
                stackView.addArrangedSubview(tabBar)
            }

            // Safe area
            let bottomPadding = UIApplication.shared.windows.filter {$0.isKeyWindow}.first?.safeAreaInsets.bottom ?? 0
            let safeAreaView: UIView = { [weak self] in
                let view = UIView()
                view.backgroundColor = self?.jkTabBar?.barTintColor
                return view
            }()
            safeAreaView.translatesAutoresizingMaskIntoConstraints = false
            safeAreaView.heightAnchor.constraint(equalToConstant: bottomPadding).isActive = true
            stackView.addArrangedSubview(safeAreaView)
        }
    }
    private func activeAppLifeCycle() {
        guard let _appID = appID else {return}
        logicHandler?.activeAppWorker(with: _appID)
    }
    private func activePageLifeCycle() {
        guard let _appID = appID else {return}
        guard let firstPageID = firstPageID else {return}
        logicHandler?.activePageWorker(with: _appID, pageID: firstPageID)
    }

    private func dataDispatchBinding() {
        guard let _dispatcher = dispatcher else { return }
        guard let _logicHandler = logicHandler else { return }
        guard let _renderer = renderer else { return }
        _dispatcher.bindRenderer(_renderer)
        _dispatcher.bindCallFunctionHandler(_logicHandler)
    }

    private func appLoadNativeFramework() {
        guard let _nativeFrameworks = nativeFrameworks else { return }
        logicHandler?.appLoadFrameworks(_nativeFrameworks)
    }
    private func pageLoadNativeFramework() {
        guard let _nativeFrameworks = nativeFrameworks else { return }
        logicHandler?.pageLoadFrameworks(_nativeFrameworks)
    }

//    public func launchMiniAppFrameworks() {
//        JKB_log("start launching frameworks...")
//        importJKBDispatcher()
//        importNativeFrameworks()
//    }
//    public func importJKBDispatcher() {
//        JKB_log("launching dispatcher...")
////        guard let _logicHandler = self.logicHandler else {
////            JKB_log("<!> dispatcher launch failed")
////            return
////        }
////        _logicHandler.dispatcher = JKBDispatcher(webview:_logicHandler.webView, worker:_logicHandler.appWorker)
////        _logicHandler.dispatcher?.importCallFunctionAbility()
//        JKB_log("dispatcher launch done")
//    }
//    private func importNativeFrameworks() {
//        JKB_log("launching native frameworks...")
//        logicHandler?.appWorker.importNativeFrameworks([
//            self.jkbAccount,
//            self.jkbJsBridge,
//            self.jkbMonitor,
//        ])
//        JKB_log("native frameworks launch done")
//    }
}
