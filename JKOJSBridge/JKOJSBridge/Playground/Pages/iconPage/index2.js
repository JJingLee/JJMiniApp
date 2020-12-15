Page.onLoad(()=>{
    JKMonitor.log("index2 onload");
}).onShow(()=>{
    JKMonitor.log("index2 onShow");
}).onHide(()=>{
    JKMonitor.log("index2 onHide");
});

function backToHome() {
    JKBRouter.navigateBack()
}
