#import AppLifeCycle

class PagelifeCycle {
    constructor(appid, pageid) {
        this.appId = appid
        this.pageId = pageid
        this.pageData = new Proxy({}, {
            set: function(target, key, value) {
                if (typeof this.obj === 'undefined') {
                  this.obj = {}
                }
                if (key === "getAll") {
                  return true;
                }
                if (key === "setAll") {
                    this.obj = value
                    return true
                }
                this.obj[key] = value
                Private_JKBStorage.updatePageData(Page.appId,Page.pageId, key,this.obj)
                return true;
            },
            get:function(target, prop) {
              if (prop === "getAll") {
                return this.obj
              }
              return this.obj[prop]; // 非私有變數，那就回傳原物件的原屬性值
            },
            has: function(target, prop) {
              return prop in this.obj;
            }
          })
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
    onPageData(dataClosure) {
        this.dataClosure = dataClosure
        if (typeof dataClosure === 'function'){
            if(typeof dataClosure() === 'object') {
                this.pageData.setAll = dataClosure()
            }
        }
        return this;
    }
    getPageData() {
        return this.pageData.getAll
    }
    setPageData(newPageData) {
        return this.pageData.setAll = newPageData
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

function updatePageData(data) {
    Page.pageData.setAll = data
}
function getPageData() {
    return Page.getPageData()
}
function setPageData(newPageData) {
    return Page.setPageData(newPageData)
}
