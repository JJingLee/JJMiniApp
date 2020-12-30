//
//  ViewController.swift
//  JKOJSBridge
//
//  Created by chiehchun.lee on 2020/11/18.
//

import UIKit
import WebKit

class ViewController: UIViewController {
    @IBOutlet weak var entryButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        configMiniAppButton()
        configPackagingButton()
    }
    private func configMiniAppButton() {
        entryButton.addTarget(self, action: #selector(self.gotoMiniApp), for: .touchUpInside)
    }
    @objc func gotoMiniApp() {
        let miniappContainer = JKOMiniApp.miniAppPage(with:"0x001")
        let nav = UINavigationController(rootViewController: miniappContainer)
        nav.modalPresentationStyle = .fullScreen
        present(nav, animated: true, completion: nil)
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

