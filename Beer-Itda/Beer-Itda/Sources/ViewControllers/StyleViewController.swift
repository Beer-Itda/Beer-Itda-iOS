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
        
        registerXib()
        assignDelegate()
        assignDataSource()
        initializeNavigationBar()
    }
    
    // MARK: - @IBAction Properties
    
    @IBAction func touchSelectButton(_ sender: Any) {
        pushToScentViewController()
    }
    
    // MARK: - Functions
    
    private func registerXib() {
        selectedStyleCollectionView.register(UINib(nibName: Const.Xib.Name.selectedFilterCollectionViewCell, bundle: nil), forCellWithReuseIdentifier: Const.Xib.Identifier.selectedFilterCollectionViewCell)
    }
    
    private func assignDelegate() {
        
    }
    
    private func assignDataSource() {
        selectedStyleCollectionView.dataSource = self
    }
    
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

// MARK: - UICollectionViewDataSource

extension StyleViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = selectedStyleCollectionView.dequeueReusableCell(withReuseIdentifier: Const.Xib.Identifier.selectedFilterCollectionViewCell, for: indexPath) as? SelectedFilterCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        let titles = ["전체보기", "Bourbon County Stout", "Bourbon County Stout"]
        
        cell.setCell(title: titles[indexPath.row])
        
        return cell
    }
}
