//
//  StyleViewController.swift
//  Beer-Itda
//
//  Created by 초이 on 2021/03/20.
//

import UIKit

class StyleViewController: UIViewController {
    
    // MARK: - Properties
    
    enum StyleViewUsage: Int {
        case onboarding = 0, main
    }
    
    var styleViewUsage: StyleViewUsage?
    
    // MARK: - @IBOutlet Properties
    
    @IBOutlet weak var selectedStyleCollectionView: UICollectionView!
    @IBOutlet weak var largeCategorySegmentedControl: UISegmentedControl!
    @IBOutlet weak var mediumCategoryCollectionView: UICollectionView!
    @IBOutlet weak var smallCategoryCollectionView: UICollectionView!
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 뷰 트랜지션 적용 전까지 임시로 usage 지정
        styleViewUsage = .onboarding
        
        initializeNavigationBar()
    }
    
    // MARK: - @IBAction Properties
    
    @IBAction func touchSelectButton(_ sender: Any) {
        pushToScentViewController()
    }
    
    // MARK: - Functions
    
    private func initializeNavigationBar() {
        
        switch self.styleViewUsage {
        case .onboarding:
            self.navigationController?.initializeNavigationBarWithoutBackButton(navigationItem: self.navigationItem)
        case .main:
            self.navigationController?.initializeNavigationBarWithBackButton(navigationItem: self.navigationItem)
        default:
            return
        }
    }
    
    private func pushToScentViewController() {
        let scentStoryboard = UIStoryboard(name: Const.Storyboard.Name.scent, bundle: nil)
        guard let scentViewController = scentStoryboard.instantiateViewController(withIdentifier: Const.ViewController.Identifier.scent) as? ScentViewController else {
            return
        }
        self.navigationController?.pushViewController(scentViewController, animated: true)
    }
}
