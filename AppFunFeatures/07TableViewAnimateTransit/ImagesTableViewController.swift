//
//  ImagesTableViewController.swift
//  AppFunFeautres
//
//  Created by Xin Zou on 2/25/19.
//  Copyright © 2019 Xin Zou. All rights reserved.
//


import UIKit

class ImagesTableViewController: PTTableViewController {
    
    let items = [#imageLiteral(resourceName: "commanders_566x252"), #imageLiteral(resourceName: "wowsBkGnd02"), #imageLiteral(resourceName: "wowsBkGnd04"), #imageLiteral(resourceName: "wowsBkGnd03"), #imageLiteral(resourceName: "consumablesTitleImg"), #imageLiteral(resourceName: "map_titleImg_568x244"), #imageLiteral(resourceName: "wowsBkGnd01")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.register(ParallaxCell.self, forCellReuseIdentifier: ParallaxCell.cellIdentifier)
    }
    
}
extension ImagesTableViewController {
    
    public override func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        return items.count
    }
    
    public override func tableView(_: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let cell = cell as? ParallaxCell else { return }
        
        let title = "title name \(indexPath.row)"
        if indexPath.row < items.count {
            cell.setImage(items[indexPath.row], title: title)
        }
    }
    
    public override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: ParallaxCell.cellIdentifier, for: indexPath) as? ParallaxCell {
            //        let cell: ParallaxCell = tableView.getReusableCellWithIdentifier(indexPath: indexPath)
            return cell
        }
        return UITableViewCell(frame: .zero)
    }
    
    public override func tableView(_: UITableView, didSelectRowAt _: IndexPath) {
        let vc = PTDetailViewController()
        pushViewController(vc)
    }
}




