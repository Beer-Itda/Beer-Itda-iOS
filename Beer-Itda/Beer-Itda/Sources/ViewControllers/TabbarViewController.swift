//
//  TabbarViewController.swift
//  Beer-Itda
//
//  Created by 초이 on 2021/03/28.
//

import UIKit

class TabbarViewController: UITabBarController {
    
    // MARK: - View Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        initNavigationBar()
        
        // TODO: - tabbar 진입점이 무조건 Main인지 확인 필요
        initFilterButton()
    }
    
    // MARK: - Functions
    
    private func initNavigationBar() {
        self.navigationController?.initializeNavigationBarWithoutBackButton(navigationItem: self.navigationItem)
    }
    
    @objc func touchFilterButton() {
        let styleStoryboard = UIStoryboard(name: Const.Storyboard.Name.style, bundle: nil)
        guard let styleViewController = styleStoryboard.instantiateViewController(withIdentifier: Const.ViewController.Identifier.style) as? StyleViewController else {
            return
        }
        styleViewController.styleViewUsage = .main
        self.navigationController?.pushViewController(styleViewController, animated: true)
    }
    
    private func initFilterButton() {
        // 필터 버튼
        let filterButton = UIBarButtonItem(image: Const.Image.btnFilter, style: .plain, target: self, action: #selector(touchFilterButton))
        filterButton.tintColor = UIColor.Black

        self.navigationItem.leftBarButtonItem = filterButton
    }

}

// MARK: - UITabBarControllerDelegate

extension TabbarViewController: UITabBarControllerDelegate {
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        switch item.title! {
        case "메인":
            initFilterButton()
        default:
            self.navigationItem.leftBarButtonItem = nil
        }
    }
    
}
