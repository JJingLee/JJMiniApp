#import AppLifeCycle

class PagelifeCycle {
    constructor(appid, pageid) {
        this.appId = appid
        this.pageId = pageid
    }

    onLoad(onLoadClosure) {
        this.onLoad = onLoadClosure;
        return this;
    }
    onShow(onShowClosure) {
        this.onShow = onShowClosure;
        return this;
    }
    onReady(onReadyClosure) {
        this.onReady = onReadyClosure;
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

    native_onLoad() {
        if (typeof this.onLoad === 'function'){
            this.onLoad();
        }
    }
    native_onShow() {
        if (typeof this.onShow === 'function'){
            this.onShow();
        }
    }
    native_onReady() {
        if (typeof this.onReady === 'function'){
            this.onReady();
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

};

var Page;

function JKInitialPageLifeCycle(appID,pageId) {
    Page = new PagelifeCycle(appID,pageId);
//    initialAppLifeCycle(appID)
}

function JKPageOnLoad() {
    Page.native_onLoad()
}

function JKPageOnShow() {
    Page.native_onShow()
}

function JKPageOnReady() {
    Page.native_onReady()
}

function JKPageOnHide() {
    Page.native_onHide()
}

function JKPageOnError() {
    Page.native_onError()
}

