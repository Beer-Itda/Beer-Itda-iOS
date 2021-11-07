//
//  LevelGuideViewController.swift
//  Beer-Itda
//
//  Created by 초이 on 2021/03/20.
//

import UIKit

class LevelGuideViewController: UIViewController {
    
    // MARK: - @IBOutlet Properties
    
    @IBOutlet weak var level1BgView: UIView!
    @IBOutlet weak var level2BgView: UIView!
    @IBOutlet weak var level3BgView: UIView!
    @IBOutlet weak var level4BgView: UIView!
    @IBOutlet weak var level5BgView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initNavigationBar()
        initViewRounding()
    }
    
    // MARK: - Functions
    
    private func initNavigationBar() {
        self.navigationController?.initWithBackButton()
        self.navigationItem.title = "등급 가이드"
    }
    
    private func initViewRounding() {
        level1BgView.makeRounded(radius: 12)
        level2BgView.makeRounded(radius: 12)
        level3BgView.makeRounded(radius: 12)
        level4BgView.makeRounded(radius: 12)
        level5BgView.makeRounded(radius: 12)
    }

}
