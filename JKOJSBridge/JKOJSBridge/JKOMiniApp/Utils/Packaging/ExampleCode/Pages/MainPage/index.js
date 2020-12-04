
function readMoreClicked(id) {
  if (id == "readme") {
    var name = JKOAccount.getName();
      JKBDom.updateComponent(id,name);
    return 1;
  }
  return 0;
}
