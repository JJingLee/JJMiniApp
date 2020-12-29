
Page.onLoad(()=>{

}).onShow(()=>{

}).onHide(()=>{
    
}).onPageData(()=>{
    return {
        "pet": miniapp._globalData.pet
    }
});

function setMiniAppGlobalData() {
    miniapp._globalData.pet = "bird"
}

function getMiniAppGlobalData() {
    Page.pageData.pet = miniapp._globalData.pet
}

function setMiniAppStorageData() {
    JKBStorage.setStorage(miniapp.appId,"fruit","banana")
}

function getMiniAppStorageData() {
    JKBDom.updateComponent("storageData",JKBStorage.getStorage(miniapp.appId,"fruit"));
}
