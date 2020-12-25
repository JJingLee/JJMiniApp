#import AppLifeCycle

class DataProxy {
  constructor() {
    this.dataObserver = {
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
          Private_JKBStorage.setGlobalData(miniapp.appId,this.obj)
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
}
