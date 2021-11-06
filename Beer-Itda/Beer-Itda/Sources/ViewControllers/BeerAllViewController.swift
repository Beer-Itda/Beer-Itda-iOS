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
    @IBOutlet weak var filterMethodButton: UIButton!
    @IBOutlet weak var beerAllTableView: UITableView!
    @IBOutlet weak var collectionContainerHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var sortViewHeightConstraint: NSLayoutConstraint!
    
    // MARK: - Properties
    
    var navTitle = ""
    var isFilterCollectionViewHidden = false
    
    enum BeerAllUsage: Int {
        case main = 0, mypage
    }
    
    enum DataKindFromMain: Int {
        case style = 0, scent, recommend
    }
    
    var beerAllUsage: BeerAllUsage?
    var dataKindFromMain: DataKindFromMain?
    
    // var beerList = BeerList(beers: [Beer(id: 0, name: "크리스마스 이브 엣 어 뉴욕 서울 시티...", brewery: "Christmas Eve at a NewYork Seoul P City Hotel...", abv: 0, country: "", beerStyle: "", aroma: [], thumbnailImage: "", rateAvg: 0, reviewCount: 0, favoriteFlag: true)], nextCursor: 0)
    // BeerList(beers: [], nextCursor: nil)
    
    // MARK: - View Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        initNavigationBar()
        assignDelegate()
        assignDataSource()
        registerXib()
        initFilterCollectionView()
        initSortButton()
        initDataByEnum()
    }
    
    // MARK: - @IBAction Functions
    
    @IBAction func touchFilterMethodButton(_ sender: Any) {
    }
    
    // MARK: - Functions
    
    private func assignDelegate() {
        filterCollectionView.delegate = self
        beerAllTableView.delegate = self
    }
    
    private func assignDataSource() {
        filterCollectionView.dataSource = self
        beerAllTableView.dataSource = self
    }
   
    private func registerXib() {
        filterCollectionView.register(UINib(nibName: Const.Xib.Name.favoriteCollectionViewCell, bundle: nil), forCellWithReuseIdentifier: Const.Xib.Identifier.favoriteCollectionViewCell)
        beerAllTableView.register(UINib(nibName: Const.Xib.Name.beerTableViewCell, bundle: nil), forCellReuseIdentifier: Const.Xib.Identifier.beerTableViewCell)
    }
    
    private func initNavigationBar() {
        self.navigationController?.initializeNavigationBarWithoutBackButton(navigationItem: self.navigationItem)
        
        // back button 설정
        let backButton = UIBarButtonItem(image: UIImage(systemName: "chevron.backward"), style: .plain, target: self, action: #selector(touchBackButton))
        backButton.tintColor = UIColor.Black

        navigationItem.title = navTitle
        navigationItem.leftBarButtonItem = backButton
    }
    
    private func initFilterCollectionView() {
        if isFilterCollectionViewHidden {
            filterCollectionView.isHidden = true
            collectionContainerView.isHidden = true
            collectionContainerHeightConstraint.constant = 0
        } else {
            filterCollectionView.isHidden = false
            collectionContainerView.isHidden = false
            collectionContainerHeightConstraint.constant = 74
        }
    }
    
    private func initDataByEnum() {
        switch dataKindFromMain {
        case .style:
            getStyleBeerList(style: UserTaste.shared.style, cursor: nil, sort: nil)
        case .scent:
            getScentBeerList(scent: UserTaste.shared.scent, cursor: nil, sort: nil)
        case .recommend:
            break
        case .none:
            break
        }
    }
    
    @objc func touchBackButton() {
        self.navigationController?.popViewController(animated: true)
    }
    
    private func initSortButton() {
        if beerAllUsage == .main {
            filterMethodLabel.isHidden = false
            filterMethodButton.isHidden = false
            sortViewHeightConstraint.constant = 44
        } else {
            filterMethodLabel.isHidden = true
            filterMethodButton.isHidden = true
            sortViewHeightConstraint.constant = 0
        }
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
        
        switch dataKindFromMain {
        case .style:
            return UserTaste.shared.style.count + 1
        case .scent:
            return UserTaste.shared.scent.count + 1
        case .recommend:
            return 0
        case .none:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = filterCollectionView.dequeueReusableCell(withReuseIdentifier: Const.Xib.Identifier.favoriteCollectionViewCell, for: indexPath) as? FavoriteCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        // font 처리
        if indexPath.row == 0 {
            cell.setCell(title: "전체보기")
        } else {
            switch dataKindFromMain {
            case .style:
                cell.setCellWithFont(title: UserTaste.shared.style[indexPath.row - 1])
            case .scent:
                cell.setCellWithFont(title: UserTaste.shared.scent[indexPath.row - 1])
            case .recommend:
                break
            case .none:
                break
            }
        }
        
        return cell
    }
     
}

// MARK: - UITableViewDelegate

extension BeerAllViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 166
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if beerAllUsage == .mypage {
            return 29
        }
        return 1
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        if beerAllUsage == .mypage {
            let header = UIView()
            header.backgroundColor = UIColor.white
            return header
        } else {
            return UIView()
        }
    }
    
}

// MARK: - UITableViewDataSource

extension BeerAllViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // return beerList.beers.count
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = beerAllTableView.dequeueReusableCell(withIdentifier: Const.Xib.Identifier.beerTableViewCell, for: indexPath) as? BeerTableViewCell else {
            return UITableViewCell()
        }
        
        // cell.setCell(beer: beerList.beers[indexPath.row])
        
        return cell
    }
        
}

// MARK: - 서버 통신 API functions

extension BeerAllViewController {
    
    // 통신 function
    
    // style
    func getStyleBeerList(style: [String], cursor: Int?, sort: Sort?) {
             
             BeerListAPI.shared.getBeerList(minAbv: nil,
                                            maxAbv: nil,
                                            style: style,
                                            scent: nil,
                                            cursor: cursor,
                                            maxCount: nil,
                                            sort: sort) { (response) in
                 
                 switch response {
                 case .success(let beerList):
                     if let data = beerList as? BeerList {
                         
                        // self.beerList = data
                        self.beerAllTableView.reloadData()
                        
                     }
                     
                 case .requestErr(let message):
                     print(message)
                     print("requestErr in MainViewController getBeerList")
                     
                 case .pathErr:
                     print("pathErr in MainViewController getBeerList")
                     
                 case .networkFail:
                     print("networkFail in MainViewController getBeerList")
                     
                 case .serverErr:
                     print("serverErr in MainViewController getBeerList")
                 }
             }
         }
    
    // scent
    func getScentBeerList(scent: [String], cursor: Int?, sort: Sort?) {
             
             BeerListAPI.shared.getBeerList(minAbv: nil,
                                            maxAbv: nil,
                                            style: nil,
                                            scent: scent,
                                            cursor: cursor,
                                            maxCount: nil,
                                            sort: sort) { (response) in
                 
                 switch response {
                 case .success(let beerList):
                     if let data = beerList as? BeerList {
                         
                        // self.beerList = data
                        self.beerAllTableView.reloadData()
                        
                     }
                     
                 case .requestErr(let message):
                     print(message)
                     print("requestErr in MainViewController getBeerList")
                     
                 case .pathErr:
                     print("pathErr in MainViewController getBeerList")
                     
                 case .networkFail:
                     print("networkFail in MainViewController getBeerList")
                     
                 case .serverErr:
                     print("serverErr in MainViewController getBeerList")
                 }
             }
         }
    
    // 데이터 갱신 function
    
    func updateData(beerList: BeerList) {
        
    }
}

