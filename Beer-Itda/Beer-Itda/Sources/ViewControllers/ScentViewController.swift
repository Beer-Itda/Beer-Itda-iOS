//
//  ScentViewController.swift
//  Beer-Itda
//
//  Created by 초이 on 2021/03/20.
//

import UIKit

class ScentViewController: UIViewController {
    
    // MARK: - Properties
    
    let screenWidth = UIScreen.main.bounds.width
    
    // MARK: - @IBOutlet Properties

    @IBOutlet weak var selectedScentCollectionView: UICollectionView!
    @IBOutlet weak var scentCollectionView: UICollectionView!
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        assignDelegate()
        assignDataSource()
        registerXib()
        initializeNavigationBar()
    }
    
    // MARK: - Functions
    
    
    private func registerXib() {
        selectedScentCollectionView.register(UINib(nibName: Const.Xib.Name.selectedFilterCollectionViewCell, bundle: nil), forCellWithReuseIdentifier: Const.Xib.Identifier.selectedFilterCollectionViewCell)
        scentCollectionView.register(UINib(nibName: Const.Xib.Name.roundedSquareCollectionViewCell, bundle: nil), forCellWithReuseIdentifier: Const.Xib.Identifier.roundedSquareCollectionViewCell)
    }
    
    private func initializeNavigationBar() {
        self.navigationController?.initializeNavigationBarWithBackButton(navigationItem: self.navigationItem)
    }
    
}

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
