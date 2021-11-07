//
//  UINavigationController+Extension.swift
//  Beer-Itda
//
//  Created by 초이 on 2021/03/28.
//

import UIKit

extension UINavigationController {
    
    // MARK: - 투명
    
    // navi bar 숨기기
    func initTransparentNavBar() {
        // navigation bar 투명화
        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()
        self.navigationBar.standardAppearance = appearance
        self.navigationBar.scrollEdgeAppearance = appearance
    }
    
    // MARK: - 뒤로가기 버튼
    
    func initWithBackButton(backgroundColor: UIColor? = .white) {
        let appearance = UINavigationBarAppearance()
        appearance.initBackButtonAppearance()
        
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = backgroundColor
        appearance.shadowColor = .clear
        self.navigationBar.barTintColor = backgroundColor // for iOS14
        
        self.navigationBar.standardAppearance = appearance
        self.navigationBar.scrollEdgeAppearance = appearance
        self.navigationBar.tintColor = .black
    }
    
    @objc func touchBackButton() {
        popViewController(animated: true)
    }
    
    // MARK: - 뒤로가기 버튼 + 커스텀 버튼 1개
    
    func initWithOneCustomButton(navigationItem: UINavigationItem?, firstButtonImage: UIImage, firstButtonClosure: Selector, backgroundColor: UIColor? = nil) {
        initWithBackButton(backgroundColor: backgroundColor)
        
        let firstButton = UIBarButtonItem(image: firstButtonImage, style: .plain, target: self.topViewController, action: firstButtonClosure)
        navigationItem?.rightBarButtonItem = firstButton
        
    }
    
    // MARK: - back button이 없는 navi bar
    
    func initWithoutBackButton(navigationItem: UINavigationItem?, backgroundColor: UIColor? = .white) {
        isNavigationBarHidden = false
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        
        appearance.backgroundColor = backgroundColor
        appearance.shadowColor = .clear
        self.navigationBar.barTintColor = backgroundColor // for iOS14
        
        self.navigationBar.standardAppearance = appearance
        self.navigationBar.scrollEdgeAppearance = appearance
        
        // back button 숨기기
        navigationItem?.hidesBackButton = true
    }
}

extension UINavigationBarAppearance {
    
    func initBackButtonAppearance() {
        // back button image
        var backButtonImage: UIImage? {
            return Const.Image.btnBack
        }
        // back button appearance
        var backButtonAppearance: UIBarButtonItemAppearance {
            let backButtonAppearance = UIBarButtonItemAppearance()
            // backButton 우측에 표출되는 text를 안보이게 설정
            backButtonAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor.clear, .font: UIFont.systemFont(ofSize: 0.0)]

            return backButtonAppearance
        }
        self.setBackIndicatorImage(backButtonImage, transitionMaskImage: backButtonImage)
        self.backButtonAppearance = backButtonAppearance
    }
}
