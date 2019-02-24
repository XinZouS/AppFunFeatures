//
//  AnimateTransitBaseViewController.swift
//  AppFunFeautres
//
//  Created by Xin Zou on 2/23/19.
//  Copyright © 2019 Xin Zou. All rights reserved.
//

import UIKit

class AnimateTransitBaseViewController: UIViewController {
    
    let dataSource: [UIImage] = [ #imageLiteral(resourceName: "567-1")]
    let imageView = UIImageView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setupUI()
    }
    
    private func setupUI() {
        imageView.contentMode = .scaleAspectFit
        imageView.image = #imageLiteral(resourceName: "567-1")
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapGestureResponder))
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(tapGesture)
        view.addSubview(imageView)
        let wh: CGFloat = 50
        let vs = self.view.safeAreaLayoutGuide
        imageView.anchor(left: vs.leftAnchor, top: vs.topAnchor, right: nil, bottom: nil, leftConstent: 30, topConstent: 66, rightConstent: 0, bottomConstent: 0, width: wh, height: wh)
    }
    
    @objc private func tapGestureResponder() {
        let dataSource = LocalDataSource(numberOfItems: {
            return self.dataSource.count
        }, localImage: { index -> UIImage? in
            return self.dataSource[index]
        })
        let trans = PhotoBrowserZoomTransitioning { [unowned self] (browser, index, view) -> CGRect? in
            return PhotoBrowserZoomTransitioning.resRect(oriRes: self.imageView, to: view)
        }
        let pb = PhotoBrowser(dataSource: dataSource, delegate: PhotoBrowserBaseDelegate(), transDelegate: trans)
        pb.show(currentTopVC: self, pageIndex: 0)
    }
    
}
