//
//  JKBAccount.swift
//  JKOJSBridge
//
//  Created by chiehchun.lee on 2020/11/24.
//

import Foundation

public class JKBAccount : NSObject, JKBNativeFrameworkProtocol {
    public var jsScript : String? = """
                        function JSB_FetchAccount() {
                                var name = JKOAccount.getName() + "";
                                var accountID = JKOAccount.getAccountID();
                                var gender = "M";//JKOAccount.getGender()==1 ? "M" : "F";
                            return name+","+accountID+","+gender;
                        }
    """
    public var interfaceClass : AnyClass = JSB_JKOAccount.self
    public var keyedSubscript : String = "JKOAccount"
}
