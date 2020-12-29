
Page.onLoad(()=>{

}).onShow(()=>{

}).onHide(()=>{

}).onPageData(()=>{
    return {
        "gData": "GlobalData",
        "sData": "StorageData"
    }
});

function setMiniAppGlobalData() {
    miniapp._globalData.gData = "bird"
}

function getMiniAppGlobalData() {
    if (!miniapp._globalData.gData) {
        Page.pageData.gData = "undefined"
    } else {
        Page.pageData.gData = miniapp._globalData.gData
    }
}

function setMiniAppStorageData() {
    JKBStorage.setStorage(miniapp.appId,"fruit","banana")
}

function getMiniAppStorageData() {
    if (!JKBStorage.getStorage(miniapp.appId,"fruit")) {
        Page.pageData.sData = "undefined"
    } else {
        Page.pageData.sData = JKBStorage.getStorage(miniapp.appId,"fruit")
    }
}
