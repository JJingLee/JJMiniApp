
function readMoreClicked(id) {
  if (id == "readme") {
    var name = JKOAccount.getName();
      JKBDom.updateComponent(id,name);
    return 1;
  }
  return 0;
}

function onChangeTitle(title) {
    Page.pageData.readmeName = "that's hurt~"
}
function read2MoreClicked(id) {
  if (id == "readme2") {
    var name = JKOAccount.getName();
      JKBRouter.navigateTo("index2");
    return 1;
  }
  return 0;
}

Page.onLoad(()=>{
    JKMonitor.log("index1 onload");
    JKMonitor.log("index1 data :"+miniapp._globalData.name);
    JKBInterface.setNavigationBarTitle("街口功能演示");
}).onShow(()=>{
    JKMonitor.log("index1 onShow");
    JKMonitor.log("index1 data :"+miniapp._globalData.name);
    JKMonitor.log("myData : "+JKBStorage.getStorage(miniapp.appId,"myData"))
    JKBStorage.setStorage(miniapp.appId,"myData","good2")
}).onHide(()=>{
    JKMonitor.log("index1 onHide");
}).onPageData(()=>{
    return {
        "readmeName" : "click me!"
    }
});
