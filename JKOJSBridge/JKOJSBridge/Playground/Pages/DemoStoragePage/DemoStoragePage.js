
function setGlobalData() {
    miniapp._globalData.pet = "bird"
}

function getGlobalData() {
    JKBDom.updateComponent("globalData",miniapp._globalData.pet);
}

function setStorageData() {
    JKBStorage.setStorage(miniapp.appId,"fruit","pineapple")
}

function getStorageData() {
    JKBDom.updateComponent("storageData",JKBStorage.getStorage(miniapp.appId,"fruit"));
}
