class PagelifeCycle {
    constructor(appid, pageid) {
        this.appId = id
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

var page;

function JKInitialPageLifeCycle(appID) {
    page = new PagelifeCycle(appID);
}

function JKPageOnLoad() {
    miniapp.native_onLoad()
}

function JKPageOnShow() {
    miniapp.native_onShow()
}

function JKPageOnReady() {
    miniapp.native_onReady()
}

function JKPageOnHide() {
    miniapp.native_onHide()
}

function JKPageOnError() {
    miniapp.native_onError()
}

