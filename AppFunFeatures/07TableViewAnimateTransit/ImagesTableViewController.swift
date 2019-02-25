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
        configureNavigationBar()
        self.tableView.register(ParallaxCell.self, forCellReuseIdentifier: ParallaxCell.cellIdentifier)
    }
    
    fileprivate func configureNavigationBar() {
        //transparent background
        UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .default)
        UINavigationBar.appearance().shadowImage = UIImage()
        UINavigationBar.appearance().isTranslucent = true
        
        if let font = UIFont(name: "Avenir-medium", size: 18) {
            UINavigationBar.appearance().titleTextAttributes = [
                NSAttributedString.Key.foregroundColor: UIColor.white,
                NSAttributedString.Key.font: font,
            ]
        }
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
        let vc = ImageDetailViewController()
        pushViewController(vc)
    }
    
    public override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
}




