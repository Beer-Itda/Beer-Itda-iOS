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
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        assignDelegate()
        assignDataSource()
        registerXib()
        initializeNavigationBar()
        initSkipButton()
        
        getScent()
    }
    
    // MARK: - @IBAction Properties
    
    @IBAction func touchSelectButton(_ sender: Any) {
        pushToMainViewController(isSkip: false)
    }
    
    @IBAction func touchSkipButton(_ sender: Any) {
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
        skipButton.contentEdgeInsets = UIEdgeInsets(top: 8, left: 12, bottom: 8, right: 12)
        
        skipButton.layer.masksToBounds = true
        skipButton.layer.borderWidth = 1
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
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == selectedScentCollectionView {
            return 3
        }
        return scentList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == selectedScentCollectionView {
            guard let cell = selectedScentCollectionView.dequeueReusableCell(withReuseIdentifier: Const.Xib.Identifier.selectedFilterCollectionViewCell, for: indexPath) as? SelectedFilterCollectionViewCell else {
                return UICollectionViewCell()
            }
            
            let titles = ["과일 향", "고소한 향", "시트러스 향"]
            
            cell.setCell(title: titles[indexPath.row])
            
            return cell
        } else {
            guard let cell = scentCollectionView.dequeueReusableCell(withReuseIdentifier: Const.Xib.Identifier.roundedSquareCollectionViewCell, for: indexPath) as? RoundedSquareCollectionViewCell else {
                return UICollectionViewCell()
            }
            
            cell.setCell(title: scentList[indexPath.row])
            
            return cell
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
            let titles = ["전체보기", "Bourbon County Stout", "Bourbon County Stout"]
            
            let width = self.estimatedFrame(text: titles[indexPath.row], font: UIFont.systemFont(ofSize: 10)).width
            return CGSize(width: width, height: 50.0)
        } else {
            let width = (self.screenWidth - 46) / 2
            
            return CGSize(width: width, height: 48)
        }
    }
    
    func estimatedFrame(text: String, font: UIFont) -> CGRect {
        let size = CGSize(width: 200, height: 1000) // temporary size
        let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
        return NSString(string: text).boundingRect(with: size,
                                                   options: options,
                                                   attributes: [NSAttributedString.Key.font: font],
                                                   context: nil)
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
                print("pathErr in StyleViewController getStyle")
            case .networkFail:
                print("networkFail in StyleViewController getStyle")
            case .serverErr:
                print("serverErr in StyleViewController getStyle")
            }
        }
    }
}
