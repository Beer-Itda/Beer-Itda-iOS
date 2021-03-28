//
//  LoginMethodViewController.swift
//  Beer-Itda
//
//  Created by 초이 on 2021/03/20.
//

import UIKit

class LoginMethodViewController: UIViewController {

    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initializeNavigationBar()
    }
    
    // MARK: - @IBAction Functions
    
    @IBAction func touchKakaoLoginButton(_ sender: Any) {
        pushToNicknameViewController()
    }
    
    // MARK: - Functions
    
    private func initializeNavigationBar() {
        self.navigationController?.initializeNavigationBarWithoutBackButton(navigationItem: self.navigationItem)
    }
    
    private func pushToNicknameViewController() {
        let nicknameStoryboard = UIStoryboard(name: Const.Storyboard.Name.nickname, bundle: nil)
        guard let nicknameViewController = nicknameStoryboard.instantiateViewController(withIdentifier: Const.ViewController.Identifier.nickname) as? NicknameViewController else {
            return
        }
        self.navigationController?.pushViewController(nicknameViewController, animated: true)
    }
    
}
