function callFunc(component,funcName, ...args) {
    var componentKey = component.id;
    var argsStr = args.join(',');
    // 從JS傳送資訊到App裡設定的callbackHandler。
    window.webkit.messageHandlers.callFunction.postMessage(componentKey + "," + funcName + "," + argsStr);
}
