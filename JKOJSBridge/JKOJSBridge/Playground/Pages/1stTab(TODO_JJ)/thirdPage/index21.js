Page.onLoad(()=>{
}).onShow(()=>{
}).onHide(()=>{
}).onPageData(()=>{
    return {
        "bossName" : miniapp._globalData.boss_name
    }
});


function updateBossName(title) {
    miniapp._globalData.boss_name = "Jack";
    Page.pageData.bossName = miniapp._globalData.boss_name;
}
