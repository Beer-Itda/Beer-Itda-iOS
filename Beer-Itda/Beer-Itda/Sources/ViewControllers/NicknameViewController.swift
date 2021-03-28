//
//  NicknameViewController.swift
//  Beer-Itda
//
//  Created by 초이 on 2021/03/20.
//

import UIKit

class NicknameViewController: UIViewController {

    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initializeNavigationBar()
    }
    
    // MARK: - @IBAction Functions
    
    @IBAction func touchCompleteButton(_ sender: Any) {
        pushToStyleViewController()
    }

    // MARK: - Functions
    
    private func initializeNavigationBar() {
        self.navigationController?.initializeNavigationBarWithBackButton(navigationItem: self.navigationItem)
    }
    
    private func pushToStyleViewController() {
        let styleStoryboard = UIStoryboard(name: Const.Storyboard.Name.style, bundle: nil)
        guard let styleViewController = styleStoryboard.instantiateViewController(withIdentifier: Const.ViewController.Identifier.style) as? StyleViewController else {
            return
        }
        styleViewController.styleViewUsage = .onboarding
        self.navigationController?.pushViewController(styleViewController, animated: true)
    }

}
