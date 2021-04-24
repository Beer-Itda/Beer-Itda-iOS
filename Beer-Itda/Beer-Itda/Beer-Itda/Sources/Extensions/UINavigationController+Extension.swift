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
        isNavigationBarHidden = false
        navigationBar.barTintColor = UIColor.white
        navigationBar.shadowImage = UIImage()
        navigationBar.isTranslucent = false
        
        // back button 설정
        let backButton = UIBarButtonItem(image: UIImage(systemName: "chevron.backward"), style: .plain, target: self, action: #selector(touchBackButton))
        backButton.tintColor = UIColor.Black

        navigationItem?.leftBarButtonItem = backButton
    }
    
    @objc func touchBackButton() {
        popViewController(animated: true)
    }
    
    // back button이 없는 navi bar
    func initializeNavigationBarWithoutBackButton(navigationItem: UINavigationItem?) {
        isNavigationBarHidden = false
        navigationBar.barTintColor = UIColor.white
        navigationBar.shadowImage = UIImage()
        navigationBar.isTranslucent = false
        
        // back button 숨기기
        navigationItem?.hidesBackButton = true
    }
}
