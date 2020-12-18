miniapp.onLaunch(()=>{
    JKMonitor.log("user JS : onLaunch");
    JKMonitor.log("old data :"+miniapp._globalData.name);
    miniapp._globalData.name = "Danny"
    JKMonitor.log("new data :"+miniapp._globalData.name);
}).onShow(()=>{
    JKMonitor.log("user JS : onShow");
}).onHide(()=>{
    JKMonitor.log("user JS : onHide");
}).globalData(()=>{
    return {
        "name":"Jack"
    };
});
