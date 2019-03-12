//
//  SwipCellTableViewController.swift
//  AppFunFeautres
//
//  Created by Xin Zou on 3/12/19.
//  Copyright © 2019 Xin Zou. All rights reserved.
//

import UIKit

class SwipCellTableViewController: UIViewController {
    
    let rows: [Int] = [1,2,3,4,5,6,7,8,9]
    
    let tableView = UITableView()
    let cellId = "swipCellId"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }
    
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(SwipCell.self, forCellReuseIdentifier: cellId)
        let vs = view.safeAreaLayoutGuide
        view.addSubview(tableView)
        tableView.anchor(left: vs.leftAnchor, top: vs.topAnchor, right: vs.rightAnchor, bottom: vs.bottomAnchor)
        
        
    }
    
}

extension SwipCellTableViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rows.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as? SwipCell else {
            return UITableViewCell()
        }
        cell.selectionStyle = .none
        if indexPath.row < rows.count {
            cell.titleLabel.text = "Row \(rows[indexPath.row])"
        }
        return cell
    }
    
}

extension SwipCellTableViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
}


class SwipCell: UITableViewCell {
    
    let colorView = UIView()
    let titleLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    private func setupView() {
        colorView.backgroundColor = .cyan
        addSubview(colorView)
        colorView.fillSuperview(padding: UIEdgeInsets(top: 6, left: 6, bottom: 6, right: 6))
        
        addSubview(titleLabel)
        titleLabel.anchorCenterIn(self, width: 100, height: 20)
    }
    
}
