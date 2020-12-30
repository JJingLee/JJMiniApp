miniapp.onLaunch(()=>{
    JKMonitor.log("app launch");
}).onShow(()=>{
    JKMonitor.log("app show");
}).onHide(()=>{
    JKMonitor.log("app hide");
}).globalData(()=>{
    return {
        "boss_name" : "世鵬"
    };
});



















































//JKMonitor.log("");
//miniapp._globalData
//Page.pageData
//JKBRouter.navigateTo("index21");
