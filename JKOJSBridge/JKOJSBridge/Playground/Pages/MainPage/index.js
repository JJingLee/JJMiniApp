
function readMoreClicked(id) {
  if (id == "readme") {
    var name = JKOAccount.getName();
      JKBDom.updateComponent(id,name);
      JKBRouter.navigateTo("index2");
    return 1;
  }
  return 0;
}

Page.onLoad(()=>{
    JKMonitor.log("index1 onload");
    JKMonitor.log("index1 data :"+miniapp._globalData.name);
}).onShow(()=>{
    JKMonitor.log("index1 onShow");
    JKMonitor.log("index1 data :"+miniapp._globalData.name);
}).onHide(()=>{
    JKMonitor.log("index1 onHide");
});
