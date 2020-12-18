Page.onLoad(()=>{
    JKMonitor.log("index2 onload");
    JKMonitor.log("index2 old data :"+miniapp._globalData.name);
    miniapp._globalData.name = "JJ.Lee"
    JKMonitor.log("index2 change data to :"+miniapp._globalData.name);
}).onShow(()=>{
    JKMonitor.log("index2 onShow");
}).onHide(()=>{
    JKMonitor.log("index2 onHide");
});

function backToHome() {
    JKBRouter.navigateBack()
}
