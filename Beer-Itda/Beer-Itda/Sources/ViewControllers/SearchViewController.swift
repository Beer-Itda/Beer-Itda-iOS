//
//  SearchViewController.swift
//  Beer-Itda
//
//  Created by 초이 on 2021/03/20.
//

import UIKit

class SearchViewController: UIViewController {
    
    // MARK: - @IBOutlet Properties
    
    @IBOutlet weak var searchTableView: UITableView!
    @IBOutlet weak var beforeSearchStackView: UIStackView!
    
    // MARK: - View Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        initSearchBar()
        showBeforeSearchStackView()
    }
    
    // MARK: - Functions
    
    private func initSearchBar() {
        // searchBar 만들기
        let searchBar = UISearchBar(frame: CGRect(x: 0, y: 0, width: view.frame.width - 80, height: 0))
        
        // 검색 버튼
        let search = UIBarButtonItem(systemItem: .search, primaryAction: UIAction(handler: { _ in
            // search action
            self.searchBarSearchButtonClicked(searchBar)
        }))
        self.navigationItem.rightBarButtonItem = search
        self.navigationItem.rightBarButtonItem?.tintColor = UIColor.black
        
        // placeholder
        searchBar.placeholder = "맥주를 검색해보세요"
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: searchBar)
        
        // 왼쪽 돋보기 아이콘 없애기
        searchBar.setImage(UIImage(), for: UISearchBar.Icon.search, state: .normal)
        
        // textfield 배경색 없애기
        searchBar.searchTextField.backgroundColor = UIColor.clear
        
        // textfield 글자크기
        searchBar.searchTextField.font = UIFont.systemFont(ofSize: 14)
        
        // delegate
        searchBar.delegate = self
    }
    
    private func assignDelegate() {
        self.searchTableView.delegate = self
    }
    
    private func assignDataSource() {
        self.searchTableView.dataSource = self
    }
    
    private func showBeforeSearchStackView() {
        // 검색 전 뷰
        beforeSearchStackView.isHidden = false
    }
    
    private func hideBeforeSearchStackView() {
        // 검색 전 뷰
        beforeSearchStackView.isHidden = true
    }
}

// MARK: - UISearchBarDelegate

extension SearchViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        hideBeforeSearchStackView()
        print("search")
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        hideBeforeSearchStackView()
    }
}

// MARK: - UITableViewDelegate

extension SearchViewController: UITableViewDelegate {
    
}

// MARK: - UITableViewDataSource

extension SearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
}
