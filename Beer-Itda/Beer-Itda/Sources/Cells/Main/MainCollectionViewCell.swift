//
//  MainCollectionViewCell.swift
//  Beer-Itda
//
//  Created by 초이 on 2021/04/24.
//

import UIKit

class MainCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Properties
    
    // MARK: - @IBOutlet Properties
    
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var beerImageView: UIImageView!
    @IBOutlet weak var korNameLabel: UILabel!
    @IBOutlet weak var engNameLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        initBgView()
    }
    
    // MARK: - Functions
    
    private func initBgView() {
        bgView.makeRounded(radius: 26)
    }
    
    func setCell(beer: Beer) {
        // image - scroll시 glitch를 막기 위해 global queue에서 실행
        DispatchQueue.global(qos: .background).async {

            let url = URL(string: beer.thumbnailImage)
            // TODO: - url 없을시 에러 처리
            let data = try? Data(contentsOf: url!)
            DispatchQueue.main.async {
                self.beerImageView.image = UIImage(data: data!)
            }
        }
        
        
        korNameLabel.text = beer.name
        engNameLabel.text = beer.name // TODO: - 영문이름 api 나오면 바꿔줘야 함
        ratingLabel.text = String(beer.rateAvg)
        
        // TODO: - 좋아요 반영 (beer.favoriteFlag)
    }
    
    // MARK: - @IBAction Properties
    
    @IBAction func touchLikeButton(_ sender: Any) {
        // TODO: - 로직 수정해야됨 셀 queue에 넣을 때 이상해짐
        likeButton.isSelected = !isSelected
        if likeButton.isSelected {
            likeButton.setImage(UIImage(named: "btnLike"), for: .selected)
        } else {
            likeButton.setImage(UIImage(named: "btnUnlike"), for: .normal)
        }
    }
    
}
