//
//  ImageDetailViewController.swift
//  AppFunFeautres
//
//  Created by Xin Zou on 2/25/19.
//  Copyright © 2019 Xin Zou. All rights reserved.
//

import UIKit

public class ImageDetailViewController: PTDetailViewController {
    
    fileprivate var controlBottomConstrant: NSLayoutConstraint?
    
    // bottom control icons
    fileprivate var controlsViewContainer = UIView()
    fileprivate var controlView = UIView()
    fileprivate var plusImageView = UIImageView()
    fileprivate var controlTextLabel = UILabel()
    fileprivate var controlTextLableLending: NSLayoutConstraint?
    fileprivate var shareImageView = UIImageView()
    fileprivate var hertIconView = UIImageView()
    
    var backButton: UIButton?
    
    var bottomSafeArea: CGFloat {
        var result: CGFloat = 0
        if #available(iOS 11.0, *) {
            result = UIApplication.shared.keyWindow?.safeAreaInsets.bottom ?? 0
        }
        return result
    }
}

// MARK: life cicle

extension ImageDetailViewController {
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        setupControlViews()
        
        backButton = createBackButton()
        _ = createNavigationBarBackItem(button: backButton)
        
        // animations
        showBackButtonDuration(duration: 0.3)
        showControlViewDuration(duration: 0.3)
        
        _ = createBlurView()
    }
    
    private func setupControlViews() {
        let vs = view.safeAreaLayoutGuide
        view.addSubview(controlsViewContainer)
        controlsViewContainer.anchor(left: vs.leftAnchor, top: nil, right: vs.rightAnchor, bottom: nil, leftConstent: 0, topConstent: 0, rightConstent: 0, bottomConstent: 0, width: 0, height: 66)
        controlBottomConstrant = controlsViewContainer.bottomAnchor.constraint(equalTo: vs.bottomAnchor)
        controlBottomConstrant?.isActive = true
        
        // ???
        controlsViewContainer.addSubview(controlView)
        controlView.fillSuperview()
        
        let iconSize: CGFloat = 30
        controlView.addSubview(plusImageView)
        plusImageView.anchor(left: controlView.leftAnchor, top: nil, right: nil, bottom: nil, leftConstent: 20, topConstent: 0, rightConstent: 0, bottomConstent: 0, width: iconSize, height: iconSize)
        plusImageView.centerYAnchor.constraint(equalTo: controlView.centerYAnchor).isActive = true
        
        controlView.addSubview(controlTextLabel)
        controlTextLabel.translatesAutoresizingMaskIntoConstraints = false
        controlTextLabel.centerYAnchor.constraint(equalTo: controlView.centerYAnchor).isActive = true
        controlTextLableLending = controlTextLabel.leadingAnchor.constraint(equalTo: plusImageView.trailingAnchor)
        controlTextLableLending?.isActive = true
        
        controlView.addSubview(hertIconView)
        hertIconView.anchor(left: nil, top: nil, right: controlView.rightAnchor, bottom: nil, leftConstent: 0, topConstent: 0, rightConstent: 20, bottomConstent: 0, width: iconSize, height: iconSize)
        hertIconView.centerYAnchor.constraint(equalTo: controlView.centerYAnchor).isActive = true
        
        controlView.addSubview(shareImageView)
        shareImageView.anchor(left: nil, top: nil, right: hertIconView.leftAnchor, bottom: nil, leftConstent: 0, topConstent: 0, rightConstent: 20, bottomConstent: 0, width: iconSize, height: iconSize)
        shareImageView.centerYAnchor.constraint(equalTo: controlView.centerYAnchor).isActive = true
    }
    
}

// MARK: helpers

extension ImageDetailViewController {
    
    fileprivate func createBackButton() -> UIButton {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 22, height: 44))
        button.setImage(#imageLiteral(resourceName: "back"), for: .normal)
        button.addTarget(self, action: #selector(backButtonHandler), for: .touchUpInside)
        return button
    }
    
    fileprivate func createNavigationBarBackItem(button: UIButton?) -> UIBarButtonItem? {
        guard let button = button else {
            return nil
        }
        
        let buttonItem = UIBarButtonItem(customView: button)
        navigationItem.leftBarButtonItem = buttonItem
        return buttonItem
    }
    
    fileprivate func createBlurView() -> UIView {
        let height = controlView.bounds.height + bottomSafeArea
        let imageFrame = CGRect(x: 0, y: view.frame.size.height - height, width: view.frame.width, height: height)
        let image = view.makeScreenShotFromFrame(frame: imageFrame)
        let screnShotImageView = UIImageView(image: image)
        screnShotImageView.blurViewValue(value: 5)
        screnShotImageView.frame = controlsViewContainer.bounds
        screnShotImageView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        controlsViewContainer.insertSubview(screnShotImageView, at: 0)
        addOverlay(toView: screnShotImageView)
        return screnShotImageView
    }
    
    fileprivate func addOverlay(toView view: UIView) {
        let overlayView = UIView(frame: view.bounds)
        overlayView.backgroundColor = .black
        overlayView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        overlayView.alpha = 0.4
        view.addSubview(overlayView)
    }
}

// MARK: animations

extension ImageDetailViewController {
    
    fileprivate func showBackButtonDuration(duration: Double) {
        backButton?.rotateDuration(duration: duration, from: -CGFloat.pi / 4, to: 0)
        backButton?.scaleDuration(duration: duration, from: 0.5, to: 1)
        backButton?.opacityDuration(duration: duration, from: 0, to: 1)
    }
    
    fileprivate func showControlViewDuration(duration: Double) {
        moveUpControllerDuration(duration: duration)
        showControlButtonsDuration(duration: duration)
        showControlLabelDuration(duration: duration)
    }
    
    fileprivate func moveUpControllerDuration(duration: Double) {
        
        controlBottomConstrant?.constant = -controlsViewContainer.bounds.height
        view.layoutIfNeeded()
        
        controlBottomConstrant?.constant = 0
        UIView.animate(withDuration: duration, delay: 0, options: .curveEaseOut, animations: {
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
    
    fileprivate func showControlButtonsDuration(duration: Double) {
        [plusImageView, shareImageView, hertIconView].forEach {
            $0.rotateDuration(duration: duration, from: CGFloat.pi / 4, to: 0, delay: duration)
            $0.scaleDuration(duration: duration, from: 0.5, to: 1, delay: duration)
            $0.alpha = 0
            $0.opacityDuration(duration: duration, from: 0, to: 1, delay: duration, remove: false)
        }
    }
    
    fileprivate func showControlLabelDuration(duration: Double) {
        controlTextLabel.alpha = 0
        controlTextLabel.opacityDuration(duration: duration, from: 0, to: 1, delay: duration, remove: false)
        
        // move rigth
        let offSet: CGFloat = 20
        controlTextLableLending?.constant -= offSet
        view.layoutIfNeeded()
        
        controlTextLableLending?.constant += offSet
        UIView.animate(withDuration: duration * 2, delay: 0, options: .curveEaseOut, animations: {
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
}

// MARK: actions

extension ImageDetailViewController {
    
    @objc func backButtonHandler() {
        popViewController()
    }
}
