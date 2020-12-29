
Page.onLoad(()=>{

}).onShow(()=>{

}).onHide(()=>{

}).onPageData(()=>{
    return {
        "nameId": "NameId",
        "accountID": "AccountID"
    }
});

function getName() {
    var name = JKOAccount.getName();
    Page.pageData.nameId = name
    return 1;
}

function getAccountId() {
    var accountID = JKOAccount.getAccountID();
    Page.pageData.accountID = accountID
    return 1;
}
