Page.onLoad(()=>{
    JKMonitor.log("page load");
}).onReady(()=>{
    JKMonitor.log("page ready");
}).onHide(()=>{
    JKMonitor.log("page hide");
})
//.onPageData(()=>{
//    return {
//        <#key#> : <#value#>
//    }
//});

function gotoindex2(domid) {
    JKMonitor.log("onclick gotoindex2");
    JKBRouter.navigateTo("index2");
}




























































//JKMonitor.log("");
//miniapp._globalData
//Page.pageData
//JKBRouter.navigateTo("index21");
