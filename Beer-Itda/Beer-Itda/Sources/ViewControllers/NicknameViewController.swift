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

    // MARK: - Functions
    
    private func initializeNavigationBar() {
        self.navigationController?.initializeNavigationBarWithBackButton(navigationItem: self.navigationItem)
    }

}
