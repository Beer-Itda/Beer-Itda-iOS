//
//  ViewController.swift
//  Beer-Itda
//
//  Created by 초이 on 2021/03/17.
//

import UIKit

class MainViewController: UIViewController {
    
    // MARK: - Properties
    
    var headerView: BeerAwardHeaderView?
    
    enum Title: String {
        case style = "회원님이 좋아하는 스타일"
        case scent = "회원님이 좋아하는 향"
        case recommend = "이런 맥주는 어떠세요?"
    }
    
    // MARK: - @IBOutlet Properties
    
    @IBOutlet weak var mainTableView: UITableView!
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        registerXib()
        initHeaderView()
        assignDelegate()
        assignDataSource()
        initNavigationBar()
        initFilterButton()
    }
    
    // MARK: - @IBAction Functions
    
    // MARK: - Functions
    
    private func registerXib() {
        self.headerView = Bundle.main.loadNibNamed(Const.Xib.Name.beerAwardHeaderView, owner: self, options: nil)?.last as? BeerAwardHeaderView
        
        mainTableView.register(UINib(nibName: Const.Xib.Name.mainTableViewCell, bundle: nil), forCellReuseIdentifier: Const.Xib.Identifier.mainTableViewCell)
        
    }
    
    private func initHeaderView() {
        self.mainTableView.tableHeaderView = self.headerView
        self.mainTableView.tableHeaderView?.frame.size.height = 480
    }
    
    private func assignDelegate() {
        mainTableView.delegate = self
    }
    
    private func assignDataSource() {
        mainTableView.dataSource = self
    }
    
    private func initNavigationBar() {
        self.navigationController?.initializeNavigationBarWithoutBackButton(navigationItem: self.navigationItem)
    }
    
    @objc func touchFilterButton() {
        let styleStoryboard = UIStoryboard(name: Const.Storyboard.Name.style, bundle: nil)
        guard let styleViewController = styleStoryboard.instantiateViewController(withIdentifier: Const.ViewController.Identifier.style) as? StyleViewController else {
            return
        }
        styleViewController.styleViewUsage = .main
        self.navigationController?.pushViewController(styleViewController, animated: true)
    }
    
    private func initFilterButton() {
        // 필터 버튼
        let filterButton = UIBarButtonItem(image: Const.Image.btnFilter, style: .plain, target: self, action: #selector(touchFilterButton))
        filterButton.tintColor = UIColor.Black

        self.navigationItem.leftBarButtonItem = filterButton
    }
}

// MARK: - UITableViewDelegate

extension MainViewController: UITableViewDelegate {
    
}

// MARK: - UITableViewDataSource

extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = mainTableView.dequeueReusableCell(withIdentifier: Const.Xib.Identifier.mainTableViewCell) as? MainTableViewCell {
            
            switch indexPath.row {
            case 0:
                // 회원님이 좋아하는 스타일
                cell.setCell(title: Title.style.rawValue)
            case 1:
                // 회원님이 좋아하는 향
                cell.setCell(title: Title.scent.rawValue)
            case 2:
                // 이런 맥주는 어떠세요?
                cell.setCell(title: Title.recommend.rawValue)
            default:
                cell.setCell(title: "")
            }
            
            // more button handler
            cell.moreButton.tag = indexPath.row
            cell.moreButton.addTarget(self, action: #selector(pushToBeerAllViewController), for: .touchUpInside)
            
            return cell
        }
        return UITableViewCell()
    }
    
    @objc func pushToBeerAllViewController(sender: UIButton) {
        
        let beerAllStoryboard = UIStoryboard(name: Const.Storyboard.Name.beerAll, bundle: nil)
        guard let beerAllViewController = beerAllStoryboard.instantiateViewController(withIdentifier: Const.ViewController.Identifier.beerAll) as? BeerAllViewController else {
            return
        }
        
        switch sender.tag {
        case 0:
            // 회원님이 좋아하는 스타일
            beerAllViewController.navTitle = Title.style.rawValue
            beerAllViewController.isFilterCollectionViewHidden = false
        case 1:
            // 회원님이 좋아하는 향
            beerAllViewController.navTitle = Title.scent.rawValue
            beerAllViewController.isFilterCollectionViewHidden = false
        case 2:
            // 이런 맥주는 어떠세요?
            beerAllViewController.navTitle = Title.recommend.rawValue
            beerAllViewController.isFilterCollectionViewHidden = true
        default:
            beerAllViewController.navTitle = ""
        }
        
        self.navigationController?.pushViewController(beerAllViewController, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 320
    }
}
