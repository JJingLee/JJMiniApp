
Page.onLoad(()=>{
    JKMonitor.log("index3 onload");
    JKMonitor.log("index3 old data :"+miniapp._globalData.name);
    miniapp._globalData.name = "JJ.Lee"
    JKMonitor.log("index3 change data to :"+miniapp._globalData.name);
}).onShow(()=>{
    JKBInterface.setNavigationBarTitle("元件演示2");
    JKMonitor.log("index3 onShow");
    JKMonitor.log("myData : "+JKBStorage.getStorage(miniapp.appId,"myData"))
}).onHide(()=>{
    JKMonitor.log("index3 onHide");
});

function backToHome() {
    JKBRouter.navigateBack()
}



function switchTab(id) {
  if (id == "switchTab") {
      JKBRouter.switchTab("index");
      return 1;
  }
  return 0;
}

function showTabBarRedDot(id) {
  if (id == "showTabBarRedDot") {
      JKBInterface.showTabBarRedDot(1);
      return 1;
  }
  return 0;
}

function hideTabBarRedDot(id) {
  if (id == "hideTabBarRedDot") {
      JKBInterface.hideTabBarRedDot(1);
      return 1;
  }
  return 0;
}

function setTabBarItem(id) {
  if (id == "setTabBarItem") {
      JKBInterface.setTabBarItem(1, "廢物", "iconTabbarFriend_normal", "iconTabbarFriend_selected");
      return 1;
  }
  return 0;
}

function setTabBarBadge(id) {
  if (id == "setTabBarBadge") {
      JKBInterface.setTabBarBadge(1, "12");
      return 1;
  }
  return 0;
}

function removeTabBarBadge(id) {
  if (id == "removeTabBarBadge") {
      JKBInterface.removeTabBarBadge(1);
      return 1;
  }
  return 0;
}

function hideTabBar(id) {
  if (id == "hideTabBar") {
      JKBInterface.hideTabBar(true);
      return 1;
  }
  return 0;
}

function showTabBar(id) {
  if (id == "showTabBar") {
      JKBInterface.showTabBar(true);
      return 1;
  }
  return 0;
}

function setTabBarStyle(id) {
  if (id == "setTabBarStyle") {
      JKBInterface.setTabBarStyle("#ff2255", "#416d49", "#c1d3ed", "#9debd9");
      return 1;
  }
  return 0;
}

function setNavigationBarTitle(id) {
  if (id == "setNavigationBarTitle") {
      JKBInterface.setNavigationBarTitle("我愛街口");
      return 1;
  }
  return 0;
}

function setNavigationBarColor(id) {
  if (id == "setNavigationBarColor") {
      JKBInterface.setNavigationBarColor("9debd9");
      return 1;
  }
  return 0;
}

function hideHomeButton(id) {
  if (id == "hideHomeButton") {
      JKBInterface.hideHomeButton();
      return 1;
  }
  return 0;
}
