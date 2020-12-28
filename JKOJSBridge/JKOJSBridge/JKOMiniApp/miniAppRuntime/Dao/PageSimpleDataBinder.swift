//
//  PageSimpleDataBinder.swift
//  JKOJSBridge
//
//  Created by chiehchun.lee on 2020/12/23.
//

import Foundation
import SwiftSoup

public class PageSimpleDataBinder : NSObject {
    typealias DataKeyName = String
    typealias DomId = String
    typealias DomInnerHtml = String
    var observeMap : [DataKeyName : Set<DomId>] = [:]
    var domContentMap : [DomId : DomInnerHtml] = [:]
    var origHtml : String = ""
    var domSetter : (String, String)->Void = {_,_ in }

    public func renew(html : String) {
        origHtml = html
    }
    public func update(key:String, with allData:[String:Any])throws {
        guard let observer = observeMap[key] else {return}
        for domID in observer {
            guard var origContent = domContentMap[domID] else {continue}
            for (dataKey,dataValue) in allData {
                let declareKey = "{{\(dataKey)}}"
                guard let newValue = dataValue as? String else {return}
                origContent = origContent.replacingOccurrences(of: declareKey, with: newValue)
            }
            print("dom set as \(origContent)")
            domSetter(domID,origContent)
        }
    }
    public func refreshPage(_ html:String, with data:[String:Any])->String {
        var newHtml = html
        for (dataKey, dataValue) in data {
            let declareKey = "{{\(dataKey)}}"
            guard let valueStr = dataValue as? String else {continue}
            newHtml = newHtml.replacingOccurrences(of: declareKey, with: valueStr)
        }
        return newHtml
    }
    public func config() {
        let html = origHtml
        do {
            let startTime = Date().timeIntervalSince1970
            try _config(with: html)
            print("config spendTime : \(Date().timeIntervalSince1970 - startTime)")
        } catch {
            print("dataBindingFailed")
        }
    }

    /*Time Complexity : O(n*m), n = dom count, m = dom context count */
    private func _config(with html : String)throws {
        /*Example :
         html =
         <p>An <a href='http://example.com/'><b>example</b></a> link.</p> <page id='1'>{{name}}</page><page id='2'>{{name}}</page> */


        let doc: Document = try SwiftSoup.parse(html)
        /* Example :
         elements = [
            <page id='1'>{{name}}</page> ,
            <page id='2'>{{name}}</page>
         ]
         */
        let elements = try doc.getElementsContainingOwnText("{{")
        for element in elements {
            /* Example :
             outerHTML = <page id='1'>123{{name}}123</page>
             innerTxt =  123{{name}}123
             */
            guard let innerTxt = try? element.html() else { continue }
            /* Example : domID = 1 */
            let domID = element.id()
            var hasBinded = false
            loopKey(with: innerTxt) { (needBindKey) in
                /* Example : needBindKey = name */
                var observeDoms = self.observeMap[needBindKey] ?? []
                observeDoms.insert(domID)
                self.observeMap[needBindKey] = observeDoms
                hasBinded = true
            }
            if hasBinded {
                //config domContentMap
                domContentMap[domID] = innerTxt
            }
        }
    }

    /* Time Complexity : O(n), n = length of context. */
    private func loopKey(with context : String, _ body: @escaping (String)->Void) {
        var continuFrontBraceCount = 0
        var continuBackBraceCount = 0
        var calculatingWords : String? = nil
        for token in context {
            if token == "{" {
                continuBackBraceCount = 0
                continuFrontBraceCount += 1
            }else if token == "}" {
                continuBackBraceCount += 1
                continuFrontBraceCount = 0
            }else {
                continuBackBraceCount = 0
                continuFrontBraceCount = 0
                //check is calculating
                if let _calculatingWords = calculatingWords {
                    calculatingWords = "\(_calculatingWords)\(token)"
                }
            }
            if continuFrontBraceCount == 2 {
                calculatingWords = ""
            }
            else if continuBackBraceCount == 2 {
                if let _calculatingWords = calculatingWords {
                    body(_calculatingWords)
                }
                calculatingWords = nil
            }
        }
    }
}
public struct PageDataUpdateStruct {
    public var updateKey : String
    public var dataObject : [String:Any]
    public init(updateKey:String, dataObject:[String:Any]) {
        self.updateKey = updateKey
        self.dataObject = dataObject
    }
}
extension PageSimpleDataBinder : miniAppDataBindingObserver {
    public func updateData(_ key: String, _ data: Any?) {
        if let _pageData = data as? PageDataUpdateStruct {
            do {
                try self.update(key: _pageData.updateKey, with: _pageData.dataObject)
            } catch {
                JKB_log("pageData update failed")
            }
        }
    }
}
