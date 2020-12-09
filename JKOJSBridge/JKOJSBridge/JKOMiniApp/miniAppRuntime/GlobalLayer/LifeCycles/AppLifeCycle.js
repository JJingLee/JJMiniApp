class ApplifeCycle {
  constructor(id) {
    this.appId = id
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
