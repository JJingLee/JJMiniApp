miniapp.onLaunch(()=>{
    JKMonitor.log("app onlaunch");
}).onShow(()=>{
    JKMonitor.log("app onShow");
}).onHide(()=>{
    JKMonitor.log("app onHide");
}).globalData(()=>{
    return {
        "boss_name" : "ww"
    };
});



























//miniapp.onLaunch(()=>{
//    JKMonitor.log("app.js : onLaunch");
//    JKMonitor.log("old data :"+miniapp._globalData.name);
//    miniapp._globalData.name = "Danny"
//    JKMonitor.log("new data :"+miniapp._globalData.name);
//}).onShow(()=>{
//    JKMonitor.log("app.js : onShow");
//}).onHide(()=>{
//    JKMonitor.log("app.js : onHide");
//}).globalData(()=>{
//    return {
//        "name":"Jack"
//    };
//});
