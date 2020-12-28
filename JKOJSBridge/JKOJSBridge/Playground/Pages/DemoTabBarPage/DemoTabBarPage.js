
function switchTab() {
    JKBRouter.switchTab("index");
}

function showTabBarRedDot() {
    JKBInterface.showTabBarRedDot(2);
}

function hideTabBarRedDot() {
    JKBInterface.hideTabBarRedDot(2);
}

function setTabBarItem() {
    JKBInterface.setTabBarItem(2, "TEST", "iconTabbarFriend_normal", "iconTabbarFriend_selected");
}

function setTabBarBadge() {
    JKBInterface.setTabBarBadge(2, "12");
}

function removeTabBarBadge() {
    JKBInterface.removeTabBarBadge(2);
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
