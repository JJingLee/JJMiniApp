
function getName(id) {
    if (id == "nameId") {
        var name = JKOAccount.getName();
        JKBDom.updateComponent(id,name);
        return 1;
    }
    return 0;
}

function getAccountId(id) {
    if (id == "accountID") {
        var accountID = JKOAccount.getAccountID();
        JKBDom.updateComponent(id,accountID);
        return 1;
    }
    return 0;
}
