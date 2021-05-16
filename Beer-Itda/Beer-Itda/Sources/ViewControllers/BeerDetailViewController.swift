//
//  BeerDetailViewController.swift
//  Beer-Itda
//
//  Created by 초이 on 2021/03/20.
//

import UIKit

class BeerDetailViewController: UIViewController {
    
    // MARK: - Properties
    
    let scentView4Height: CGFloat = 32
    
    var scents = ["시트러스 향", "시트러스 향", "시트러스 향", "시트러스 향"]
    
    // MARK: - @IBOutlet Properties
    
    @IBOutlet weak var beerImageView: UIImageView!
    @IBOutlet weak var companyLabel: UILabel!
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var beerNameLabel: UILabel!
    @IBOutlet weak var beerEngNameLabel: UILabel!
    @IBOutlet weak var abvLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    
    @IBOutlet weak var scentStackView: UIStackView!
    @IBOutlet weak var scentView1: UIView!
    @IBOutlet weak var scentLabel1: UILabel!
    @IBOutlet weak var scentView2: UIView!
    @IBOutlet weak var scentLabel2: UILabel!
    @IBOutlet weak var scentView3: UIView!
    @IBOutlet weak var scentLabel3: UILabel!
    @IBOutlet weak var scentView4: UIView!
    @IBOutlet weak var scentLabel4: UILabel!
    @IBOutlet weak var scentView4HeightConstraint: NSLayoutConstraint!
    
    var scentViews = [UIView]()
    var scentLabels = [UILabel]()
    
    // MARK: - View Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        initScentViews()
    }
    
    // MARK: - Functions
    
    // 향 뷰 초기화
    private func initScentViews() {
        
        scentViews.append(scentView1)
        scentViews.append(scentView2)
        scentViews.append(scentView3)
        scentViews.append(scentView4)
        
        scentLabels.append(scentLabel1)
        scentLabels.append(scentLabel2)
        scentLabels.append(scentLabel3)
        scentLabels.append(scentLabel4)
        
        for idx in 0..<scents.count {
            scentViews[idx].isHidden = false
            scentLabels[idx].text = scents[idx]
            
            if idx == 4 {
                scentView4HeightConstraint.constant = scentView4Height
            }
        }
        
        if scents.count != 4 {
            scentView4.isHidden = true
            scentView4HeightConstraint.constant = 0
        }
    }
    
    // MARK: - @IBAction Functions

}
