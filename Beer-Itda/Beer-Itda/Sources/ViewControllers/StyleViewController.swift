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
    enum StyleViewUsage: Int {
        case onboarding = 0, main
    }
    
    // variables
    var styleViewUsage: StyleViewUsage?
    var tagNum = 0
    
    // 중분류 Collection View 변수
    let cellSize = CGSize(width: 150, height: 150)
    var minItemSpacing: CGFloat = 12
    let cellCount = 8
    var previousIndex = 0
    
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
        initializeMediumCategoryCollectionView()
        initializeSegmentedControl()
        initializeNavigationBar()
    }
    
    // MARK: - @IBAction Properties
    
    @IBAction func touchSelectButton(_ sender: Any) {
        pushToScentViewController()
    }
    
    @IBAction func changeSegmentedControl(_ sender: UISegmentedControl) {
        largeCategorySegmentedControl.changeUnderlinePosition()
    }
    
    // MARK: - Functions
    
    private func registerXib() {
        selectedStyleCollectionView.register(UINib(nibName: Const.Xib.Name.selectedFilterCollectionViewCell, bundle: nil), forCellWithReuseIdentifier: Const.Xib.Identifier.selectedFilterCollectionViewCell)
        mediumCategoryCollectionView.register(UINib(nibName: Const.Xib.Name.mediumCategoryCollectionViewCell, bundle: nil), forCellWithReuseIdentifier: Const.Xib.Identifier.mediumCategoryCollectionViewCell)
    }
    
    private func assignDelegate() {
        selectedStyleCollectionView.delegate = self
        mediumCategoryCollectionView.delegate = self
    }
    
    private func assignDataSource() {
        selectedStyleCollectionView.dataSource = self
        mediumCategoryCollectionView.dataSource = self
    }
    
    private func initializeMediumCategoryCollectionView() {
        mediumCategoryCollectionView.contentInsetAdjustmentBehavior = .never
        mediumCategoryCollectionView.decelerationRate = .fast
    }
    
    private func initializeSegmentedControl() {
        largeCategorySegmentedControl.addUnderlineForSelectedSegment()
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
    
    func attachLottieView(zoomCell: UICollectionViewCell) {
        var animationView: AnimationView?
        animationView = .init(name: "circle-wave")
        animationView!.frame = zoomCell.bounds
        animationView!.contentMode = .scaleAspectFit
        animationView!.loopMode = .loop
        animationView!.animationSpeed = 1
        
        self.tagNum += 1
        animationView?.tag = self.tagNum
        print(self.tagNum)
        
        zoomCell.addSubview(animationView!)
        animationView!.play()
        
        print("attached")
    }
    
    func detachLottieView(zoomCell: UICollectionViewCell) {
        
        for view in zoomCell.subviews {
            if view.tag >= 1 {
                view.removeFromSuperview()
            }
        }
        
        print("detached")
        self.tagNum = 0
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
    
    // cell 개수
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        if collectionView == selectedStyleCollectionView {
            return 3
        } else if collectionView == mediumCategoryCollectionView {
            return 5
        } else {
            return 0
        }
    }
    
    // cell 지정
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == selectedStyleCollectionView {
            guard let cell = selectedStyleCollectionView.dequeueReusableCell(withReuseIdentifier: Const.Xib.Identifier.selectedFilterCollectionViewCell, for: indexPath) as? SelectedFilterCollectionViewCell else {
                return UICollectionViewCell()
            }
            
            let titles = ["전체보기", "Bourbon County Stout", "Bourbon County Stout"]
            
            cell.setCell(title: titles[indexPath.row])
            
            return cell
        } else if collectionView == mediumCategoryCollectionView {
            guard let cell = mediumCategoryCollectionView.dequeueReusableCell(withReuseIdentifier: Const.Xib.Identifier.mediumCategoryCollectionViewCell, for: indexPath) as? MediumCategoryCollectionViewCell else {
                return UICollectionViewCell()
            }
            
            return cell
            
        } else {
            return UICollectionViewCell()
        }
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension StyleViewController: UICollectionViewDelegateFlowLayout {
    
    // section 별 inset 지정
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        if collectionView == selectedStyleCollectionView {
            return UIEdgeInsets(top: 0, left: 18, bottom: 0, right: 0)
        } else if collectionView == mediumCategoryCollectionView {
            let cellWidth: CGFloat = floor(cellSize.width)
            let insetX = (view.bounds.width - cellWidth) / 2.0
            
            return UIEdgeInsets(top: 0, left: insetX, bottom: 0, right: insetX)
        } else {
            return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        }
    }
    
    // cell 사이 간격
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        if collectionView == selectedStyleCollectionView {
            return 8
        } else if collectionView == mediumCategoryCollectionView {
            return minItemSpacing
        } else {
            return 0
        }
    }
    
    // cell 크기
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if collectionView == selectedStyleCollectionView {
            let titles = ["전체보기", "Bourbon County Stout", "Bourbon County Stout"]
            
            let width = self.estimatedFrame(text: titles[indexPath.row], font: UIFont.systemFont(ofSize: 10)).width
            return CGSize(width: width, height: 50.0)
        } else if collectionView == mediumCategoryCollectionView {
            return cellSize
        } else {
            return CGSize(width: 5, height: 5)
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
    
    // MARK: Paging Effect
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
        if scrollView == mediumCategoryCollectionView {
            let cellWidthIncludeSpacing = cellSize.width + minItemSpacing
            var offset = targetContentOffset.pointee
            let index = (offset.x + scrollView.contentInset.left) / cellWidthIncludeSpacing
            let roundedIndex: CGFloat = round(index)
            offset = CGPoint(x: roundedIndex * cellWidthIncludeSpacing - scrollView.contentInset.left, y: scrollView.contentInset.top)
            targetContentOffset.pointee = offset
        }
    }
    
    // MARK: Carousel Effect
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let cellWidthIncludeSpacing = cellSize.width + minItemSpacing
        let offsetX = mediumCategoryCollectionView.contentOffset.x
        let index = (offsetX + mediumCategoryCollectionView.contentInset.left) / cellWidthIncludeSpacing
        
        let roundedIndex = round(index)
        
        let indexPath = IndexPath(item: Int(roundedIndex), section: 0)
        
        if let cell = mediumCategoryCollectionView.cellForItem(at: indexPath) { animateZoomforCell(zoomCell: cell)
            unhideLottieforCell(zoomCell: cell)
        }
        
        if Int(roundedIndex) != previousIndex {
            let preIndexPath = IndexPath(item: previousIndex, section: 0)
            if let preCell = mediumCategoryCollectionView.cellForItem(at: preIndexPath) {
                animateZoomforCellremove(zoomCell: preCell)
                hideLottieforCell(zoomCell: preCell)
            }
            previousIndex = indexPath.item
        }
    }
    
    func animateZoomforCell(zoomCell: UICollectionViewCell) {
        UIView.animate( withDuration: 0.2, delay: 0, options: .curveEaseOut, animations: {
            zoomCell.transform = .identity
        }, completion: nil)
        
    }
    
    func animateZoomforCellremove(zoomCell: UICollectionViewCell) {
        UIView.animate( withDuration: 0.2, delay: 0, options: .curveEaseOut, animations: { zoomCell.transform = CGAffineTransform(scaleX: 0.73, y: 0.73)
        }, completion: nil)
    }
    
    func hideLottieforCell(zoomCell: UICollectionViewCell) {
        detachLottieView(zoomCell: zoomCell)
    }
    
    func unhideLottieforCell(zoomCell: UICollectionViewCell) {
        detachLottieView(zoomCell: zoomCell)
        attachLottieView(zoomCell: zoomCell)
    }
}
