#import NativeFrameWork
#import DataProxy

class ApplifeCycle {
    constructor(id) {
//        JKMonitor.log("Init ApplifeCycle with :  "+id)
        this.appId = id
        this.dataProxy = new DataProxy()
        this.dataProxy.appId = id
        this._globalData = new Proxy({}, this.dataProxy.dataObserver)
    }

    onLaunch(onLaunchClosure) {
        this.onLaunch = onLaunchClosure;
        return this;
    }
    onShow(onShowClosure) {
        this.onShow = onShowClosure;
        return this;
    }
    onHide(onHideClosure) {
        this.onHide = onHideClosure;
        return this;
    }
    onError(onErrorClosure) {
        this.onError = onErrorClosure;
        return this;
    }
    globalData(gloabelDataClosure) {
        this.initialGloabelData = gloabelDataClosure
        if (typeof gloabelDataClosure === 'function'){
            if(typeof gloabelDataClosure() === 'object') {
                this._globalData.setAll = gloabelDataClosure()
            }
        }
        return this;
    }
    native_onLaunch() {
        if (typeof this.onLaunch === 'function'){
            this.onLaunch();
        }
    }
    native_onShow() {
        if (typeof this.onShow === 'function'){
            this.onShow();
        }
    }
    native_onHide() {
        if (typeof this.onHide === 'function'){
            this.onHide();
        }
    }
    native_onError() {
        if (typeof this.onError === 'function'){
            this.onError();
        }
    }
    getGlobalData() {
        return this._globalData.getAll
    }
    rebootGlobalData() {
        if (typeof this.initialGloabelData === 'function'){
            if(typeof this.initialGloabelData() === 'object') {
                this._globalData.setAll = this.initialGloabelData()
            }
        }
    }

};

var miniapp;

function initialAppLifeCycle(appID) {
    miniapp = new ApplifeCycle(appID);
}

function onLaunch() {
    miniapp.native_onLaunch()
}

function onShow() {
    miniapp.native_onShow()
}

function onHide() {
    miniapp.native_onHide()
}

function onError() {
    miniapp.native_onError()
}

function updateGlobalData(data) {
    miniapp._globalData.setAll = data
//    JKMonitor.log("updateGlobalData after : "+miniapp._globalData.name)
}
function getGlobalData() {
    return miniapp._globalData.getAll
}
