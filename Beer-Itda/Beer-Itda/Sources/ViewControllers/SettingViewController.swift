//
//  SettingViewController.swift
//  Beer-Itda
//
//  Created by 초이 on 2021/03/20.
//

import UIKit

class SettingViewController: UIViewController {
    
    // MARK: - Properties
    let cellIdentifier = "settingTableViewCell"
    let titleLabels = ["공지사항", "문의하기", "이용약관", "개인정보 처리방침", "알림설정"]
    
    // MARK: - @IBOutlet Properties
    
    @IBOutlet weak var settingTableView: UITableView!
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initNavigationBar()
        assignDelegate()
        assignDataSource()
    }
    
    // MARK: - Functions
    
    private func initNavigationBar() {
        self.navigationController?.initWithBackButton()
        self.navigationItem.title = "설정"
    }
    
    private func assignDelegate() {
        settingTableView.delegate = self
    }
    
    private func assignDataSource() {
        settingTableView.dataSource = self
    }
}

extension SettingViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}

extension SettingViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: self.cellIdentifier, for: indexPath) as? SettingTableViewCell else { return UITableViewCell() }
        
        cell.titleLabel.text = titleLabels[indexPath.row]
        
        return cell
    }
    
    
}
