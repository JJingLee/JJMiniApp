//TODO:import dataProxy
class DataProxy {
  constructor() {
    this.dataObserver = {
      set: function(target, key, value) {
//          console.log(`The property ${key} has been updated with ${value}`);
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
          JKBStorage.setGlobalData(this.appId,this.obj)
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
    };
  }
//  forceUpdate(newValue) {
//      JKMonitor.log("forceUpdate1 : "+newValue.name)
//    this.obj = newValue;
//      JKMonitor.log("forceUpdate2 : "+this.obj.name)
//  }
}

class ApplifeCycle {
    constructor(id) {
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
        JKMonitor.log("globalData1")
        if (typeof gloabelDataClosure === 'function'){
            JKMonitor.log("globalData2")
            if(typeof gloabelDataClosure() === 'object') {
                JKMonitor.log("globalData3")
                JKMonitor.log(gloabelDataClosure().name)
                this._globalData.setAll = gloabelDataClosure()//dataProxy.forceUpdate(gloabelDataClosure());
                JKMonitor.log("globalData4")
                JKMonitor.log(this._globalData.name)
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

};

var miniapp;// = new ApplifeCycle("\(appID)");

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
