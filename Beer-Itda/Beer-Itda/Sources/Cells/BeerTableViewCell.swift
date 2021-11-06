//
//  BeerTableViewCell.swift
//  Beer-Itda
//
//  Created by 초이 on 2021/04/27.
//

import UIKit

class BeerTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    
    // MARK: - @IBOutlet Properties
    
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var beerImageView: UIImageView!
    @IBOutlet weak var styleLabel: UILabel!
    @IBOutlet weak var korNameLabel: UILabel!
    @IBOutlet weak var engNameLabel: UILabel!
    @IBOutlet weak var abvLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    
    // MARK: - View Life Cycle

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
//        DispatchQueue.global(qos: .background).async {
//
//            let url = URL(string: beer.thumbnailImage)
//            // TODO: - url 없을시 에러 처리
//            let data = try? Data(contentsOf: url!)
//            DispatchQueue.main.async {
//                self.beerImageView.image = UIImage(data: data!)
//            }
//        }
        
        // 그 외 label들
        styleLabel.text = beer.beerStyle
        korNameLabel.text = beer.name
        engNameLabel.text = beer.name // TODO: - engName으로 변경해야 함
        abvLabel.text = "\(String(format: "%.1f", beer.abv))%"
        ratingLabel.text = String(format: "%.1f", beer.rateAvg)
        
        // TODO: - 향 3개인지 4개인지 데이터에서 보고.. 스택뷰 변경, 데이터 넣기
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
