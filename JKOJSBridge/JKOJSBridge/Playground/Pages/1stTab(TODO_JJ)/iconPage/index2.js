//globaldata + boss_name
//label show boss+boss_name
//goto index21

Page.onLoad(()=>{
}).onReady(()=>{
    JKMonitor.log("index2 : "+miniapp._globalData.boss_name);
    Page.pageData.bossName = miniapp._globalData.boss_name;
}).onHide(()=>{
}).onPageData(()=>{
    return {
        "bossName" : miniapp._globalData.boss_name
    }
});

function gotoIndex21(domid) {
    JKBRouter.navigateTo("index21");
}
































































































//JKMonitor.log("");
//miniapp._globalData
//Page.pageData
//JKBRouter.navigateTo("index21");

