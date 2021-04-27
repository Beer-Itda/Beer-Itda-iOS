//
//  BeerAllViewController.swift
//  Beer-Itda
//
//  Created by 초이 on 2021/03/20.
//

import UIKit

class BeerAllViewController: UIViewController {
    
    // MARK: - @IBOutlet Properties
    @IBOutlet weak var collectionContainerView: UIView!
    @IBOutlet weak var filterCollectionView: UICollectionView!
    @IBOutlet weak var filterMethodLabel: UILabel!
    @IBOutlet weak var beerAllTableView: UITableView!
    
    // MARK: - Properties
    
    var navTitle = ""
    
    // MARK: - View Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        initNavigationBar()
        assignDelegate()
        assignDataSource()
        registerXib()
        
    }
    
    // MARK: - @IBAction Functions
    
    @IBAction func touchFilterMethodButton(_ sender: Any) {
    }
    
    // MARK: - Functions
    
    private func assignDelegate() {
        filterCollectionView.delegate = self
    }
    
    private func assignDataSource() {
        filterCollectionView.dataSource = self
    }
   
    private func registerXib() {
        filterCollectionView.register(UINib(nibName: Const.Xib.Name.favoriteCollectionViewCell, bundle: nil), forCellWithReuseIdentifier: Const.Xib.Identifier.favoriteCollectionViewCell)
    }
    
    private func initNavigationBar() {
        self.navigationController?.initializeNavigationBarWithoutBackButton(navigationItem: self.navigationItem)
        
        // back button 설정
        let backButton = UIBarButtonItem(image: UIImage(systemName: "chevron.backward"), style: .plain, target: self, action: #selector(touchBackButton))
        backButton.tintColor = UIColor.Black

        navigationItem.title = navTitle
        navigationItem.leftBarButtonItem = backButton
    }

    @objc func touchBackButton() {
        self.navigationController?.popViewController(animated: true)
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension BeerAllViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 18, bottom: 0, right: 18)
    }
}

// MARK: - UICollectionViewDataSource

extension BeerAllViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = filterCollectionView.dequeueReusableCell(withReuseIdentifier: Const.Xib.Identifier.favoriteCollectionViewCell, for: indexPath) as? FavoriteCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        let titles = ["Bourbon County Stout", "Abbey Ale", "Lambic"]
        
        // font 처리
        if indexPath.row == 0 {
            cell.setCell(title: "전체보기")
        } else {
            cell.setCellWithFont(title: titles[indexPath.row - 1])
        }
        
        return cell
    }
     
}
