//
//  UINavigationController+Extension.swift
//  Beer-Itda
//
//  Created by 초이 on 2021/03/28.
//

import UIKit

extension UINavigationController {
    
    // MARK: - Functions
    
    // navi bar 숨기기
    func hideNavigationBar() {
        // navigation bar 투명화
        navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationBar.shadowImage = UIImage()
        navigationBar.isTranslucent = true
        
        // navigation bar 숨기기
        isNavigationBarHidden = true
    }
    
    // back button이 있는 navi bar
    func initializeNavigationBarWithBackButton(navigationItem: UINavigationItem?) {
        navigationBar.barTintColor = UIColor.Black
        navigationBar.shadowImage = UIImage()
        navigationBar.isTranslucent = false
        
        // back button 설정
        navigationBar.backIndicatorImage = UIImage(systemName: "chevron.backward")
        navigationBar.backIndicatorTransitionMaskImage = UIImage(systemName: "chevron.backward")
        navigationItem?.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationItem?.backBarButtonItem?.tintColor = .white
    }
    
    @objc func touchBackButton() {
        popViewController(animated: true)
    }
    
    // back button이 없는 navi bar
    func initializeNavigationBarWithoutBackButton(navigationItem: UINavigationItem?) {
        navigationBar.barTintColor = UIColor.Black
        navigationBar.shadowImage = UIImage()
        navigationBar.isTranslucent = false
        
        // back button 숨기기
        navigationItem?.hidesBackButton = true
    }
}
