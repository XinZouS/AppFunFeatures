//
//  SwipCellTableViewController.swift
//  AppFunFeautres
//
//  Created by Xin Zou on 3/12/19.
//  Copyright © 2019 Xin Zou. All rights reserved.
//

import UIKit

class SwipCellTableViewController: UIViewController {
    
    var rows: [Int] = [1,2,3,4,5,6,7,8,9]
    
    let tableView = UITableView()
    let cellId = "swipCellId"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
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
        return 160
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        if indexPath.row < rows.count {
            let r = rows[indexPath.row]
            let delete = UIContextualAction(style: .destructive, title: "Delete") { [unowned self] (action, view, actionPerformed: @escaping (Bool) -> Void) in
                // ⭐️ actionPerformed:(Bool)->() is used for indicate that the row has been removed or not;
                let alert = UIAlertController(title: "Delete row", message: "Are you sure to delete row \(r) ?", preferredStyle: .alert)
                let yes = UIAlertAction(title: "Yes", style: .destructive, handler: { (alertAction) in
                    // perform the deletaion for datasource and tableview:
                    self.rows.remove(at: indexPath.row) // ⚠️ MUST remove datasource first, (for later table update)
                    tableView.deleteRows(at: [indexPath], with: .automatic) // and then remove row, otherwise will crash!
                    actionPerformed(true)
                })
                let no = UIAlertAction(title: "No", style: .cancel, handler: { (alertAction) in
                    actionPerformed(false)
                })
                alert.addAction(yes)
                alert.addAction(no)
                self.present(alert, animated: true)
            }
            // optional setups:
            delete.image = #imageLiteral(resourceName: "ShareIcon")
            delete.backgroundColor = #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1)
            
            return UISwipeActionsConfiguration(actions: [delete])
        }
        return nil
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
