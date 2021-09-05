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
    
    enum IsStyleSkipped: Int {
        case unskip = 0, skip
    }
    var isStyleSkipped: IsStyleSkipped?
    
    // TODO: - Scent 카테고리화되면 변경해야 함
    var scentList: [String] = []
    
    // MARK: - @IBOutlet Properties

    @IBOutlet weak var selectedScentCollectionView: UICollectionView!
    @IBOutlet weak var scentCollectionView: UICollectionView!
    @IBOutlet weak var skipButton: UIButton!
    @IBOutlet weak var skipBgView: UIView!
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        assignDelegate()
        assignDataSource()
        registerXib()
        initializeNavigationBar()
        initSkipButton()
        initCollectionViews()
        
        getScent()
    }
    
    // MARK: - @IBAction Properties
    
    @IBAction func touchSelectButton(_ sender: Any) {
        pushToMainViewController(isSkip: false)
    }
    
    @IBAction func touchSkipButton(_ sender: Any) {
        UserTaste.shared.scent.removeAll()
        pushToMainViewController(isSkip: true)
    }
    
    // MARK: - Functions
    
    // assign functions
    private func assignDelegate() {
        selectedScentCollectionView.delegate = self
        scentCollectionView.delegate = self
    }
    
    private func assignDataSource() {
        selectedScentCollectionView.dataSource = self
        scentCollectionView.dataSource = self
    }
    
    // register function
    private func registerXib() {
        selectedScentCollectionView.register(UINib(nibName: Const.Xib.Name.selectedFilterCollectionViewCell, bundle: nil), forCellWithReuseIdentifier: Const.Xib.Identifier.selectedFilterCollectionViewCell)
        scentCollectionView.register(UINib(nibName: Const.Xib.Name.roundedSquareCollectionViewCell, bundle: nil), forCellWithReuseIdentifier: Const.Xib.Identifier.roundedSquareCollectionViewCell)
    }
    
    // init functions
    private func initializeNavigationBar() {
        self.navigationController?.initializeNavigationBarWithBackButton(navigationItem: self.navigationItem)
    }
    
    private func initSkipButton() {
        skipBgView.makeRounded(radius: self.skipBgView.frame.height / 2)
    }
    
    private func initCollectionViews() {
        
        // scentCollectionView
        self.scentCollectionView.allowsSelection = true
        self.scentCollectionView.allowsMultipleSelection = true
    }
    
    // 서버 통신 후 소분류 data 업데이트
    private func updateData(data: AppConfig) {
        scentList = data.aromaList
        scentCollectionView.reloadData()
    }
    
    private func pushToMainViewController(isSkip: Bool) {
        let tabbarStoryboard = UIStoryboard(name: Const.Storyboard.Name.tabbar, bundle: nil)
        guard let tabbarViewController = tabbarStoryboard.instantiateViewController(withIdentifier: Const.ViewController.Identifier.tabbar) as? TabbarViewController else {
            return
        }
        
        if isStyleSkipped == .skip {
            // style 뷰 skip일 때
            if isSkip {
                // scent 뷰 skip일 때
                tabbarViewController.isStyleScentSkipped = .skipSkip
            } else {
                // scent 뷰 unskip일 때
                tabbarViewController.isStyleScentSkipped = .skipUnskip
            }
        } else {
            // style 뷰 unskip일 때
            if isSkip {
                // scent 뷰 skip일 때
                tabbarViewController.isStyleScentSkipped = .unskipSkip
            } else {
                // scent 뷰 unskip일 때
                tabbarViewController.isStyleScentSkipped = .unskipUnskip
            }
        }
        
        tabbarViewController.modalPresentationStyle = .fullScreen
        tabbarViewController.modalTransitionStyle = .crossDissolve
        self.present(tabbarViewController, animated: true, completion: nil)
    }
    
}

// MARK: - UICollectionViewDataSource

extension ScentViewController: UICollectionViewDataSource {
    
    // cell 개수
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == selectedScentCollectionView {
            return UserTaste.shared.scent.count
        }
        return scentList.count
    }
    
    // cell 지정
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        // selectedScentCollectionView
        if collectionView == selectedScentCollectionView {
            guard let cell = selectedScentCollectionView.dequeueReusableCell(withReuseIdentifier: Const.Xib.Identifier.selectedFilterCollectionViewCell, for: indexPath) as? SelectedFilterCollectionViewCell else {
                return UICollectionViewCell()
            }
            
            cell.setCell(title: UserTaste.shared.scent[indexPath.row])
            
            return cell
            
        // scentCollectionView
        } else {
            guard let cell = scentCollectionView.dequeueReusableCell(withReuseIdentifier: Const.Xib.Identifier.roundedSquareCollectionViewCell, for: indexPath) as? RoundedSquareCollectionViewCell else {
                return UICollectionViewCell()
            }
            
            cell.setCell(title: scentList[indexPath.row])
            
            // 이전에 이미 선택된 cell selected 처리
            for scent in UserTaste.shared.scent {
                if scentList[indexPath.row] == scent {
                    cell.isSelected = true
                    cell.selectCell()
                    scentCollectionView.selectItem(at: indexPath, animated: true, scrollPosition: .init())
                }
            }
            
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let selectedCell = scentCollectionView.cellForItem(at: indexPath) as? RoundedSquareCollectionViewCell else { return }
        
        if UserTaste.shared.scent.count < 5 {
            selectedCell.selectCell()
            UserTaste.shared.scent.append(selectedCell.getTitle())
            selectedScentCollectionView.reloadData()
        } else {
            // TODO: - 5개이상 선택안된다는 팝업 띄우기
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        guard let selectedCell = scentCollectionView.cellForItem(at: indexPath) as? RoundedSquareCollectionViewCell else { return }
        
        selectedCell.deselectCell()
        
        if UserTaste.shared.scent.contains(selectedCell.getTitle()) {
            let indexInSharedScent = UserTaste.shared.scent.firstIndex(of: selectedCell.getTitle())
            UserTaste.shared.scent.remove(at: indexInSharedScent!)
            selectedScentCollectionView.reloadData()
        }
    }
    
}

// MARK: - UICollectionViewDelegateFlowLayout

extension ScentViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        if collectionView == selectedScentCollectionView {
            return UIEdgeInsets(top: 0, left: 18, bottom: 0, right: 0)
        }
        
        return UIEdgeInsets(top: 32, left: 18, bottom: 0, right: 18)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        return 8
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout
                            collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt
                            indexPath: IndexPath) -> CGSize {
        
        if collectionView == selectedScentCollectionView {
            let titles = UserTaste.shared.scent
            
            let size = self.estimatedSize(text: titles[indexPath.row])
            return size
        } else {
            let width = (self.screenWidth - 46) / 2
            
            return CGSize(width: width, height: 48)
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

extension ScentViewController {
    
    func getScent() {
        AppConfigAPI.shared.getAppConfig { (response) in
            
            switch response {
            case .success(let appConfig):
                if let data = appConfig as? AppConfig {
                    self.updateData(data: data)
                }
                
            case .requestErr(let message):
                print(message)
            case .pathErr:
                print("pathErr in ScentViewController getScent")
            case .networkFail:
                print("networkFail in ScentViewController getScent")
            case .serverErr:
                print("serverErr in ScentViewController getScent")
            }
        }
    }
}
