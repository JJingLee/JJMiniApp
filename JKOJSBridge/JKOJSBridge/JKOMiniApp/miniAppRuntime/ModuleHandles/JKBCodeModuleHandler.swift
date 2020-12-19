//
//  JKBCodeModuleHandler.swift
//  JKOJSBridge
//
//  Created by chiehchun.lee on 2020/12/18.
//

import Foundation

public class JKBCodeModuleHandler : NSObject {
    private let frameWorkImportActions : [String : (JKOJSWorker)->Void] = [
        "NativeFrameWork" : { targetWorker in
            targetWorker.importNativeFrameworks(JKONativeFrameWorks)
        },
        "AppLifeCycle" : { targetWorker in
            targetWorker.listensToGlobalData()
        }
    ]
    private weak var targetWorker : JKOJSWorker?
    private var hasImportedFrameworks : Set<String> = []

    public init(worker : JKOJSWorker) {
        targetWorker = worker
    }

//TODO : cycle import problem & dataProxy <--> AppLifeCycle
    public func launchFile(_ fileName : String) {
        guard let jsCode = Bundle.main.fetchJSScript(with: fileName) else {return}
        launchCode(jsCode)
    }
    public func launchCode(_ jsCode : String) {
        var file = jsCode
        guard file.count > 0 else {return}
        let literalFileContext = file.lines
        literalFileContext.forEach { (line) in

            //Import
            if let _ = importHandles(line) {
                file = removeImportSyntax(of: file, from: line)
                return
            }
        }
        targetWorker?.evaluateJS(file)
    }
    /** Return : frameworkName, means whethor it is a Import syntax or not. */
    public func importHandles(_ line : String)->String? {
        let handlesStr = line.trimmingCharacters(in: CharacterSet.init(charactersIn: " "))
        if handlesStr.hasPrefix("#import") {
            let characters = handlesStr.split(separator: " ")
            guard characters.count > 1 else { return nil }
            let frameWorkName = characters[1].trimmingCharacters(in: CharacterSet.init(charactersIn: ";")) //Imported file name
            //handle duplicate, avoid import cycle
            guard checkNeedImportFramework(frameWorkName) else {return frameWorkName}
            //Reserved Frameworks import
            if let frameworkAction = frameWorkImportActions[frameWorkName], let _targetWorker = targetWorker {
                frameworkAction(_targetWorker)
            }
            //file import
            else {
                self.launchFile(frameWorkName) //file js, keep loop until there is no more module need to be imported.
            }



            return frameWorkName
        }
        return nil
    }

    private func removeImportSyntax(of file:String,from line : String)->String {
        var importSyntax = line
        if let semicolonIndex = line.firstIndex(of: ";") {
            importSyntax = String(line[line.startIndex...semicolonIndex])
        }
        return file.replacingOccurrences(of: importSyntax, with: "")
    }

    private func checkNeedImportFramework(_ framework : String)->Bool {
        defer { objc_sync_exit(self) }
        objc_sync_enter(self)
        guard !hasImportedFrameworks.contains(framework) else { return false }
        hasImportedFrameworks.insert(framework)
        return true
    }
}

extension String {
    var lines: [String] {
        return self.components(separatedBy: "\n")
    }
}
