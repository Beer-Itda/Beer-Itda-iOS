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
    var curLargeId = 0
    var curMidId = 0
    var isScentSkipped: IsScentSkipped?
    
    // 기기 width
    var screenWidth = UIScreen.main.bounds.width
    
    // TODO: - Style 카테고리화되면 변경해야 함
    var styleList: [Style] = [Style(id: 0, bigName: "", styleMids: [StyleMid(id: 0, midName: "", midDescription: "", midImage: "", bigStyleID: 0, styleSmalls: [StyleSmall(id: 0, smallName: "", midStyleID: 0, isSelected: false)])])]
    
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
        
        getStyle()
    }
    
    // MARK: - @IBAction Properties
    
    @IBAction func touchSelectButton(_ sender: Any) {
        pushToMainViewController(isSkip: false)
    }
    
    @IBAction func changeSegmentedControl(_ sender: UISegmentedControl) {
        largeCategorySegmentedControl.changeUnderlinePosition()
        self.curLargeId = sender.selectedSegmentIndex
        
        // update collection view
        smallCategoryCollectionView.reloadSections(IndexSet(integer: 2))
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
        self.navigationController?.initWithBackButton()
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
    
    // MARK: 서버 통신 후 data 업데이트
    private func updateData(data: StyleList) {
        styleList = data.styleList
        
        // large - seg
        for style in data.styleList {
            largeCategorySegmentedControl.setTitle(style.bigName, forSegmentAt: style.id-1)
        }
        // mid - lottie
        // small - collectionview
        smallCategoryCollectionView.reloadData()
    }
    
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
                return styleList[curLargeId].styleMids[curMidId].styleSmalls.count
            }
        }
        return 0
    }
    
    // MARK: cellForItemAt
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        // selectedStyleCollectionView
        if collectionView == selectedStyleCollectionView {
            guard let cell = selectedStyleCollectionView.dequeueReusableCell(withReuseIdentifier: Const.Xib.Identifier.selectedFilterCollectionViewCell, for: indexPath) as? SelectedFilterCollectionViewCell else {
                return UICollectionViewCell()
            }
            
            cell.setCell(title: UserTaste.shared.style[indexPath.row].style.smallName)
            
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
                
                cell.setStyleCell(style: styleList[curLargeId].styleMids[curMidId].styleSmalls[indexPath.row])
                
                // 이전에 이미 선택된 cell selected 처리
                let curSelectedStyles = UserTaste.shared.style.filter {
                    $0.bigId == curLargeId && $0.midId == curMidId
                }
                if curSelectedStyles.count > 0 {
                    
                    for style in curSelectedStyles {
                        if style.style.id == styleList[curLargeId].styleMids[curMidId].styleSmalls[indexPath.row].id {
                            cell.isSelected = true
                            cell.selectCell()
                            smallCategoryCollectionView.selectItem(at: indexPath, animated: true, scrollPosition: .init())
                        }
                    }
                }
                return cell
            }
            
            return UICollectionViewCell()
        } else {
            return UICollectionViewCell()
        }
    }
    
    // MARK: didSelectItemAt
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        guard let selectedCell = smallCategoryCollectionView.cellForItem(at: indexPath) as? RoundedSquareCollectionViewCell else { return }
        
        if selectedStyleCollectionViewHeightConstraint.constant == 0 {
            selectedStyleCollectionViewHeightConstraint.constant = 50
        }
        
        if UserTaste.shared.style.count < 5 {
            selectedCell.selectCell()
            UserTaste.shared.style.append(SelectedStyleSmall(bigId: curLargeId,
                                                             midId: curMidId,
                                                             style: selectedCell.style))
            selectedStyleCollectionView.reloadData()
        } else {
            // TODO: - 5개이상 선택안된다는 팝업 띄우기
        }
    }
    
    // MARK: didDeselectItemAt
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        
        guard let selectedCell = smallCategoryCollectionView.cellForItem(at: indexPath) as? RoundedSquareCollectionViewCell else { return }
        
        selectedCell.deselectCell()
        
        if let indexInSharedStyle = UserTaste.shared.style.firstIndex(where: {
            $0.style.id == selectedCell.style.id
        }) {
            UserTaste.shared.style.remove(at: indexInSharedStyle)
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
            let styles = UserTaste.shared.style
            
            let size = self.estimatedSize(text: styles[indexPath.row].style.smallName)
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

extension StyleViewController {

    func getStyle() {
        APIManager.shared.call(type: EndpointItem.styleInfo) { (res: Swift.Result<GenericResponse<StyleList>, AlertMessage>) in
            switch res {
            case .success(let genericRes):
                if let data = genericRes.data {
                    self.updateData(data: data)
                }
            case .failure(let message):
                print(message)
            }
        }
    }
}
