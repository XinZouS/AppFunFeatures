//
//  StretchyCollectionViewController.swift
//  CoreDataSetup
//
//  Created by Xin Zou on 1/15/19.
//  Copyright © 2019 Xin Zou. All rights reserved.
//

import UIKit

class StretchyCollectionViewController: UICollectionViewController {

    fileprivate let reuseIdentifier = "Cell"
    fileprivate let headerCellId = "header"
    fileprivate let padding: CGFloat = 16
    
    fileprivate var headerView: CollectionHeaderView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(true, animated: true)
        
        setupCollectionView()
        setupFloatLayout()
    }
    
    
    private func setupCollectionView() {
        collectionView.backgroundColor = .white
        collectionView.contentInsetAdjustmentBehavior = .never // push content to top full screen under status bar
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        let headerKind = UICollectionView.elementKindSectionHeader
        collectionView.register(CollectionHeaderView.self, forSupplementaryViewOfKind: headerKind, withReuseIdentifier: headerCellId)
    }
    
    private func setupFloatLayout() {
        guard let layout = collectionViewLayout as? UICollectionViewFlowLayout else { return }
        layout.sectionInset = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
}

// cell setup
extension StretchyCollectionViewController {
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 16
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
        cell.backgroundColor = .cyan
        return cell
    }
    
    
}

extension StretchyCollectionViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.bounds.width - 2 * padding, height: 66)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: self.view.bounds.width, height: 366)
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard let headerView = headerView else { return }
        let offsetY = scrollView.contentOffset.y
        if offsetY < 0 {
            headerView.animator?.fractionComplete = abs(offsetY) / 366
        }
    }
}

// setup Header view
extension StretchyCollectionViewController {
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headerKind = UICollectionView.elementKindSectionHeader
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: headerKind, withReuseIdentifier: headerCellId, for: indexPath)
        if let header = header as? CollectionHeaderView {
            self.headerView = header
        }
        return header
    }
}
