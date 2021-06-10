//
//  TabbarViewController.swift
//  Beer-Itda
//
//  Created by 초이 on 2021/03/28.
//

import UIKit

class TabbarViewController: UITabBarController {
    
    // MARK: - Properties
    
    enum IsStyleScentSkipped: Int {
            // style, scent 순서
            case unskipUnskip = 0, unskipSkip, skipUnskip, skipSkip
        }
        
        var isStyleScentSkipped: IsStyleScentSkipped?
    
    // MARK: - View Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        initMainSkipEnum()
    }
    
    // MARK: - Functions
    
    private func initMainSkipEnum() {
        // style, scent 뷰 skip 관련 enum 값 전달
        guard let navigationController = self.viewControllers?[0] as? UINavigationController else {
            return
        }
        
        guard let mainViewController = navigationController.topViewController as? MainViewController else {
            return
        }
        
        if isStyleScentSkipped != nil {
            
            switch self.isStyleScentSkipped {
            case .unskipUnskip:
                mainViewController.isStyleScentSkipped = .unskipUnskip
                
            case .unskipSkip:
                mainViewController.isStyleScentSkipped = .unskipSkip
                
            case.skipUnskip:
                mainViewController.isStyleScentSkipped = .skipUnskip
                
            case .skipSkip:
                mainViewController.isStyleScentSkipped = .skipSkip
                
            default:
                return
            }
        } else {
            print("여기부터 안됨")
        }
    }
}
