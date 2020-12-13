//
//  JKOMiniAppPageRouter.swift
//  JKOJSBridge
//
//  Created by chiehchun.lee on 2020/12/12.
//

import Foundation

public class JKOMiniAppPageRouter: NSObject {
    let sourceProvider : JKOUserSourceLoader = JKOUserSourceLoader() //TODO : SourceLoader should bind appid
    private weak var _renderer : JKOMiniAppRenderer?
    private weak var _logicHandler : JKOMiniAppLogicHandler?
    private lazy var stackManager = JKOMiniAppPageStacksManager(count: 1)
    init(_ renderer : JKOMiniAppRenderer,
         _ logicHandler : JKOMiniAppLogicHandler) {
        _renderer = renderer
        _logicHandler = logicHandler
    }

    //initialize
    public func initialize() {
        guard let logicHandler = _logicHandler else {return}
        guard let renderer = _renderer else { return }
        sourceProvider.loadUserAppJS(to:logicHandler)

        let firstRoute = "index"
        sourceProvider.loadUserPage(firstRoute,to:renderer)
        sourceProvider.loadUserPageJS(firstRoute,to:logicHandler)
        //keep stack
        stackManager.pushPage(JKOMiniAppStackPageStruct(pageRoute: firstRoute))

        logicHandler.pageOnLoad()
        logicHandler.pageOnShow()
    }
    //newPage
    public func navigateTo(_ route : String) {
        guard let logicHandler = _logicHandler else {return}
        guard let renderer = _renderer else { return }
        //renderer notify page onHide
        logicHandler.pageOnHide()

        //keep stack
        stackManager.pushPage(JKOMiniAppStackPageStruct(pageRoute: route))

        //renew logicHandler worker
        logicHandler.refreshPageWorker(with:logicHandler.appID,pageID: route)

        //renderer open new page
        sourceProvider.loadUserPage(route,to:renderer)
        sourceProvider.loadUserPageJS(route,to:logicHandler)

        //renderer notify newPage onShow
        logicHandler.pageOnLoad()
        logicHandler.pageOnShow()
    }
    //redirect
    public func redirectTo() {}
    //back
    public func navigateBack() {
        guard let logicHandler = _logicHandler else {return}
        guard let renderer = _renderer else { return }
        //renderer notify page onHide
        logicHandler.pageOnHide()

        //get page from stack
        guard let _ = stackManager.popLastPage(), let currentPage = stackManager.currentPage() else {
            //TODO : root page handles
            JKB_log("already back to root!")
            return
        }
        let lastRouteName = currentPage.pageRoute

        //renew logicHandler worker
        logicHandler.refreshPageWorker(with:logicHandler.appID,pageID: lastRouteName)

        //renderer open new page
        sourceProvider.loadUserPage(lastRouteName,to:renderer)
        sourceProvider.loadUserPageJS(lastRouteName,to:logicHandler)

        //render notify newPage onShow
        logicHandler.pageOnShow()
    }
    //change tab
    public func switchTab() {}
    //reboot
    public func reLaunch() {}
}

public struct JKOMiniAppStackPageStruct {
    public var pageRoute : String
    public init(pageRoute : String) {
        self.pageRoute = pageRoute
    }
}

public class JKOMiniAppPageStacksManager : NSObject {
    private var stacks : [[JKOMiniAppStackPageStruct]] = []
    private var _selectingIndex : Int = 0
    private var selectingIndex : Int {
        get {
            return _selectingIndex
        }
        set {
            _selectingIndex = min(newValue, stacks.count-1)
        }
    }
    public init(count : Int) {
        super.init()
        stacks = Array.init(repeating: [], count: count)
        selectingIndex = 0
    }
    public func changeTab(to index : Int) {
        selectingIndex = index
    }
    public func pushPage(_ page:JKOMiniAppStackPageStruct) {
        defer { objc_sync_exit(self) }
        objc_sync_enter(self)
        stacks[selectingIndex].append(page)
    }
    public func popLastPage()->JKOMiniAppStackPageStruct? {
        defer { objc_sync_exit(self) }
        objc_sync_enter(self)
        return stacks[selectingIndex].popLast()
    }
    public func currentPage()->JKOMiniAppStackPageStruct? {
        defer { objc_sync_exit(self) }
        objc_sync_enter(self)
        return stacks[selectingIndex].last
    }
}

