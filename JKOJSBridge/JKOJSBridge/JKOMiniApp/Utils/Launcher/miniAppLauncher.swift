//
//  miniAppLauncher.swift
//  JKOJSBridge
//
//  Created by chiehchun.lee on 2020/11/25.
//

import Foundation

public class miniAppLauncher : NSObject {
    var appID : String?
    var firstPageID : String?
    private weak var logicHandler : JKOMiniAppLogicHandler?
    private weak var dispatcher : JKBDispatcher?
    private weak var renderer : JKOMiniAppRenderer?
    private weak var container : JKOMiniAppContainerViewController?
    private weak var dataBinder : DataBindingHandler?
    private var nativeFrameworks : [JKBNativeFrameworkProtocol]?
    
    init(appID : String,
         firstPageID : String,
         container : JKOMiniAppContainerViewController,
         logicHandler : JKOMiniAppLogicHandler,
         dataBinder : DataBindingHandler,
         dispatcher : JKBDispatcher,
         renderer : JKOMiniAppRenderer,
         nativeFrameworks : [JKBNativeFrameworkProtocol]) {
        super.init()
        self.appID = appID
        self.firstPageID = firstPageID
        self.container = container
        self.logicHandler = logicHandler
        self.dispatcher = dispatcher
        self.nativeFrameworks = nativeFrameworks
        self.renderer = renderer
        self.dataBinder = dataBinder
    }
    public func launch() {
        JKB_log("start launching frameworks...")
        configRenderer()
        dataDispatchBinding()
        addDataBinderToLogicHandler()

        appLoadNativeFramework()
        pageLoadNativeFramework()

        activeAppLifeCycle()
        activePageLifeCycle()
    }

    private func configRenderer() {
        renderer?.toggleRenderer { [weak self](renderView) in
            guard let _container = self?.container else {return}
            _container.view.addSubview(renderView)
            renderView.translatesAutoresizingMaskIntoConstraints = false
            _container.view.addConstraints([
                renderView.leftAnchor.constraint(equalTo: _container.view.leftAnchor),
                renderView.rightAnchor.constraint(equalTo: _container.view.rightAnchor),
                renderView.topAnchor.constraint(equalTo: _container.view.topAnchor),
                renderView.bottomAnchor.constraint(equalTo: _container.view.bottomAnchor),
            ])
        }
    }
    private func addDataBinderToLogicHandler() {
        guard let _dataBinder = dataBinder else { return }
        logicHandler?.bindGlobalData(to: _dataBinder)
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
