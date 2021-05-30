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
    
    // 기기 width
    var screenWidth = UIScreen.main.bounds.width
    
    // MARK: - @IBOutlet Properties
    
    @IBOutlet weak var selectedStyleCollectionView: UICollectionView!
    @IBOutlet weak var largeCategorySegmentedControl: UISegmentedControl!
    @IBOutlet weak var smallCategoryCollectionView: UICollectionView!
    @IBOutlet weak var skipButton: UIButton!
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        registerXib()
        initSkipButton()
        assignDelegate()
        assignDataSource()
        initializeSegmentedControl()
        initializeNavigationBar()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
    }
    
    // MARK: - @IBAction Properties
    
    @IBAction func touchSelectButton(_ sender: Any) {
        pushToScentViewController()
    }
    
    @IBAction func changeSegmentedControl(_ sender: UISegmentedControl) {
        largeCategorySegmentedControl.changeUnderlinePosition()
    }
    
    @IBAction func touchSkipButton(_ sender: Any) {
        pushToScentViewController()
    }
    
    // MARK: - Functions
    
    // register function
    private func registerXib() {
        selectedStyleCollectionView.register(UINib(nibName: Const.Xib.Name.selectedFilterCollectionViewCell, bundle: nil), forCellWithReuseIdentifier: Const.Xib.Identifier.selectedFilterCollectionViewCell)
        smallCategoryCollectionView.register(UINib(nibName: Const.Xib.Name.roundedSquareCollectionViewCell, bundle: nil), forCellWithReuseIdentifier: Const.Xib.Identifier.roundedSquareCollectionViewCell)
        smallCategoryCollectionView.register(UINib(nibName: Const.Xib.Name.mediumCategoryCollectionViewCell, bundle: nil), forCellWithReuseIdentifier: Const.Xib.Identifier.mediumCategoryCollectionViewCell)
        smallCategoryCollectionView.register(UINib(nibName: Const.Xib.Name.labelCollectionViewCell, bundle: nil), forCellWithReuseIdentifier: Const.Xib.Identifier.labelCollectionViewCell)
        smallCategoryCollectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: UICollectionViewCell.identifier)
    }
    
    // assign functions
    private func assignDelegate() {
        selectedStyleCollectionView.delegate = self
        smallCategoryCollectionView.delegate = self
    }
    
    private func assignDataSource() {
        selectedStyleCollectionView.dataSource = self
        smallCategoryCollectionView.dataSource = self
    }
    
    // init functions
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
    
    private func initSkipButton() {
        skipButton.contentEdgeInsets = UIEdgeInsets(top: 8, left: 12, bottom: 8, right: 12)
        
        skipButton.layer.masksToBounds = true
        skipButton.layer.borderWidth = 1
    }
    
    // transition function
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
    
    // section 개수
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        if collectionView == smallCategoryCollectionView {
            return 3
        }
        return 1
    }
    
    // cell 개수
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        if collectionView == selectedStyleCollectionView {
            return 3
        } else if collectionView == smallCategoryCollectionView {
            if section == 0 {
                return 1
            } else if section == 1 {
                return 1
            } else if section == 2 {
                return 25
            }
        }
        return 0
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
            
        } else if collectionView == smallCategoryCollectionView {
            
            // 첫째줄에 중분류 collection view 삽입
            if indexPath.section == 0 {
                
                // Create a new empty cell for reuse, this cell will only be used for the frist cell.
                let cell = smallCategoryCollectionView.dequeueReusableCell(withReuseIdentifier: UICollectionViewCell.identifier, for: IndexPath(row: 0, section: 0))
                
                cell.backgroundColor = UIColor.red
                
                // Programmically Create a Horizontal Collection View add to the Cell
                let mediumCategoryCollectionView: MediumCategoryCollectionView = {
                    
                    let data = ["Ale", "Lager", "dd", "sda", "s", "s", "ss", "s2"]
                    
                    // Only Flow Layout has scroll direction
                    let layout = UICollectionViewFlowLayout()
                    layout.scrollDirection = .horizontal
                    // Init with Data.
                    let mediumCategoryCollectionView = MediumCategoryCollectionView(frame: cell.bounds, collectionViewLayout: layout, data: data)
                    return mediumCategoryCollectionView
                }()
                // Adjust cell's frame and add it as a subview.
                cell.addSubview(mediumCategoryCollectionView)
                return cell
            } else if indexPath.section == 1 {
                
                guard let cell = smallCategoryCollectionView.dequeueReusableCell(withReuseIdentifier: Const.Xib.Identifier.labelCollectionViewCell, for: indexPath) as? LabelCollectionViewCell else {
                    return UICollectionViewCell()
                }
                
                return cell
                
            } else if indexPath.section == 2 {
                
                guard let cell = smallCategoryCollectionView.dequeueReusableCell(withReuseIdentifier: Const.Xib.Identifier.roundedSquareCollectionViewCell, for: indexPath) as? RoundedSquareCollectionViewCell else {
                    return UICollectionViewCell()
                }
                
                let titles = ["전체보기", "Bourbon County Stout", "Bourbon County Stout", "Ale", "Abbey Ale", "Blonde Ale", "Old Ale", "Bourbon County Stout", "Bourbon County Stout", "Ale", "Abbey Ale", "Blonde Ale", "Old Ale", "Bourbon County Stout", "Bourbon County Stout", "Ale", "Abbey Ale", "Blonde Ale", "Old Ale", "Bourbon County Stout", "Bourbon County Stout", "Ale", "Abbey Ale", "Blonde Ale", "Old Ale", ]
                
                cell.setCell(title: titles[indexPath.row])
                
                return cell
            }
            
            return UICollectionViewCell()
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
        } else if collectionView == smallCategoryCollectionView {
            if section == 0 {
                return UIEdgeInsets(top: 30, left: 0, bottom: 30, right: 0)
            }
            return UIEdgeInsets(top: 0, left: 18, bottom: 30, right: 18)
        } else {
            return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        }
    }
    
    // cell 사이 간격
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        if collectionView == selectedStyleCollectionView {
            return 8
        } else if collectionView == smallCategoryCollectionView {
            return 9
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
        } else if collectionView == smallCategoryCollectionView {
            
            // 첫째줄 중분류 collectionview
            if indexPath.section == 0 {
                return CGSize(width: screenWidth, height: 150)
            } else if indexPath.section == 1 {
                return CGSize(width: screenWidth - 36, height: 40)
            }
            
            let cellWidth = (self.screenWidth - 27 - 36) / 3
            
            return CGSize(width: cellWidth, height: 48)
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
}
