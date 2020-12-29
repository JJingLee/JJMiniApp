Page.onLoad(()=>{
    JKMonitor.log("index1 onload");
    JKMonitor.log("index1 data :"+miniapp._globalData.name);
}).onShow(()=>{
    JKMonitor.log("index1 onShow");
    JKMonitor.log("index1 data :"+miniapp._globalData.name);
    JKMonitor.log("myData : "+JKBStorage.getStorage(miniapp.appId,"myData"))
    JKBStorage.setStorage(miniapp.appId,"myData","good2")
}).onHide(()=>{
    JKMonitor.log("index1 onHide");
}).onPageData(()=>{
    return {
        "myName" : "Daniel"
    }
});

function onUpdateMyName(title) {
    Page.pageData.myName = "Chieh Chun Lee"
}
function gotoNextPage(title) {
    JKBRouter.navigateTo("index2");
}
