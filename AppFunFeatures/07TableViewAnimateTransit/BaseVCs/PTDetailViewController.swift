//
//  PTDetailViewController.swift
//  AppFunFeautres
//
//  Created by Xin Zou on 2/24/19.
//  Copyright © 2019 Xin Zou. All rights reserved.
//

import UIKit

/// Base UIViewController for preview transition
open class PTDetailViewController: UIViewController {
    
    var bgImage: UIImage?
    var titleText: String?
    
    /// 图片允许的最大放大倍率
    open var imageMaximumZoomScale: CGFloat = 6.0
    
    /// 单击时回调
    open var clickCallback: ((UITapGestureRecognizer) -> Void)?
    
    /// 长按时回调
    open var longPressedCallback: ((UILongPressGestureRecognizer) -> Void)?
    
    /// 图片拖动时回调
    open var panChangedCallback: ((_ scale: CGFloat) -> Void)?
    
    /// 记录pan手势开始时imageView的位置
    private var beganFrame = CGRect.zero
    
    /// 记录pan手势开始时，手势位置
    private var beganTouch = CGPoint.zero
    
    
    fileprivate let imageContainer = UIScrollView()
    fileprivate let backgroundImageView = UIImageView()
}

// MARK: life cicle
extension PTDetailViewController {
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        
        setupScrollView()
        createBackgroundImage(bgImage)
        setupGestureRecognizers()
        view.backgroundColor = .black
        
        if let titleText = self.titleText {
            title = titleText
        }
        
        // hack
        if let navigationController = self.navigationController {
            for case let label as UILabel in navigationController.view.subviews {
                label.isHidden = true
            }
        }
        
        createNavBar(UIColor(red: 0, green: 0, blue: 0, alpha: 0.5))
        
        layoutInitSubviews()
    }
    
    private func layoutInitSubviews() {
        imageContainer.frame = view.frame
        imageContainer.setZoomScale(1.0, animated: false)
        backgroundImageView.frame = fillFrame
        imageContainer.setZoomScale(1.0, animated: true)
    }
    
}

// MARK: public
extension PTDetailViewController {
    
    /**
     Pops the top view controller from the navigation stack and updates the display with custom animation.
     */
    public func popViewController() {
        
        if let navigationController = self.navigationController {
            for case let label as UILabel in navigationController.view.subviews {
                label.isHidden = false
            }
        }
        _ = navigationController?.popViewController(animated: false)
    }
}

// MARK: create
extension PTDetailViewController {
    
    fileprivate func setupScrollView() {
        imageContainer.delegate = self
        view.addSubview(imageContainer)
        imageContainer.fillSuperview()
        imageContainer.maximumZoomScale = imageMaximumZoomScale
        imageContainer.delegate = self
        imageContainer.showsVerticalScrollIndicator = false
        imageContainer.showsHorizontalScrollIndicator = false
        if #available(iOS 11.0, *) {
            imageContainer.contentInsetAdjustmentBehavior = .never
        }
    }
    
    fileprivate func createBackgroundImage(_ image: UIImage?) {
        guard let image = image else { return }
        backgroundImageView.image = image
        let viewH = UIScreen.main.bounds.height
        let imgH = viewH
        let imgW = (image.size.width / image.size.height) * imgH
        backgroundImageView.frame = CGRect(x: 0, y: 0, width: imgW, height: imgH)
        backgroundImageView.center = view.center
        backgroundImageView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        backgroundImageView.contentMode = .scaleAspectFit
        imageContainer.addSubview(backgroundImageView)
        backgroundImageView.clipsToBounds = true
    }
    
    fileprivate func setupGestureRecognizers() {
        // 长按手势
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(onLongPress(_:)))
        view.addGestureRecognizer(longPress)

        // 双击手势
        let doubleTap = UITapGestureRecognizer(target: self, action: #selector(onDoubleClick(_:)))
        doubleTap.numberOfTapsRequired = 2
        view.addGestureRecognizer(doubleTap)
        
        // 单击手势
        let singleTap = UITapGestureRecognizer(target: self, action: #selector(onClick(_:)))
        view.addGestureRecognizer(singleTap)
        singleTap.require(toFail: doubleTap)
    }
    
    fileprivate func createNavBar(_ color: UIColor) {
        let navBar = UIView(frame: CGRect.zero)
        navBar.backgroundColor = color
        navBar.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(navBar)
        
        for attributes: NSLayoutConstraint.Attribute in [.left, .right, .top] {
            (view, navBar) >>>- {
                $0.attribute = attributes
                return
            }
        }
        navBar >>>- {
            $0.attribute = .height
            var constant: CGFloat = 64
            if #available(iOS 11.0, *) {
                if let topPadding = UIApplication.shared.keyWindow?.safeAreaInsets.top {
                    constant += topPadding
                }
            }
            $0.constant = constant
            return
        }
    }
}

//
// MARK: - UI Gestures
//

extension PTDetailViewController {
    
    /// 响应单击
    @objc private func onClick(_ tap: UITapGestureRecognizer) {
        clickCallback?(tap)
    }
    
    /// 响应双击
    @objc private func onDoubleClick(_ tap: UITapGestureRecognizer) {
        // 如果当前没有任何缩放，则放大到目标比例，否则重置到原比例
        if imageContainer.zoomScale == 1.0 {
            // 以点击的位置为中心，放大
            let pointInView = tap.location(in: backgroundImageView)
            let width = imageContainer.bounds.size.width / imageContainer.maximumZoomScale
            let height = imageContainer.bounds.size.height / imageContainer.maximumZoomScale
            let x = pointInView.x - (width / 2.0)
            let y = pointInView.y - (height / 2.0)
            imageContainer.zoom(to: CGRect(x: x, y: y, width: width, height: height), animated: true)
        } else {
            imageContainer.setZoomScale(1.0, animated: true)
        }
    }
    
    /// 响应长按
    @objc private func onLongPress(_ press: UILongPressGestureRecognizer) {
        if press.state == .began {
            longPressedCallback?(press)
        }
    }
    
}


//
// MARK: - UIScrollViewDelegate
//

extension PTDetailViewController: UIScrollViewDelegate {
    public func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return backgroundImageView
    }
    
    public func scrollViewDidZoom(_ scrollView: UIScrollView) {
        backgroundImageView.center = resettingCenter
    }
    
    /// 计算图片复位坐标
    private var resettingCenter: CGPoint {
        let deltaWidth = view.bounds.width - imageContainer.contentSize.width
        let offsetX = deltaWidth > 0 ? deltaWidth * 0.5 : 0
        let deltaHeight = view.bounds.height - imageContainer.contentSize.height
        let offsetY = deltaHeight > 0 ? deltaHeight * 0.5 : 0
        return CGPoint(x: imageContainer.contentSize.width * 0.5 + offsetX,
                       y: imageContainer.contentSize.height * 0.5 + offsetY)
    }
    
    private var fillSize: CGSize {
        guard let image = backgroundImageView.image else {
            return CGSize.zero
        }
        var imgW: CGFloat
        var imgH: CGFloat
        if imageContainer.bounds.width < imageContainer.bounds.height {
            // portrait
            imgH = imageContainer.bounds.height
            imgW = (image.size.width / image.size.height) * imgH
        } else {
            // landscape
            imgW = imageContainer.bounds.width
            imgH = (image.size.height / image.size.width) * imgW
        }
        return CGSize(width: imgW, height: imgH)
    }
    
    private var fillFrame: CGRect {
        let size = fillSize
        let x = imageContainer.bounds.width < size.width ? (imageContainer.bounds.width - size.width) * 0.5 : 0
        let y = imageContainer.bounds.height < size.height ? (imageContainer.bounds.height - size.height) * 0.5 :0
        return CGRect(x: x, y: y, width: size.width, height: size.height)
    }
    
}

