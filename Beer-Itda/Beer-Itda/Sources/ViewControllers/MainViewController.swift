//
//  ViewController.swift
//  Beer-Itda
//
//  Created by 초이 on 2021/03/17.
//

import UIKit

class MainViewController: UIViewController {
    
    // MARK: - Properties
    
    var headerView: BeerAwardHeaderView?
    
    enum Title: String {
        case style = "회원님이 좋아하는 스타일"
        case scent = "회원님이 좋아하는 향"
        case recommend = "이런 맥주는 어떠세요?"
    }
    
    enum IsStyleScentSkipped: Int {
        // style, scent 순서
        case unskipUnskip = 0, unskipSkip, skipUnskip, skipSkip
    }
    
    var isStyleScentSkipped: IsStyleScentSkipped?
    
    let coachmarkView = UIView()
    
    // beer lists
    var styleBeers: [Beer] = [] {
        didSet {
            DispatchQueue.main.async {
                self.mainTableView.reloadData()
            }
            print(styleBeers)
        }
    }
    var scentBeers: [Beer] = [] {
        didSet {
            DispatchQueue.main.async {
                self.mainTableView.reloadData()
            }
        }
    }
    var randomBeers: [Beer] = [] {
        didSet {
            DispatchQueue.main.async {
                self.mainTableView.reloadData()
            }
        }
    }
    
    // MARK: - @IBOutlet Properties
    
    @IBOutlet weak var mainTableView: UITableView!
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        registerXib()
        assignDelegate()
        assignDataSource()
        initNavigationBar()
        initFilterButton()
        initCoachmarkView()
        
        initDataByEnum()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        self.initHeaderView()
    }
    
    // MARK: - @IBAction Functions
    
    // MARK: - Functions
    
    private func registerXib() {
        self.headerView = Bundle.main.loadNibNamed(Const.Xib.Name.beerAwardHeaderView, owner: self, options: nil)?.last as? BeerAwardHeaderView
        
        mainTableView.register(UINib(nibName: Const.Xib.Name.mainTableViewCell, bundle: nil), forCellReuseIdentifier: Const.Xib.Identifier.mainTableViewCell)
        mainTableView.register(UINib(nibName: Const.Xib.Name.bottleShopTableViewCell, bundle: nil), forCellReuseIdentifier: Const.Xib.Identifier.bottleShopTableViewCell)
        
    }
    
    // MARK: assign functions
    
    private func assignDelegate() {
        mainTableView.delegate = self
    }
    
    private func assignDataSource() {
        mainTableView.dataSource = self
    }
    
    // MARK: init functions
    
    private func initHeaderView() {
        self.mainTableView.tableHeaderView = self.headerView
        self.mainTableView.tableHeaderView?.frame.size.height = 300
        
        // tap gesture recognizer 추가
        let beerAwardGesture: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(touchBeerAward(_:)))
        self.mainTableView.tableHeaderView?.addGestureRecognizer(beerAwardGesture)
    }
    
    private func initNavigationBar() {
        self.navigationController?.initializeNavigationBarWithoutBackButton(navigationItem: self.navigationItem)
    }
    
    private func initFilterButton() {
        // 필터 버튼
        let filterButton = UIBarButtonItem(image: Const.Image.btnFilter, style: .plain, target: self, action: #selector(touchFilterButton))
        filterButton.tintColor = UIColor.Black

        self.navigationItem.leftBarButtonItem = filterButton
    }
    
    private func initCoachmarkView() {
        
        let window = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
        
        // coackmark
        coachmarkView.isHidden = false
        coachmarkView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        
        if let customView = Bundle.main.loadNibNamed(Const.Xib.Name.coackMarkView, owner: nil, options: nil)?.first as? CoachMarkView {
            customView.frame = self.coachmarkView.bounds
            customView.completeButton.addTarget(self, action: #selector(touchCoachmark(_:)), for: .touchUpInside)
            coachmarkView.addSubview(customView)
        }
         
        window?.addSubview(coachmarkView)
        
    }
    
    private func initDataByEnum() {
        switch isStyleScentSkipped {
        case .unskipUnskip:
            // 스타일, 향, 이맥어
            getStyleBeerList(style: UserTaste.shared.style)
            getScentBeerList(scent: UserTaste.shared.scent)
        
        case .unskipSkip:
            // 스타일, 이맥어
            getStyleBeerList(style: UserTaste.shared.style)
            
        case .skipUnskip:
            // 향, 이맥어
            getScentBeerList(scent: UserTaste.shared.scent)
            
        case .skipSkip:
            // 이맥어
            return
            
        case .none:
            return
        }
    }
    
    // MARK: @objc functions
    
    @objc func touchFilterButton() {
        let styleStoryboard = UIStoryboard(name: Const.Storyboard.Name.style, bundle: nil)
        guard let styleViewController = styleStoryboard.instantiateViewController(withIdentifier: Const.ViewController.Identifier.style) as? StyleViewController else {
            return
        }
        styleViewController.styleViewUsage = .main
        self.navigationController?.pushViewController(styleViewController, animated: true)
    }
    
    @objc func touchCoachmark(_ gesture: UITapGestureRecognizer) {
        for view in coachmarkView.subviews {
            view.removeFromSuperview()
        }
        coachmarkView.isHidden = true
    }
    
    @objc func touchBeerAward(_ gesture: UITapGestureRecognizer) {
        self.pushToBeerDetailViewController()
    }
    
    // MARK: Transition Functions
    
    func pushToBeerDetailViewController() {
        let beerDetailStoryboard = UIStoryboard(name: Const.Storyboard.Name.beerDetail, bundle: nil)
        guard let beerDetailViewController = beerDetailStoryboard.instantiateViewController(withIdentifier: Const.ViewController.Identifier.beerDetail) as? BeerDetailViewController else {
            return
        }
        self.navigationController?.pushViewController(beerDetailViewController, animated: true)
    }
}

// MARK: - UITableViewDelegate

extension MainViewController: UITableViewDelegate {
    
}

// MARK: - UITableViewDataSource

extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        // skip 여부에 따라 cell 분기처리
        switch isStyleScentSkipped {
        case .unskipUnskip:
            return 4
            
        case .unskipSkip:
            return 3
            
        case .skipUnskip:
            return 3
            
        case .skipSkip:
            return 2
            
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // skip 여부에 따라 cell 분기처리
        switch isStyleScentSkipped {
        
        case .unskipUnskip:
            return returnUnskipUnskipTableViewCells(indexPath: indexPath)
            
        case .unskipSkip:
            return returnUnskipSkipTableViewCells(indexPath: indexPath)
            
        case .skipUnskip:
            return returnSkipUnskipTableViewCells(indexPath: indexPath)
            
        case .skipSkip:
            return returnSkipSkipTableViewCells(indexPath: indexPath)
            
        default:
            return UITableViewCell()
        }
    }
    
    func returnMainTableViewCell(title: String, indexPath: IndexPath, beers: [Beer]) -> UITableViewCell {
        if let cell = mainTableView.dequeueReusableCell(withIdentifier: Const.Xib.Identifier.mainTableViewCell) as? MainTableViewCell {
            
            // cell에 데이터를 넣어주는 부분
            cell.setCell(title: title, beers: beers)
            DispatchQueue.main.async {
                cell.mainCollectionView.reloadData()
            }
            
            // tag 정하기
            var tagNum: Int = 9
            
            switch title {
            case Title.style.rawValue:
                tagNum = 0
            case Title.scent.rawValue:
                tagNum = 1
            case Title.recommend.rawValue:
                tagNum = 2
            default:
                tagNum = 9
            }
            
            // more button handler
            cell.moreButton.tag = tagNum
            cell.moreButton.addTarget(self, action: #selector(pushToBeerAllViewController), for: .touchUpInside)
            
            cell.cellDelegate = self
            
            return cell
        }
        return UITableViewCell()
    }
    
    func returnBottleShopTableViewCell() -> UITableViewCell {
        if let cell = mainTableView.dequeueReusableCell(withIdentifier: Const.Xib.Identifier.bottleShopTableViewCell) as? BottleShopTableViewCell {
            return cell
        }
        return UITableViewCell()
    }
    
    // skip 관련 Enum에 따라서 row 별 UITableViewCell 반환하는 함수들 4개
    
    func returnUnskipUnskipTableViewCells(indexPath: IndexPath) -> UITableViewCell {
        // unskip - unskip 일 때 (cell 4개)
        switch indexPath.row {
        case 0:
            return returnMainTableViewCell(title: Title.style.rawValue, indexPath: indexPath, beers: styleBeers)
        case 1:
            return returnMainTableViewCell(title: Title.scent.rawValue, indexPath: indexPath, beers: scentBeers)
        case 2:
            // 우리집 주변 바틀샵
            return returnBottleShopTableViewCell()
        case 3:
            return returnMainTableViewCell(title: Title.recommend.rawValue, indexPath: indexPath, beers: randomBeers)
        default:
            return UITableViewCell()
        }
    }
    
    func returnUnskipSkipTableViewCells(indexPath: IndexPath) -> UITableViewCell {
        // unskip - skip 일 때 (cell 3개)
        switch indexPath.row {
        case 0:
            return returnMainTableViewCell(title: Title.style.rawValue, indexPath: indexPath, beers: styleBeers)
        case 1:
            // 우리집 주변 바틀샵
            return returnBottleShopTableViewCell()
        case 2:
            return returnMainTableViewCell(title: Title.recommend.rawValue, indexPath: indexPath, beers: randomBeers)
        default:
            return UITableViewCell()
        }
    }
    
    func returnSkipUnskipTableViewCells(indexPath: IndexPath) -> UITableViewCell {
        // skip - unskip 일 때 (cell 3개)
        switch indexPath.row {
        case 0:
            return returnMainTableViewCell(title: Title.scent.rawValue, indexPath: indexPath, beers: scentBeers)
        case 1:
            // 우리집 주변 바틀샵
            return returnBottleShopTableViewCell()
        case 2:
            return returnMainTableViewCell(title: Title.recommend.rawValue, indexPath: indexPath, beers: randomBeers)
        default:
            return UITableViewCell()
        }
    }
    
    func returnSkipSkipTableViewCells(indexPath: IndexPath) -> UITableViewCell {
        // skip - skip 일 때 (cell 2개)
        switch indexPath.row {
        case 0:
            // 우리집 주변 바틀샵
            return returnBottleShopTableViewCell()
        case 1:
            return returnMainTableViewCell(title: Title.recommend.rawValue, indexPath: indexPath, beers: randomBeers)
        default:
            return UITableViewCell()
        }
    }
    
    // more 버튼을 눌렀을때 호출되는 함수
    @objc func pushToBeerAllViewController(sender: UIButton) {
        
        let beerAllStoryboard = UIStoryboard(name: Const.Storyboard.Name.beerAll, bundle: nil)
        guard let beerAllViewController = beerAllStoryboard.instantiateViewController(withIdentifier: Const.ViewController.Identifier.beerAll) as? BeerAllViewController else {
            return
        }
        
        switch sender.tag {
        case 0:
            // 회원님이 좋아하는 스타일
            beerAllViewController.navTitle = Title.style.rawValue
            beerAllViewController.isFilterCollectionViewHidden = false
            beerAllViewController.dataKindFromMain = .style
        case 1:
            // 회원님이 좋아하는 향
            beerAllViewController.navTitle = Title.scent.rawValue
            beerAllViewController.isFilterCollectionViewHidden = false
            beerAllViewController.dataKindFromMain = .scent
        case 2:
            // 이런 맥주는 어떠세요?
            beerAllViewController.navTitle = Title.recommend.rawValue
            beerAllViewController.isFilterCollectionViewHidden = true
            beerAllViewController.dataKindFromMain = .recommend
        default:
            beerAllViewController.navTitle = ""
            beerAllViewController.dataKindFromMain = .none
        }
        
        beerAllViewController.beerAllUsage = .main
        self.navigationController?.pushViewController(beerAllViewController, animated: true)
    }
    
    // 각 row의 height 지정
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        // skip 여부에 따라 cell 분기처리
        switch isStyleScentSkipped {
        case .unskipUnskip:
            if indexPath.row == 2 {
                return 130
            }
            
        case .unskipSkip:
            if indexPath.row == 1 {
                return 130
            }
            
        case .skipUnskip:
            if indexPath.row == 1 {
                return 130
            }
            
        case .skipSkip:
            if indexPath.row == 0 {
                return 130
            }
            
        default:
            return 0
        }
        
       return 320
    }
}

extension MainViewController: CollectionViewCellDelegate {
    func collectionView(collectionviewcell: MainCollectionViewCell?, index: Int, didTappedInTableViewCell: MainTableViewCell) {

        self.pushToBeerDetailViewController()
    }
}

extension MainViewController {
    
    // 통신 function
    
    // style
    func getStyleBeerList(style: [String]) {
             
             BeerListAPI.shared.getBeerList(minAbv: nil,
                                            maxAbv: nil,
                                            style: style,
                                            scent: nil,
                                            cursor: nil,
                                            maxCount: nil,
                                            sort: nil) { (response) in
                 
                 switch response {
                 case .success(let beerList):
                     if let data = beerList as? BeerList {
                         
                        self.styleBeers = data.beers
                        DispatchQueue.main.async {
                            // self.mainTableView.reloadData()
                        }
                        
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
    func getScentBeerList(scent: [String]) {
             
             BeerListAPI.shared.getBeerList(minAbv: nil,
                                            maxAbv: nil,
                                            style: nil,
                                            scent: scent,
                                            cursor: nil,
                                            maxCount: nil,
                                            sort: nil) { (response) in
                 
                 switch response {
                 case .success(let beerList):
                     if let data = beerList as? BeerList {
                         
                        self.scentBeers = data.beers
                        
                        DispatchQueue.main.async {
                            // self.mainTableView.reloadData()
                        }
                        
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
