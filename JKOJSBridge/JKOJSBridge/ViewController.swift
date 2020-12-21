//
//  ViewController.swift
//  JKOJSBridge
//
//  Created by chiehchun.lee on 2020/11/18.
//

import UIKit
import WebKit

class ViewController: UIViewController {
    lazy var button : UIButton = {
        let btn = UIButton()
        btn.setTitle("miniapp", for: .normal)
        btn.addTarget(self, action: #selector(self.gotoMiniApp), for: .touchUpInside)
        return btn
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        configMiniAppButton()
        configPackagingButton()
    }
    private func configMiniAppButton() {
        button.frame = CGRect(x: 0, y: 0, width: 100, height: 50)
        button.setTitleColor(.red, for: .normal)
        button.center = self.view.center
        self.view.addSubview(button)
    }
    @objc func gotoMiniApp() {
        let miniappContainer = JKOMiniApp.miniAppPage(with:"0x001")
        self.navigationController?.pushViewController(miniappContainer, animated: true)
    }

    //TODO : 打nodejs server看抓不抓得到資料
    //packaging
    private func configPackagingButton() {
        packagebutton.frame = CGRect(x: 0, y: 0, width: 100, height: 50)
        packagebutton.center = self.view.center
        packagebutton.frame.origin.x -= 70
        self.view.addSubview(packagebutton)
    }
    let packagePage = PackagingTestViewController()
    lazy var packagebutton : UIButton = {
        let btn = UIButton()
        btn.setTitle("packaging", for: .normal)
        btn.addTarget(self, action: #selector(self.gotoMiniApp), for: .touchUpInside)
        return btn
    }()
    @objc func gotoPackaging() {
        self.navigationController?.pushViewController(packagePage, animated: true)
    }
}

