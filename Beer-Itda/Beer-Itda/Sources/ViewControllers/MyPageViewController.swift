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
        self.hidesBottomBarWhenPushed = true
        pushToSettingViewController()
        self.hidesBottomBarWhenPushed = false
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
    
    private func pushToBeerAllViewController() {
        let beerAllStoryboard = UIStoryboard(name: Const.Storyboard.Name.beerAll, bundle: nil)
        guard let beerAllViewController = beerAllStoryboard.instantiateViewController(withIdentifier: Const.ViewController.Identifier.beerAll) as? BeerAllViewController else {
            return
        }
        beerAllViewController.navTitle = "찜한 맥주"
        beerAllViewController.isFilterCollectionViewHidden = true
        self.navigationController?.pushViewController(beerAllViewController, animated: true)
    }
    
    private func pushToMyReviewViewController() {
        let myReviewStoryboard = UIStoryboard(name: Const.Storyboard.Name.myReview, bundle: nil)
        guard let myReviewViewController = myReviewStoryboard.instantiateViewController(withIdentifier: Const.ViewController.Identifier.myReview) as? MyReviewViewController else {
            return
        }
        self.navigationController?.pushViewController(myReviewViewController, animated: true)
    }
    
    private func pushToLevelGuideViewController() {
        let levelGuideStoryboard = UIStoryboard(name: Const.Storyboard.Name.levelGuide, bundle: nil)
        guard let levelGuideViewController = levelGuideStoryboard.instantiateViewController(withIdentifier: Const.ViewController.Identifier.levelGuide) as? LevelGuideViewController else {
            return
        }
        self.navigationController?.pushViewController(levelGuideViewController, animated: true)
    }
    
    // MARK: - @IBAction Functions
    
    @IBAction func touchEditNicknameButton(_ sender: Any) {
        self.hidesBottomBarWhenPushed = true
        pushToNicknameViewController()
        self.hidesBottomBarWhenPushed = false
    }
    
    @IBAction func touchRatingAndReviewButton(_ sender: Any) {
        self.hidesBottomBarWhenPushed = true
        pushToMyReviewViewController()
        self.hidesBottomBarWhenPushed = false
    }
    
    @IBAction func touchLikedBeerButton(_ sender: Any) {
        self.hidesBottomBarWhenPushed = true
        pushToBeerAllViewController()
        self.hidesBottomBarWhenPushed = false
    }
    
    @IBAction func touchLevelGuideButton(_ sender: Any) {
        self.hidesBottomBarWhenPushed = true
        pushToLevelGuideViewController()
        self.hidesBottomBarWhenPushed = false
    }
}
