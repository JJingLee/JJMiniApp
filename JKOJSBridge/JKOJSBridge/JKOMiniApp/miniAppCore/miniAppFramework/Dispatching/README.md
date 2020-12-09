#  Dispatching
|*events***|---listen--->| __________ |---call--->| ____________ |
| ___________________ | *JSBridge*| ________ | *Frameworks* |
|*lifeCycle*|<--update--| __________ |<--back--| ____________ |

## Events listening
1. Dom event protocol 
function callFunc : ( String )funcName, ( [Any] )args

2. add handler
webView.jko_jsbridge.addHandler(with: "clickHandler") { (data) in print("clickHandler : \(data)") }

## Call native / callback
1. export function to JS
2. JS call function

## Update LifeCycle (or data binding)
