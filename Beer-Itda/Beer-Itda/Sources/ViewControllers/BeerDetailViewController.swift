//
//  BeerDetailViewController.swift
//  Beer-Itda
//
//  Created by 초이 on 2021/03/20.
//

import UIKit

class BeerDetailViewController: UIViewController {
    
    // MARK: - Properties
    
    // UIScreen
    let screenWidth = UIScreen.main.bounds.width
    
    // scents
    let scentView5Height: CGFloat = 32
    var scents = ["시트러스 향", "시트러스 향", "시트러스 향", "시트러스 향"]
    var scentViews = [UIView]()
    var scentLabels = [UILabel]()
    
    // reviews
    var reviewTextViews = [UITextView]()
    var reviewMoreButtons = [UIButton]()
    
    // MARK: - @IBOutlet Properties
    
    @IBOutlet weak var beerImageView: UIImageView!
    @IBOutlet weak var companyLabel: UILabel!
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var beerNameLabel: UILabel!
    @IBOutlet weak var beerEngNameLabel: UILabel!
    @IBOutlet weak var abvLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    
    // scents
    @IBOutlet weak var scentStackView: UIStackView!
    @IBOutlet weak var scentView1: UIView!
    @IBOutlet weak var scentLabel1: UILabel!
    @IBOutlet weak var scentView2: UIView!
    @IBOutlet weak var scentLabel2: UILabel!
    @IBOutlet weak var scentView3: UIView!
    @IBOutlet weak var scentLabel3: UILabel!
    @IBOutlet weak var scentView4: UIView!
    @IBOutlet weak var scentLabel4: UILabel!
    @IBOutlet weak var scentView5: UIView!
    @IBOutlet weak var scentLabel5: UILabel!
    @IBOutlet weak var scentView5HeightConstraint: NSLayoutConstraint!
    
    // star
    @IBOutlet weak var starStackView: UIStackView!
    @IBOutlet weak var writeReviewButton: UIButton!
    
    // review
    @IBOutlet weak var nicknameLabel1: UILabel!
    @IBOutlet weak var starLabel1: UILabel!
    @IBOutlet weak var dateLabel1: UILabel!
    @IBOutlet weak var reviewTextView1: UITextView!
    @IBOutlet weak var moreButton1: UIButton!
    
    @IBOutlet weak var nicknameLabel2: UILabel!
    @IBOutlet weak var starLabel2: UILabel!
    @IBOutlet weak var dateLabel2: UILabel!
    @IBOutlet weak var reviewTextView2: UITextView!
    @IBOutlet weak var moreButton2: UIButton!
    
    @IBOutlet weak var nicknameLabel3: UILabel!
    @IBOutlet weak var starLabel3: UILabel!
    @IBOutlet weak var dateLabel3: UILabel!
    @IBOutlet weak var reviewTextView3: UITextView!
    @IBOutlet weak var moreButton3: UIButton!
    
    // other beer
    @IBOutlet weak var sameStyleCollectionView: UICollectionView!
    @IBOutlet weak var sameScentCollectionView: UICollectionView!
    
    // MARK: - View Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        initScentViews()
        initReviewTextViewsMaxLines()
        assignDelegate()
        assignDataSource()
        registerXib()
        initStarViews()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        initMoreButtons()
        modifyScentViewByScreenWidth()
    }
    
    // MARK: - Functions
    
    // 향 뷰 초기화
    private func initScentViews() {
        
        scentViews.append(scentView1)
        scentViews.append(scentView2)
        scentViews.append(scentView3)
        scentViews.append(scentView4)
        scentViews.append(scentView5)
        
        scentLabels.append(scentLabel1)
        scentLabels.append(scentLabel2)
        scentLabels.append(scentLabel3)
        scentLabels.append(scentLabel4)
        scentLabels.append(scentLabel5)
        
        for idx in 0..<scents.count {
            scentViews[idx].isHidden = false
            scentViews[idx].makeRounded(radius: scentViews[idx].frame.height / 2)
            scentLabels[idx].text = scents[idx]
            scentView5HeightConstraint.constant = 0
        }
    }
    
    private func initReviewTextViewsMaxLines() {
        reviewTextViews.append(reviewTextView1)
        reviewTextViews.append(reviewTextView2)
        reviewTextViews.append(reviewTextView3)
        
        reviewMoreButtons.append(moreButton1)
        reviewMoreButtons.append(moreButton2)
        reviewMoreButtons.append(moreButton3)
        
        for idx in 0..<3 {
            reviewTextViews[idx].textContainer.maximumNumberOfLines = 3
            reviewTextViews[idx].textContainer.lineBreakMode = .byTruncatingTail
        }
    }
    
    private func initMoreButtons() {
        
        for idx in 0..<3 {
            
            let lineCount = (reviewTextViews[idx].contentSize.height - reviewTextViews[idx].textContainerInset.top - reviewTextViews[idx].textContainerInset.bottom) / reviewTextViews[idx].font!.lineHeight
            
            if lineCount <= 3 {
                reviewMoreButtons[idx].isHidden = true
            }
        }
    }
    
    private func modifyScentViewByScreenWidth() {
        if scentStackView.frame.width > screenWidth {
            if scents.count == 4 {
                scentLabels[4].text = scentLabels[3].text
                // scentView4 숨기기
                scentView4.isHidden = true
                
                // scentView5 보이기
                scentView5.isHidden = false
                scentView5.makeRounded(radius: scentView1.frame.height / 2)
                scentView5HeightConstraint.constant = scentView5Height
            }
        }
    }
    
    private func assignDelegate() {
        sameStyleCollectionView.delegate = self
        sameScentCollectionView.delegate = self
    }
    
    private func assignDataSource() {
        sameStyleCollectionView.dataSource = self
        sameScentCollectionView.dataSource = self
    }
    
    private func registerXib() {
        let cellNib = UINib(nibName: Const.Xib.Name.mainCollectionViewCell, bundle: nil)
        self.sameStyleCollectionView.register(cellNib, forCellWithReuseIdentifier: Const.Xib.Identifier.mainCollectionViewCell)
        self.sameScentCollectionView.register(cellNib, forCellWithReuseIdentifier: Const.Xib.Identifier.mainCollectionViewCell)
    }
    
    private func initStarViews() {
        // TODO: - 별채우기
        
        writeReviewButton.makeRounded(radius: 6)
    }
    
    // MARK: - @IBAction Functions

    @IBAction func touchMoreButton1(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        
        if sender.isSelected {
            // 펼치기
            reviewTextView1.textContainer.maximumNumberOfLines = 0
            reviewTextView1.invalidateIntrinsicContentSize()
        } else {
            // 접기
            reviewTextView1.textContainer.maximumNumberOfLines = 3
            reviewTextView1.invalidateIntrinsicContentSize()
        }
    }
    
    @IBAction func touchMoreButton2(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        
        if sender.isSelected {
            // 펼치기
            reviewTextView2.textContainer.maximumNumberOfLines = 0
            reviewTextView2.invalidateIntrinsicContentSize()
        } else {
            // 접기
            reviewTextView2.textContainer.maximumNumberOfLines = 3
            reviewTextView2.invalidateIntrinsicContentSize()
        }
    }
    
    @IBAction func touchMoreButton3(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        
        if sender.isSelected {
            // 펼치기
            reviewTextView3.textContainer.maximumNumberOfLines = 0
            reviewTextView3.invalidateIntrinsicContentSize()
        } else {
            // 접기
            reviewTextView3.textContainer.maximumNumberOfLines = 3
            reviewTextView3.invalidateIntrinsicContentSize()
        }
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension BeerDetailViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            return CGSize(width: 120, height: 209)
        }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 18, bottom: 0, right: 18)
    }
}

// MARK: - UICollectionViewDataSource

extension BeerDetailViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == sameStyleCollectionView {
            // 같은 스타일
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Const.Xib.Identifier.mainCollectionViewCell, for: indexPath) as? MainCollectionViewCell {
                // cell.setCell(news: news[indexPath.item])
                return cell
            }
            return UICollectionViewCell()
        } else {
            // 같은 향
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Const.Xib.Identifier.mainCollectionViewCell, for: indexPath) as? MainCollectionViewCell {
                // cell.setCell(news: news[indexPath.item])
                return cell
            }
            return UICollectionViewCell()
        }
    }
     
}
