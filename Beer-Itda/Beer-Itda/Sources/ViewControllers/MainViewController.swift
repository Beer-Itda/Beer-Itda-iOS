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
    }
    
    // MARK: - @IBAction Functions
    
    // MARK: - Functions
    
    private func registerXib() {
        self.headerView = Bundle.main.loadNibNamed(Const.Xib.Name.beerAwardHeaderView, owner: self, options: nil)?.last as? BeerAwardHeaderView
        
        mainTableView.register(UINib(nibName: Const.Xib.Name.mainTableViewCell, bundle: nil), forCellReuseIdentifier: Const.Xib.Identifier.mainTableViewCell)
        
    }
    
    private func initHeaderView() {
        self.mainTableView.tableHeaderView = self.headerView
        self.mainTableView.tableHeaderView?.frame.size.height = 500
    }
    
    private func assignDelegate() {
        mainTableView.delegate = self
    }
    
    private func assignDataSource() {
        mainTableView.dataSource = self
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
            
            print("dd")
            
            return cell
        }
        return UITableViewCell()
    }
}
