//
//  mediumCategoryCollectionView.swift
//  Beer-Itda
//
//  Created by 초이 on 2021/04/02.
//

import UIKit
import Lottie

class MediumCategoryCollectionView: UICollectionView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    // Your Data Model Objects
    var data:[Any]?
    
    // 중분류 Collection View 변수
    let cellSize = CGSize(width: 150, height: 150)
    var minItemSpacing: CGFloat = 12
    let cellCount = 8
    var previousIndex = 0
    
    var tagNum = 0
    
    // Required
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
    }
    
    convenience init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout, data:[Any]) {
        self.init(frame: frame, collectionViewLayout: layout)
        
        // Set These
        self.delegate = self
        self.dataSource = self
        self.data = data
        // Setup Subviews.
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // return zero if we have no data to show.
        guard let count = self.data?.count else {
            print("zero")
            return 0
        }
        print(count)
        return count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = self.dequeueReusableCell(withReuseIdentifier: Const.Xib.Identifier.mediumCategoryCollectionViewCell, for: indexPath)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return cellSize
    }
    
    func setup(){
        self.backgroundColor = UIColor.white
        self.contentInsetAdjustmentBehavior = .never
        self.decelerationRate = .fast
        self.register(UINib(nibName: Const.Xib.Name.mediumCategoryCollectionViewCell, bundle: nil), forCellWithReuseIdentifier: Const.Xib.Identifier.mediumCategoryCollectionViewCell)
        // Must call reload, Data is not loaded unless explicitly told to.
        // Must run on Main thread this class is still initalizing.
        DispatchQueue.main.async {
            self.reloadData()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let cellWidth: CGFloat = floor(cellSize.width)
        let insetX = (UIScreen.main.bounds.width - cellWidth) / 2.0
        
        return UIEdgeInsets(top: 0, left: insetX, bottom: 0, right: insetX)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return minItemSpacing
    }
    
    // MARK: Paging Effect
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {

        let cellWidthIncludeSpacing = cellSize.width + minItemSpacing
        var offset = targetContentOffset.pointee
        let index = (offset.x + scrollView.contentInset.left) / cellWidthIncludeSpacing
        let roundedIndex: CGFloat = round(index)
        offset = CGPoint(x: roundedIndex * cellWidthIncludeSpacing - scrollView.contentInset.left, y: scrollView.contentInset.top)
        targetContentOffset.pointee = offset
    }
    
    // MARK: Carousel Effect
    func scrollViewDidScroll(_ scrollView: UIScrollView) {

        let cellWidthIncludeSpacing = cellSize.width + minItemSpacing
        let offsetX = self.contentOffset.x
        let index = (offsetX + self.contentInset.left) / cellWidthIncludeSpacing

        let roundedIndex = round(index)

        let indexPath = IndexPath(item: Int(roundedIndex), section: 0)

        if let cell = self.cellForItem(at: indexPath) { animateZoomforCell(zoomCell: cell)
            unhideLottieforCell(zoomCell: cell)
        }

        if Int(roundedIndex) != previousIndex {
            let preIndexPath = IndexPath(item: previousIndex, section: 0)
            if let preCell = self.cellForItem(at: preIndexPath) {
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
