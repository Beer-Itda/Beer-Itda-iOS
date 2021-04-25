//
//  MainTableViewCell.swift
//  Beer-Itda
//
//  Created by 초이 on 2021/04/24.
//

import UIKit

class MainTableViewCell: UITableViewCell {
    
    // MARK: - @IBOutlet Properties
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var mainCollectionView: UICollectionView!
    
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
    
    @IBAction func touchMoreButton(_ sender: Any) {
        
        print("more button touched")
    }
    
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
    
    func setCell(title: String) {
        titleLabel.text = title
    }
}

// MARK: - UICollectionViewDataSource

extension MainTableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        // TODO: - 개수 물어봐야 함
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Const.Xib.Identifier.mainCollectionViewCell, for: indexPath) as? MainCollectionViewCell {
            // cell.setCell(news: news[indexPath.item])
            return cell
        }
        return UICollectionViewCell()
    }
    
}

// MARK: - UICollectionViewDelegateFlowLayout

extension MainTableViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            return CGSize(width: 120, height: 209)
        }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 18, bottom: 0, right: 18)
    }
}
