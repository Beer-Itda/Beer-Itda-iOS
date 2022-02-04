//
//  ReviewModalViewController.swift
//  Beer-Itda
//
//  Created by 초이 on 2021/06/21.
//

import UIKit

class ReviewModalViewController: UIViewController {
    
    // MARK: - Properties
    var starImageViews = [UIImageView]()
    
    // MARK: - @IBOutlet Properties

    @IBOutlet weak var starSlider: UISlider!
    @IBOutlet weak var starStackView: UIStackView!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var textFieldBgView: UIView!
    @IBOutlet weak var reviewTextView: UITextView!
    @IBOutlet weak var levelGuideButton: UIButton!
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initSlider()
        initStarImageViewArray()
        initTextView()
        initButton()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        initNavigationBar()
    }
    
    // MARK: - Functions
    
    private func initNavigationBar() {
        self.navigationController?.isNavigationBarHidden = true
    }
    
    private func initSlider() {
        starSlider.addTarget(self, action: #selector(slideStarSlider), for: UIControl.Event.valueChanged)
        starSlider.setThumbImage(UIImage(), for: .normal)
    }
    
    private func initStarImageViewArray() {
        for idx in 0..<5 {
            starImageViews.append(starStackView.subviews[idx] as? UIImageView ?? UIImageView())
        }
    }
    
    private func initTextView() {
        textFieldBgView.makeRoundedWithBorder(radius: 16, color: UIColor.darkGray.cgColor)
        reviewTextView.textContainerInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    private func initButton() {
        levelGuideButton.makeRounded(radius: levelGuideButton.frame.height / 2)
    }
    
    // 빈 별
    private func showStarImageEmpty(imageView: UIImageView) {
        imageView.image = Const.Image.starEmpty
    }
    
    // 반 채워진 별
    private func showStarImageHalf(imageView: UIImageView) {
        imageView.image = Const.Image.starHalf
    }
    
    // 다 채워진 별
    private func showStarImageFull(imageView: UIImageView) {
        imageView.image = Const.Image.starFull
    }
    
    func pushToLevelGuideViewController() {
        let levelGuideStoryboard = UIStoryboard(name: Const.Storyboard.Name.levelGuide, bundle: nil)
        guard let levelGuideViewController = levelGuideStoryboard.instantiateViewController(withIdentifier: Const.ViewController.Identifier.levelGuide) as? LevelGuideViewController else {
            return
        }
        self.navigationController?.pushViewController(levelGuideViewController, animated: true)
    }
    
    // MARK: - @IBAction Functions

    @objc func slideStarSlider() {
        var value = starSlider.value
        var values: [Double] = [0, 0, 0, 0, 0]
        var rating: Double = 0
        
        for idx in 0..<5 {
            if value > 0.5 {
                value -= 1
                values[idx] = 1
                showStarImageFull(imageView: starImageViews[idx])
            } else if 0 < value && value < 0.5 {
                value -= 0.5
                values[idx] = 0.5
                showStarImageHalf(imageView: starImageViews[idx])
            } else {
                values[idx] = 0
                showStarImageEmpty(imageView: starImageViews[idx])
            }
        }
        
        for idx in 0..<5 {
            rating += values[idx]
        }
        
        ratingLabel.text = "\(rating)점"
    }
    
    @IBAction func touchLevelGuideButton(_ sender: Any) {
        pushToLevelGuideViewController()
    }
    
    @IBAction func touchCloseButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
