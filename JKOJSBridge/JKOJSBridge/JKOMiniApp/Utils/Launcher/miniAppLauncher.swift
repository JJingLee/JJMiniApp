//
//  miniAppLauncher.swift
//  JKOJSBridge
//
//  Created by chiehchun.lee on 2020/11/25.
//

import Foundation

public class miniAppLauncher : NSObject {
    private weak var logicHandler : JKOMiniAppLogicHandler?
    private weak var dispatcher : JKBDispatcher?
    private weak var renderer : JKOMiniAppRenderer?
    private weak var container : JKOMiniAppContainerViewController?
    private weak var sourceProvider : JKOUserSourceLoader?
    
    init(container : JKOMiniAppContainerViewController,
         logicHandler : JKOMiniAppLogicHandler?,
         dispatcher : JKBDispatcher,
         renderer : JKOMiniAppRenderer,
         sourceProvider : JKOUserSourceLoader) {
        super.init()
        self.container = container
        self.logicHandler = logicHandler
        self.dispatcher = dispatcher
        self.renderer = renderer
        self.sourceProvider = sourceProvider
    }
    public func launch() {
        JKB_log("start launching frameworks...")
        configRenderer()
        dataDispatchBinding()
        configPageBinder()
        initSourceProvider()
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

    private func dataDispatchBinding() {
        guard let _dispatcher = dispatcher else { return }
        guard let _logicHandler = logicHandler else { return }
        guard let _renderer = renderer else { return }
        _dispatcher.bindRenderer(_renderer)
        _dispatcher.bindCallFunctionHandler(_logicHandler)
    }

    private func initSourceProvider() {
        if let _logicHandler = logicHandler {
            sourceProvider?.loadUserAppJS(to:_logicHandler)
        }
    }

    private func configPageBinder() {
        logicHandler?.pageWorker.pageSimpleDataBinder.domSetter = {
            [weak self]domID,content in
            self?.dispatcher?.updateComponentValue(componentKey: domID, context: content)
        }
    }

}
