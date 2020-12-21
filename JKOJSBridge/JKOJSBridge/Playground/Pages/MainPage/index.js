
function readMoreClicked(id) {
  if (id == "readme") {
    var name = JKOAccount.getName();
      JKBDom.updateComponent(id,name);
      JKBRouter.navigateTo("index2");
    return 1;
  }
  return 0;
}

function read2MoreClicked(id) {
  if (id == "readme2") {
    var name = JKOAccount.getName();
      JKBRouter.switchTab("index2");
    return 1;
  }
  return 0;
}

Page.onLoad(()=>{
    JKMonitor.log("index1 onload");
}).onShow(()=>{
    JKMonitor.log("index1 onShow");
}).onHide(()=>{
    JKMonitor.log("index1 onHide");
});
