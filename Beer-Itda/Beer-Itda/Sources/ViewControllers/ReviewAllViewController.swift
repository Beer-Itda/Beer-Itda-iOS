//
//  ReviewAllViewController.swift
//  Beer-Itda
//
//  Created by 초이 on 2021/03/20.
//

import UIKit

class ReviewAllViewController: UIViewController {
    @IBOutlet weak var reviewTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        assignDelegate()
        assignDataSource()
        registerXib()
    }
    
    private func assignDelegate() {
        reviewTableView.delegate = self
    }
    
    private func assignDataSource() {
        reviewTableView.dataSource = self
    }
    
    private func registerXib() {
        reviewTableView.register(UINib(nibName: Const.Xib.Name.reviewTableViewCell, bundle: nil), forCellReuseIdentifier: Const.Xib.Identifier.reviewTableViewCell)
    }

}

extension ReviewAllViewController: UITableViewDelegate {
    
}

extension ReviewAllViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = reviewTableView.dequeueReusableCell(withIdentifier: Const.Xib.Identifier.reviewTableViewCell, for: indexPath) as? ReviewTableViewCell else {
            return UITableViewCell()
        }
        
        return cell
    }
    
}
