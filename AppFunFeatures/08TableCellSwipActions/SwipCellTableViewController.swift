//
//  SwipCellTableViewController.swift
//  AppFunFeautres
//
//  Created by Xin Zou on 3/12/19.
//  Copyright © 2019 Xin Zou. All rights reserved.
//

import UIKit

class SwipCellTableViewController: UIViewController {
    
    let tableView = UITableView()
    let cellId = "swipCellId"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }
    
    
    private func setupTableView() {
        let vs = view.safeAreaLayoutGuide
        view.addSubview(tableView)
        tableView.anchor(left: vs.leftAnchor, top: vs.topAnchor, right: vs.rightAnchor, bottom: vs.bottomAnchor)
        
        
    }
    
}


class SwipCell: UITableViewCell {
    
    let colorView = UIView()
    
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
    }
    
}
