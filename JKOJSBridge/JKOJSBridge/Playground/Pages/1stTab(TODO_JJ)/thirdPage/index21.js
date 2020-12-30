

Page.onLoad(()=>{
}).onReady(()=>{
}).onHide(()=>{
}).onPageData(()=>{
    return {
        "bossname" : miniapp._globalData.boss_name
    }
});



function changeName(domid) {
    //change label boss name
    Page.pageData.bossname = "Jack";
    //change global data bossname
    miniapp._globalData.boss_name = "Jack";
}

































































//JKMonitor.log("");
//miniapp._globalData
//Page.pageData
//JKBRouter.navigateTo("index21");
