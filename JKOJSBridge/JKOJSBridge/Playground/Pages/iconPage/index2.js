Page.onLoad(()=>{
//    JKMonitor.log("index2 onload"+miniapp._globalData.name);
}).onShow(()=>{
    JKBInterface.setNavigationBarTitle("元件演示");
    JKMonitor.log("index2 onShow");
}).onHide(()=>{
    JKMonitor.log("index2 onHide");
}).onPageData(()=>{
    return {
        "_name" : miniapp._globalData.name
    }
});

function changeGlobalName() {
    JKMonitor.log("call func updateGlobalData");
    miniapp._globalData.name = "JJ.Lee";
    Page.pageData._name = "JJ.Lee";
}
