//
//  StyleViewController.swift
//  Beer-Itda
//
//  Created by 초이 on 2021/03/20.
//

import UIKit
import Lottie

class StyleViewController: UIViewController {
    
    // MARK: - Properties
    
    // Enum
    enum IsScentSkipped: Int {
        case unskip = 0, skip
    }
    
    // variables
    var isScentSkipped: IsScentSkipped?
    
    // 기기 width
    var screenWidth = UIScreen.main.bounds.width
    
    // TODO: - Style 카테고리화되면 변경해야 함
    var styleList: [[String]] = [
        // 대분류 - Ale
        // 중분류 - Ale
        ["Ale", "Abbey Ale", "Amber Ale", "American Pale Ale", "Barley Wine", "Belgian Ale", "Abbey Ale", "Amber Ale", "American Pale Ale", "Barley Wine", "Belgian Ale", "Abbey Ale", "Amber Ale", "American Pale Ale", "Barley Wine", "Belgian Ale", "Abbey Ale", "Amber Ale", "American Pale Ale", "Barley Wine", "Belgian Ale"],
        
        // 중분류 - IPA
        ["IPA", "American IPA", "Belgian IPA", "Black IPA", "Double IPA",  "American IPA", "Belgian IPA", "Black IPA", "Double IPA",  "American IPA", "Belgian IPA", "Black IPA", "Double IPA"],
        
        // 중분류 - Dark Beer
        ["Dark Beer", "Baltic Porter", "Bourbon County Stout", "Imperial Porter", "Imperial Stout", "Porter", "Stout", "Sweet Stout"],
        
        // 중분류 - Wheat Beer
        ["Wheat Beer", "Belgian White", "Dunkel Weizen", "Hefeweizen", "Weisse", "Weizen", "Witbier"],
        
        // 대분류 - Lager
        // 중분류 - Lager
        ["Lager", "Amber Lager", "Dark Lager", "Dunkel", "Helles Lager", "India Pale Lager", "Kellerbier", "Marzen", "Pale Lager", "Rauchbier", "Schwarz", "Vienna Lager"],
        
        // 중분류 - Bock
        ["Bock", "Double Bock", "MaiBock", "Weizen Bock"],
        
        // 대분류 - Lambic
        // 중분류 - Lambic
        ["Lambic", "Gueuze"],
        
        // 대분류 - etc
        // 중분류 - etc
        ["Cider", "Fruit Beer", "Ginger Beer", "Gluten Free", "Kolsch", "Low Alcohol", "Radler", "Hard Seltzers", "Spiced Beer"]
    ]
    
    // MARK: - @IBOutlet Properties
    
    @IBOutlet weak var selectedStyleCollectionView: UICollectionView!
    @IBOutlet weak var largeCategorySegmentedControl: UISegmentedControl!
    @IBOutlet weak var smallCategoryCollectionView: UICollectionView!
    @IBOutlet weak var skipButton: UIButton!
    @IBOutlet weak var selectedStyleCollectionViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var skipBgView: UIView!
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        registerXib()
        initSkipButton()
        assignDelegate()
        assignDataSource()
        initializeSegmentedControl()
        initializeNavigationBar()
        initCollectionViews()
        
//        getStyle()
    }
    
    // MARK: - @IBAction Properties
    
    @IBAction func touchSelectButton(_ sender: Any) {        pushToMainViewController(isSkip: false)

    }
    
    @IBAction func changeSegmentedControl(_ sender: UISegmentedControl) {
        largeCategorySegmentedControl.changeUnderlinePosition()
    }
    
    @IBAction func touchSkipButton(_ sender: Any) {
        UserTaste.shared.scent.removeAll()
        pushToMainViewController(isSkip: true)
    }
    
    // MARK: - Functions
    
    // register function
    private func registerXib() {
        selectedStyleCollectionView.register(UINib(nibName: Const.Xib.Name.selectedFilterCollectionViewCell, bundle: nil), forCellWithReuseIdentifier: Const.Xib.Identifier.selectedFilterCollectionViewCell)
        smallCategoryCollectionView.register(UINib(nibName: Const.Xib.Name.roundedSquareCollectionViewCell, bundle: nil), forCellWithReuseIdentifier: Const.Xib.Identifier.roundedSquareCollectionViewCell)
        smallCategoryCollectionView.register(UINib(nibName: Const.Xib.Name.mediumCategoryCollectionViewCell, bundle: nil), forCellWithReuseIdentifier: Const.Xib.Identifier.mediumCategoryCollectionViewCell)
        smallCategoryCollectionView.register(UINib(nibName: Const.Xib.Name.labelCollectionViewCell, bundle: nil), forCellWithReuseIdentifier: Const.Xib.Identifier.labelCollectionViewCell)
        smallCategoryCollectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: UICollectionViewCell.identifier)
    }
    
    // assign functions
    private func assignDelegate() {
        selectedStyleCollectionView.delegate = self
        smallCategoryCollectionView.delegate = self
    }
    
    private func assignDataSource() {
        selectedStyleCollectionView.dataSource = self
        smallCategoryCollectionView.dataSource = self
    }
    
    // init functions
    private func initializeSegmentedControl() {
        largeCategorySegmentedControl.addUnderlineForSelectedSegment()
    }
    
    private func initializeNavigationBar() {
        self.navigationController?.initializeNavigationBarWithBackButton(navigationItem: self.navigationItem)
    }
    
    private func initSkipButton() {
        skipBgView.makeRounded(radius: self.skipBgView.frame.height / 2)
    }
    
    private func initCollectionViews() {
        
        // smallCategoryCollectionView
        self.smallCategoryCollectionView.allowsSelection = true
        self.smallCategoryCollectionView.allowsMultipleSelection = true
        
        // singleton 배열 값에 따른 selectedStyleCollectionView height
        if UserTaste.shared.style.count == 0 {
            selectedStyleCollectionViewHeightConstraint.constant = 0
        } else {
            selectedStyleCollectionViewHeightConstraint.constant = 50
        }
    }
    
    // 서버 통신 후 소분류 data 업데이트
//    private func updateData(data: AppConfig) {
//        styleList = data.styleList
//        smallCategoryCollectionView.reloadData()
//    }
    
    // transition function
    private func pushToMainViewController(isSkip: Bool) {
        let tabbarStoryboard = UIStoryboard(name: Const.Storyboard.Name.tabbar, bundle: nil)
        guard let tabbarViewController = tabbarStoryboard.instantiateViewController(withIdentifier: Const.ViewController.Identifier.tabbar) as? TabbarViewController else {
            return
        }
        
        if isScentSkipped == .skip {
            // scent 뷰 skip일 때
            if isSkip {
                // style 뷰 skip일 때
                tabbarViewController.isStyleScentSkipped = .skipSkip
            } else {
                // style 뷰 unskip일 때
                tabbarViewController.isStyleScentSkipped = .skipUnskip
            }
        } else {
            // scent 뷰 unskip일 때
            if isSkip {
                // style 뷰 skip일 때
                tabbarViewController.isStyleScentSkipped = .unskipSkip
            } else {
                // style 뷰 unskip일 때
                tabbarViewController.isStyleScentSkipped = .unskipUnskip
            }
        }
        
        tabbarViewController.modalPresentationStyle = .fullScreen
        tabbarViewController.modalTransitionStyle = .crossDissolve
        self.present(tabbarViewController, animated: true, completion: nil)
    }
}

// MARK: - UICollectionViewDataSource

extension StyleViewController: UICollectionViewDataSource {
    
    // section 개수
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        if collectionView == smallCategoryCollectionView {
            return 3
        }
        return 1
    }
    
    // cell 개수
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        if collectionView == selectedStyleCollectionView {
            return UserTaste.shared.style.count
        } else if collectionView == smallCategoryCollectionView {
            if section == 0 {
                return 1
            } else if section == 1 {
                return 1
            } else if section == 2 {
                return styleList.count
            }
        }
        return 0
    }
    
    // cell 지정
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        // selectedStyleCollectionView
        if collectionView == selectedStyleCollectionView {
            guard let cell = selectedStyleCollectionView.dequeueReusableCell(withReuseIdentifier: Const.Xib.Identifier.selectedFilterCollectionViewCell, for: indexPath) as? SelectedFilterCollectionViewCell else {
                return UICollectionViewCell()
            }
            
            cell.setCell(title: UserTaste.shared.style[indexPath.row])
            
            return cell
            
        // smallCategoryCollectionView
        } else if collectionView == smallCategoryCollectionView {
            
            // 첫째줄에 중분류 collection view 삽입
            if indexPath.section == 0 {
                
                // Create a new empty cell for reuse, this cell will only be used for the frist cell.
                let cell = smallCategoryCollectionView.dequeueReusableCell(withReuseIdentifier: UICollectionViewCell.identifier, for: IndexPath(row: 0, section: 0))
                
                cell.backgroundColor = UIColor.red
                
                // Programmically Create a Horizontal Collection View add to the Cell
                let mediumCategoryCollectionView: MediumCategoryCollectionView = {
                    
                    let data = ["Ale", "Lager", "dd", "sda", "s", "s", "ss", "s2"]
                    
                    // Only Flow Layout has scroll direction
                    let layout = UICollectionViewFlowLayout()
                    layout.scrollDirection = .horizontal
                    // Init with Data.
                    let mediumCategoryCollectionView = MediumCategoryCollectionView(frame: cell.bounds, collectionViewLayout: layout, data: data)
                    return mediumCategoryCollectionView
                }()
                // Adjust cell's frame and add it as a subview.
                cell.addSubview(mediumCategoryCollectionView)
                return cell
            } else if indexPath.section == 1 {
                
                guard let cell = smallCategoryCollectionView.dequeueReusableCell(withReuseIdentifier: Const.Xib.Identifier.labelCollectionViewCell, for: indexPath) as? LabelCollectionViewCell else {
                    return UICollectionViewCell()
                }
                
                return cell
                
            } else if indexPath.section == 2 {
                
                guard let cell = smallCategoryCollectionView.dequeueReusableCell(withReuseIdentifier: Const.Xib.Identifier.roundedSquareCollectionViewCell, for: indexPath) as? RoundedSquareCollectionViewCell else {
                    return UICollectionViewCell()
                }
                
                cell.setCell(title: styleList[0][indexPath.row])
                
                // 이전에 이미 선택된 cell selected 처리
                for style in UserTaste.shared.style {
                    if styleList[0][indexPath.row] == style {
                        cell.isSelected = true
                        cell.selectCell()
                        smallCategoryCollectionView.selectItem(at: indexPath, animated: true, scrollPosition: .init())
                    }
                }
                
                return cell
            }
            
            return UICollectionViewCell()
        } else {
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        guard let selectedCell = smallCategoryCollectionView.cellForItem(at: indexPath) as? RoundedSquareCollectionViewCell else { return }
        
        if selectedStyleCollectionViewHeightConstraint.constant == 0 {
            selectedStyleCollectionViewHeightConstraint.constant = 50
        }
        
        if UserTaste.shared.style.count < 5 {
            selectedCell.selectCell()
            UserTaste.shared.style.append(selectedCell.getTitle())
            selectedStyleCollectionView.reloadData()
        } else {
            // TODO: - 5개이상 선택안된다는 팝업 띄우기
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        
        guard let selectedCell = smallCategoryCollectionView.cellForItem(at: indexPath) as? RoundedSquareCollectionViewCell else { return }
        
        selectedCell.deselectCell()
        
        if UserTaste.shared.style.contains(selectedCell.getTitle()) {
            let indexInSharedStyle = UserTaste.shared.style.firstIndex(of: selectedCell.getTitle())
            UserTaste.shared.style.remove(at: indexInSharedStyle!)
            selectedStyleCollectionView.reloadData()
        }
        
        // cell 갯수가 0일 때 collection view height 줄이기
        if UserTaste.shared.style.count == 0 {
            selectedStyleCollectionViewHeightConstraint.constant = 0
        }
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension StyleViewController: UICollectionViewDelegateFlowLayout {
    
    // section 별 inset 지정
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        if collectionView == selectedStyleCollectionView {
            return UIEdgeInsets(top: 0, left: 18, bottom: 0, right: 0)
        } else if collectionView == smallCategoryCollectionView {
            if section == 0 {
                return UIEdgeInsets(top: 30, left: 0, bottom: 30, right: 0)
            }
            return UIEdgeInsets(top: 0, left: 18, bottom: 30, right: 18)
        } else {
            return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        }
    }
    
    // cell 사이 간격
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        if collectionView == selectedStyleCollectionView {
            return 8
        } else if collectionView == smallCategoryCollectionView {
            return 9
        } else {
            return 0
        }
    }
    
    // cell 크기
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if collectionView == selectedStyleCollectionView {
            let titles = UserTaste.shared.style
            
            let size = self.estimatedSize(text: titles[indexPath.row])
            return size
        } else if collectionView == smallCategoryCollectionView {
            
            // 첫째줄 중분류 collectionview
            if indexPath.section == 0 {
                return CGSize(width: screenWidth, height: 150)
            } else if indexPath.section == 1 {
                return CGSize(width: screenWidth - 36, height: 40)
            }
            
            let cellWidth = (self.screenWidth - 27 - 36) / 3
            
            return CGSize(width: cellWidth, height: 48)
        } else {
            return CGSize(width: 5, height: 5)
        }
    }
    
    func estimatedSize(text: String) -> CGSize {
        let itemSize = text.size(withAttributes: [
            NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 10)
        ])
        
        return CGSize(width: itemSize.width + 44, height: 30)
    }
}

// MARK: - API

//extension StyleViewController {
//
//    func getStyle() {
//        AppConfigAPI.shared.getAppConfig { (response) in
//
//            switch response {
//            case .success(let appConfig):
//                if let data = appConfig as? AppConfig {
//                    self.updateData(data: data)
//                }
//
//            case .requestErr(let message):
//                print(message)
//            case .pathErr:
//                print("pathErr in StyleViewController getStyle")
//            case .networkFail:
//                print("networkFail in StyleViewController getStyle")
//            case .serverErr:
//                print("serverErr in StyleViewController getStyle")
//            }
//        }
//    }
//}
