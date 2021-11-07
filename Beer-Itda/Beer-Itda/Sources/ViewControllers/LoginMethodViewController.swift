//
//  LoginMethodViewController.swift
//  Beer-Itda
//
//  Created by 초이 on 2021/03/20.
//

import UIKit

class LoginMethodViewController: UIViewController {
    
    // MARK: - @IBOutlet Properties
    
    @IBOutlet weak var appleLoginButton: UIButton!
    @IBOutlet weak var kakaoLoginButton: UIButton!
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initializeNavigationBar()
        initLoginButtonRadius()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        initializeNavigationBar()
    }
    
    // MARK: - @IBAction Functions
    
    @IBAction func touchKakaoLoginButton(_ sender: Any) {
        pushToNicknameViewController()
    }
    
    @IBAction func touchAppleLoginButton(_ sender: Any) {
        pushToNicknameViewController()
    }
    
    // MARK: - Functions
    
    private func initializeNavigationBar() {
        self.navigationController?.initTransparentNavBar()
    }
    
    private func initLoginButtonRadius() {
        appleLoginButton.makeRounded(radius: 12)
        kakaoLoginButton.makeRounded(radius: 12)
    }
    
    private func pushToNicknameViewController() {
        let nicknameStoryboard = UIStoryboard(name: Const.Storyboard.Name.nickname, bundle: nil)
        guard let nicknameViewController = nicknameStoryboard.instantiateViewController(withIdentifier: Const.ViewController.Identifier.nickname) as? NicknameViewController else {
            return
        }
        nicknameViewController.nicknameViewUsage = .onboarding
        self.navigationController?.pushViewController(nicknameViewController, animated: true)
    }
    
}
