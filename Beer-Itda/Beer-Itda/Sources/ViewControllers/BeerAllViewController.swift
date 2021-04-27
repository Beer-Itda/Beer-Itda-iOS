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
    }
    
    // MARK: - @IBAction Functions
    
    @IBAction func touchFilterMethodButton(_ sender: Any) {
    }
    
    // MARK: - Functions
    
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
