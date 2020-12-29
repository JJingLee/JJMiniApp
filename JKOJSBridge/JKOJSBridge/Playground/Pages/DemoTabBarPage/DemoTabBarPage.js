
function switchTab() {
    JKBRouter.switchTab("index");
}

function showTabBarRedDot() {
    JKBInterface.showTabBarRedDot(1);
}

function hideTabBarRedDot() {
    JKBInterface.hideTabBarRedDot(1);
}

function setTabBarItem() {
    JKBInterface.setTabBarItem(1, "TEST", "iconTabbarFriend_normal", "iconTabbarFriend_selected");
}

function setTabBarBadge() {
    JKBInterface.setTabBarBadge(1, "12");
}

function removeTabBarBadge() {
    JKBInterface.removeTabBarBadge(1);
}

function hideTabBar() {
    JKBInterface.hideTabBar(true);
}

function showTabBar() {
    JKBInterface.showTabBar(true);
}

function setTabBarStyle() {
    JKBInterface.setTabBarStyle("#ff2255", "#416d49", "#c1d3ed", "#9debd9");
}
