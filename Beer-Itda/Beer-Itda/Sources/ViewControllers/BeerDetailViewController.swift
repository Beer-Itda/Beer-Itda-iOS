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
    var dummyReviews = ["이 맥주.. 제 인생 맥주 입니다 ㅠㅠㅜㅜㅜㅜ 너무 맛있어요 ㅠ 저는 과일향 나는 가볍게 마실 수 있는 맥주를 선호!!!!!!!!!!!!!!!! 하는 저에게 딱인 것 같습니다! 향이 너무 좋아요요요  너무 좋아요요요이 맥주.. 제 인생 맥주 입니다 ㅠㅠㅜㅜㅜㅜ 너무 맛있어요 ㅠ 저는 과일향 나는 가볍게 마실 수 있는 맥주를 선호!!!!!!!!!!!!!!!! 하는 저에게 딱인 것 같습니다! 향이 너무 좋아요요요  너무 좋아요요요이 맥주.. 제 인생 맥주 입니다 ㅠㅠㅜㅜㅜㅜ 너무 맛있어요 ㅠ 저는 과일향 나는 가볍게 마실 수 있는 맥주를 선호!!!!!!!!!!!!!!!! 하는 저에게 딱인 것 같습니다! 향이 너무 좋아요요요  너무 좋아요요요", "", "이 맥주.. 제 인생 맥주 입니다 ㅠㅠㅜㅜㅜㅜ 너무 맛있어요 ㅠ 저는 과일향 나는 가볍게 마실 수 있는", "이 맥주.. 제 인생 맥주 입니다 ㅠㅠㅜㅜㅜㅜ 너무 맛있어요 ㅠ 저는 과일향 나는 가볍게 마실 수 있는 맥주를 선호!!!!!!!!!!!!!!!! 하는 저에게 딱인 것 같습니다! 향이 너무 좋아요요요  너무 좋아요요요..."]
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
    
    // reivews
    @IBOutlet weak var reviewStackView: UIStackView!
    @IBOutlet weak var reviewTableView: UITableView!
    @IBOutlet weak var writeReviewView: UIView!
    
    // other beer
    @IBOutlet weak var sameStyleCollectionView: UICollectionView!
    @IBOutlet weak var sameScentCollectionView: UICollectionView!
    
    // MARK: - View Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        initScentViews()
        assignDelegate()
        assignDataSource()
        registerXib()
        initNavigationBar()
        addTapGesture()
        reviewTableView.rowHeight = UITableView.automaticDimension
    }
    
    override func viewDidAppear(_ animated: Bool) {
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
    
    private func initNavigationBar() {
        self.navigationController?.initWithOneCustomButton(navigationItem: self.navigationItem,
                                                           firstButtonImage: Const.Image.btnUnlike,
                                                           firstButtonClosure: #selector(touchLikeButton(_:)))
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
        // reviewTableView.delegate = self
        sameStyleCollectionView.delegate = self
        sameScentCollectionView.delegate = self
    }
    
    private func assignDataSource() {
        reviewTableView.dataSource = self
        sameStyleCollectionView.dataSource = self
        sameScentCollectionView.dataSource = self
    }
    
    private func registerXib() {
        let cellNib = UINib(nibName: Const.Xib.Name.mainCollectionViewCell, bundle: nil)
        self.sameStyleCollectionView.register(cellNib, forCellWithReuseIdentifier: Const.Xib.Identifier.mainCollectionViewCell)
        self.sameScentCollectionView.register(cellNib, forCellWithReuseIdentifier: Const.Xib.Identifier.mainCollectionViewCell)
        
        let reviewCellNib = UINib(nibName: Const.Xib.Name.reviewTableViewCell, bundle: nil)
        self.reviewTableView.register(reviewCellNib, forCellReuseIdentifier: Const.Xib.Identifier.reviewTableViewCell)
    }
    
    private func pushToReviewAllViewController() {
        let reviewAllStoryboard = UIStoryboard(name: Const.Storyboard.Name.reviewAll, bundle: nil)
        guard let reviewAllViewController = reviewAllStoryboard.instantiateViewController(withIdentifier: Const.ViewController.Identifier.reviewAll) as? ReviewAllViewController else {
            return
        }
        self.navigationController?.pushViewController(reviewAllViewController, animated: true)
    }
    
    private func presentReviewModalViewController() {
        let reviewModalStoryboard = UIStoryboard(name: Const.Storyboard.Name.reviewModal, bundle: nil)
        guard let reviewModalViewController = reviewModalStoryboard.instantiateViewController(withIdentifier: Const.ViewController.Identifier.reviewModal) as? ReviewModalViewController else {
            return
        }
        
        reviewModalViewController.modalPresentationStyle = .custom
        reviewModalViewController.transitioningDelegate = self
        present(reviewModalViewController, animated: true, completion: nil)
    }
    
    private func addTapGesture() {
        let writeReviewGesture: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(touchWriteReviewButton(_:)))
        writeReviewView.addGestureRecognizer(writeReviewGesture)
    }
    
    // MARK: - @IBAction Functions
    
    @IBAction func touchMoreReviewButton(_ sender: Any) {
        pushToReviewAllViewController()
    }
    
    @objc func touchWriteReviewButton(_ gesture: UITapGestureRecognizer) {
        presentReviewModalViewController()
    }
    
    @objc func touchLikeButton(_ sender: UIBarButtonItem) {
        if sender.image == Const.Image.btnUnlike {
            sender.image = Const.Image.btnLike
        } else {
            sender.image = Const.Image.btnUnlike
        }
    }
}

// MARK: - UITableViewDelegate

//extension BeerDetailViewController: UITableViewDelegate {
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        
//        var textHeight = dummyReviews[indexPath.row].boundingrec
//        
//        return 200
//    }
//}

// MARK: - UITableViewDataSource

extension BeerDetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dummyReviews.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Const.Xib.Identifier.reviewTableViewCell, for: indexPath) as? ReviewTableViewCell else {
            return UITableViewCell()
        }
        
        cell.setCell(reviewText: dummyReviews[indexPath.row])
        
        return cell
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

extension BeerDetailViewController: UIViewControllerTransitioningDelegate {
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        HalfModalPresentationController(presentedViewController: presented, presenting: presenting)
    }
}
