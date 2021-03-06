//
//  MainTableViewCell.swift
//  Beer-Itda
//
//  Created by 초이 on 2021/04/24.
//

import UIKit

// MARK: - Protocol - CollectionViewCellDelegate

protocol CollectionViewCellDelegate: AnyObject {
    func collectionView(collectionviewcell: MainCollectionViewCell?, index: Int, didTappedInTableViewCell: MainTableViewCell)
}

// MARK: - MainTableViewCell

class MainTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    
    weak var cellDelegate: CollectionViewCellDelegate?
    var beers: [Beer] = []
    
    // MARK: - @IBOutlet Properties
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var mainCollectionView: UICollectionView!
    @IBOutlet weak var moreButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        assignDelegate()
        assignDataSource()
        registerXib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    // MARK: - @IBAction Functions
    
    // MARK: - Functions
    
    private func assignDelegate() {
        mainCollectionView.delegate = self
    }
    
    private func assignDataSource() {
        mainCollectionView.dataSource = self
    }
    
    private func registerXib() {
        let cellNib = UINib(nibName: Const.Xib.Name.mainCollectionViewCell, bundle: nil)
        self.mainCollectionView.register(cellNib, forCellWithReuseIdentifier: Const.Xib.Identifier.mainCollectionViewCell)
    }
    
    func setCell(title: String, beers: [Beer]) {
        titleLabel.text = title
        self.beers = beers
    }
}

// MARK: - UICollectionViewDataSource

extension MainTableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
                
        if beers.count >= 10 {
            return 10
        } else {
            return beers.count
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Const.Xib.Identifier.mainCollectionViewCell, for: indexPath) as? MainCollectionViewCell {
            
            cell.setCell(beer: beers[indexPath.row])
            cell.addShadow()
            
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as? MainCollectionViewCell
        self.cellDelegate?.collectionView(collectionviewcell: cell, index: indexPath.item, didTappedInTableViewCell: self)
    }
    
}

// MARK: - UICollectionViewDelegateFlowLayout

extension MainTableViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            return CGSize(width: 120, height: 209)
        }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 82, left: 18, bottom: 25, right: 18)
    }
}
