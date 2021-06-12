//
//  MyPageViewController.swift
//  Beer-Itda
//
//  Created by 초이 on 2021/03/20.
//

import UIKit

class MyPageViewController: UIViewController {
    
    // MARK: - @IBOutlet Properties
    @IBOutlet weak var profileView: UIView!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var gradeBadgeView: UIView!
    @IBOutlet weak var gradeGuideView: UIView!
    
    @IBOutlet weak var reviewBgView: UIView!
    @IBOutlet weak var likedBeerBgView: UIView!
    @IBOutlet weak var gradeProgressView: UIProgressView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initNavigationBar()
        initTabbarSetting()
        initViewRounding()
        initProgressView()
    }
    
    // MARK: - Functions
    
    private func initNavigationBar() {
        self.navigationController?.initializeNavigationBarWithoutBackButton(navigationItem: self.navigationItem)
        
        // 설정 버튼
        let settingButton = UIBarButtonItem(image: UIImage(named: "settings"), style: .plain, target: self, action: #selector(touchSettingButton))
        settingButton.tintColor = UIColor.darkGray

        self.navigationItem.rightBarButtonItem = settingButton
    }
    
    @objc func touchSettingButton() {
        pushToSettingViewController()
    }
    
    private func initTabbarSetting() {
        self.hidesBottomBarWhenPushed = true
    }
    
    private func initViewRounding() {
        profileView.makeRounded(radius: profileView.frame.height / 2)
        gradeBadgeView.makeRounded(radius: gradeBadgeView.frame.height / 2)
        gradeGuideView.makeRounded(radius: gradeGuideView.frame.height / 2)
        reviewBgView.makeRounded(radius: 10)
        likedBeerBgView.makeRounded(radius: 10)
    }
    
    private func initProgressView() {
        gradeProgressView.layer.cornerRadius = 7
        gradeProgressView.clipsToBounds = true
        gradeProgressView.layer.sublayers![1].cornerRadius = 7
        gradeProgressView.subviews[1].clipsToBounds = true
    }
    
    private func pushToNicknameViewController() {
        let nicknameStoryboard = UIStoryboard(name: Const.Storyboard.Name.nickname, bundle: nil)
        guard let nicknameViewController = nicknameStoryboard.instantiateViewController(withIdentifier: Const.ViewController.Identifier.nickname) as? NicknameViewController else {
            return
        }
        nicknameViewController.nicknameViewUsage = .mypage
        self.navigationController?.pushViewController(nicknameViewController, animated: true)
    }
    
    private func pushToSettingViewController() {
        let settingStoryboard = UIStoryboard(name: Const.Storyboard.Name.setting, bundle: nil)
        guard let settingeViewController = settingStoryboard.instantiateViewController(withIdentifier: Const.ViewController.Identifier.setting) as? SettingViewController else {
            return
        }
        self.navigationController?.pushViewController(settingeViewController, animated: true)
    }
    
    // MARK: - @IBAction Functions
    
    @IBAction func touchEditNicknameButton(_ sender: Any) {
        self.hidesBottomBarWhenPushed = true
        pushToNicknameViewController()
        self.hidesBottomBarWhenPushed = false // 아니면 뷰디로에 이거 설정해줘도 됨
    }

}
