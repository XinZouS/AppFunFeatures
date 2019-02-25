//
//  MainViewController.swift
//  CoreDataSetup
//
//  Created by Xin Zou on 11/26/18.
//  Copyright © 2018 Xin Zou. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    let persistenceManager: PersistenceManager = PersistenceManager.shared
    
    // for coredata
    var users: [User] = []
    
    // for advance animations
    let imageView = UIImageView()
    let slider = UISlider()
    let visualView = UIVisualEffectView(effect: nil)
    let animator = UIViewPropertyAnimator(duration: 0.5, curve: .linear)
    
    // for different cases
    let fbLikeTappingPageButton = UIButton()
    let caDisplayLinkButton = UIButton()
    let chatBubblePageButton = UIButton()
    let stretchyPageButton = UIButton()
    let animateTransPageButton = UIButton()
    let previewTransitPageButton = UIButton()
    
    let margin: CGFloat = 20
    let btnHeigh: CGFloat = 50
    
    
    // MARK: - view cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        
//        createUser()
//        getUsers()
//
//        let updateDeadLine = DispatchTime.now() + .seconds(3)
//        DispatchQueue.main.asyncAfter(deadline: updateDeadLine, execute: deleteUser)
        
        setupImageView()
        setupVisualEffectView()
        setupSlider()
        setupAnimator()
        
        // custom demos
        setupNavigationButtons()
    }
    
    fileprivate func setupButtonUI(_ btn: UIButton, title: String, titleColor: UIColor, backgroundColor: UIColor) {
        let atts = [
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16),
            NSAttributedString.Key.foregroundColor: titleColor
        ]
        let attStr = NSAttributedString(string: title, attributes: atts)
        btn.setAttributedTitle(attStr, for: .normal)
        btn.backgroundColor = backgroundColor
        btn.layer.cornerRadius = 10
        btn.clipsToBounds = true
    }
}

// CoreData
extension MainViewController {
    
    func createUser() {
        let user = User(context: persistenceManager.context)
        user.name = "user04"
        
        persistenceManager.save()
    }
    
    func getUsers() {
        let user = persistenceManager.fetch(User.self)
        users = user
        users.forEach({ print($0.name) })
    }

    func updateUsers() {
        if let firstUser = users.first {
            firstUser.name += " - Updated user!!!"
            persistenceManager.save()
            print("---- updated ----")
            users.forEach({ print($0.name) })
        }
    }
    
    func deleteUser() {
        if let firstUser = users.first {
            persistenceManager.delete(firstUser)
            print("---- Deleted ----")
            getUsers()
        }
    }
    
}


/// for Advanced Animations
extension MainViewController {
    
    fileprivate func setupImageView() {
        self.view.addSubview(imageView)
        imageView.anchorCenterIn(self.view, width: 200, height: 200)
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = #imageLiteral(resourceName: "567-1")
    }
    
    fileprivate func setupVisualEffectView() {
        self.view.addSubview(visualView)
        visualView.fillSuperview()
    }
    
    fileprivate func setupSlider() {
        self.view.addSubview(slider)
        slider.addTarget(self, action: #selector(sliderDidChanged), for: .valueChanged)
        slider.anchor(left: imageView.leftAnchor, top: imageView.bottomAnchor, right: imageView.rightAnchor, bottom: nil, leftConstent: 0, topConstent: 10, rightConstent: 0, bottomConstent: 0, width: 0, height: 0)
    }

    @objc fileprivate func sliderDidChanged(sld: UISlider) {
        print(sld.value)
        animator.fractionComplete = CGFloat(sld.value)
    }
    
    fileprivate func setupAnimator() {
        animator.addAnimations {
            // completed animation state
            self.imageView.transform = CGAffineTransform(scaleX: 4, y: 4)
            self.visualView.effect = UIBlurEffect(style: .light)
        }
    }
    
    fileprivate func setupNavigationButtons() {
        setupFbLikePageButton()
        setupCaDisplayLinkButton()
        setupChatBubblePageButton()
        setupStretchyCollectionButton()
        setupAnimateTransitButton()
        setupPreviewTransitButton()
    }
    
    //MARK: - Fb Animation
    private func setupFbLikePageButton() {
        fbLikeTappingPageButton.addTarget(self, action: #selector(fbLikeTapped), for: .touchUpInside)
        setupButtonUI(fbLikeTappingPageButton, title: "Go fb-like tapping page", titleColor: UIColor.blue, backgroundColor: #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1))
        
        self.view.addSubview(fbLikeTappingPageButton)
        let vs = view.safeAreaLayoutGuide
        fbLikeTappingPageButton.anchor(left: vs.leftAnchor, top: nil, right: vs.rightAnchor, bottom: vs.bottomAnchor, leftConstent: margin, topConstent: 0, rightConstent: margin, bottomConstent: 30, width: 0, height: btnHeigh)
    }
    
    @objc private func fbLikeTapped() {
        let fbLikeAnimationVC = FbLikeAnimationViewController()
        self.navigationController?.pushViewController(fbLikeAnimationVC, animated: true)
    }
    
    //MARK: - CADisplayLink
    private func setupCaDisplayLinkButton() {
        caDisplayLinkButton.addTarget(self, action: #selector(caDisplayTapped), for: .touchUpInside)
        setupButtonUI(caDisplayLinkButton, title: "Go CADisplayLink page", titleColor: UIColor.orange, backgroundColor: #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1))
        
        self.view.addSubview(caDisplayLinkButton)
        let vs = view.safeAreaLayoutGuide
        caDisplayLinkButton.anchor(left: vs.leftAnchor, top: nil, right: vs.rightAnchor, bottom: fbLikeTappingPageButton.topAnchor, leftConstent: margin, topConstent: 0, rightConstent: margin, bottomConstent: 10, width: 0, height: btnHeigh)
    }
    
    @objc private func caDisplayTapped() {
        let caVC = CADisplayLinkViewController()
        self.navigationController?.pushViewController(caVC, animated: true)
    }
    
    //MARK: - Chat bubble tableView
    private func setupChatBubblePageButton() {
        chatBubblePageButton.addTarget(self, action: #selector(chatBubbleButtonTapped), for: .touchUpInside)
        setupButtonUI(chatBubblePageButton, title: "Go Chat Bubble Page", titleColor: #colorLiteral(red: 0.01436066254, green: 0.579015544, blue: 0.07654116112, alpha: 1), backgroundColor:  #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1))
        
        let vs = view.safeAreaLayoutGuide
        self.view.addSubview(chatBubblePageButton)
        chatBubblePageButton.anchor(left: vs.leftAnchor, top: vs.topAnchor, right: vs.rightAnchor, bottom: nil, leftConstent: margin, topConstent: margin, rightConstent: margin, bottomConstent: 0, width: 0, height: btnHeigh)
    }
    
    @objc private func chatBubbleButtonTapped() {
        let cv = ChatBubbleTableViewController()
        self.navigationController?.pushViewController(cv, animated: true)
    }
    
    //MARK: - Stretchy Collection View
    private func setupStretchyCollectionButton() {
        stretchyPageButton.addTarget(self, action: #selector(stretchButtonTapped), for: .touchUpInside)
        setupButtonUI(stretchyPageButton, title: "Go Stretchy Collection View", titleColor: #colorLiteral(red: 0.1787040276, green: 0.7140341645, blue: 0.6097396378, alpha: 1), backgroundColor: #colorLiteral(red: 0.7873243414, green: 0.9747681341, blue: 1, alpha: 1))
        
        let vs = view.safeAreaLayoutGuide
        self.view.addSubview(stretchyPageButton)
        stretchyPageButton.anchor(left: vs.leftAnchor, top: chatBubblePageButton.bottomAnchor, right: vs.rightAnchor, bottom: nil, leftConstent: margin, topConstent: 10, rightConstent: margin, bottomConstent: 0, width: 0, height: btnHeigh)
    }
    
    @objc private func stretchButtonTapped() {
        let vc = StretchyCollectionViewController(collectionViewLayout: StretchyHeaderLayout())
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    //MARK: - Animate Trnasition
    private func setupAnimateTransitButton() {
        animateTransPageButton.addTarget(self, action: #selector(animateTransitButtonTapped), for: .touchUpInside)
        setupButtonUI(animateTransPageButton, title: "Animate Image Transition View", titleColor:  #colorLiteral(red: 0.5083335309, green: 0.3633212509, blue: 0.8074603303, alpha: 1), backgroundColor:  #colorLiteral(red: 0.7985388885, green: 0.8489709422, blue: 1, alpha: 1))
        
        let vs = view.safeAreaLayoutGuide
        self.view.addSubview(animateTransPageButton)
        animateTransPageButton.anchor(left: vs.leftAnchor, top: stretchyPageButton.bottomAnchor, right: vs.rightAnchor, bottom: nil, leftConstent: margin, topConstent: 10, rightConstent: margin, bottomConstent: 0, width: 0, height: btnHeigh)
    }
    
    @objc private func animateTransitButtonTapped() {
        let vc = AnimateTransitBaseViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    //MARK: - PreviewTransition
    
    private func setupPreviewTransitButton() {
        previewTransitPageButton.addTarget(self, action: #selector(previewTransitTapped), for: .touchUpInside)
    }
    
    @objc private func previewTransitTapped() {
        let vc = TableViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
}








//
//  UIView++.swift
//  carryonex
//
//  Created by Xin Zou on 8/8/17.
//  Copyright © 2017 CarryonEx. All rights reserved.
//

import UIKit


extension UIView{
    
    func anchor(left: NSLayoutXAxisAnchor? = nil, top: NSLayoutYAxisAnchor? = nil, right: NSLayoutXAxisAnchor? = nil, bottom: NSLayoutYAxisAnchor? = nil, leftConstent: CGFloat? = 0, topConstent: CGFloat? = 0, rightConstent: CGFloat? = 0, bottomConstent: CGFloat? = 0, width: CGFloat? = 0, height: CGFloat? = 0) {
        
        var anchors = [NSLayoutConstraint]()
        self.translatesAutoresizingMaskIntoConstraints = false
        
        if left != nil {
            anchors.append(leftAnchor.constraint(equalTo: left!, constant: leftConstent!))
        }
        if top != nil {
            anchors.append(topAnchor.constraint(equalTo: top!, constant: topConstent!))
        }
        if right != nil {
            anchors.append(rightAnchor.constraint(equalTo: right!, constant: -rightConstent!))
        }
        if bottom != nil {
            anchors.append(bottomAnchor.constraint(equalTo: bottom!, constant: -bottomConstent!))
        }
        if let width = width, width > CGFloat(0) {
            anchors.append(widthAnchor.constraint(equalToConstant: width))
        }
        if let height = height, height > CGFloat(0) {
            anchors.append(heightAnchor.constraint(equalToConstant: height))
        }
        
        for anchor in anchors {
            anchor.isActive = true
        }
    }
    
    func anchorCenterIn(_ containerView: UIView?, width: CGFloat, height: CGFloat, offsetX: CGFloat = 0, offsetY: CGFloat = 0) {
        guard let cv = containerView else { return }
        self.translatesAutoresizingMaskIntoConstraints = false
        
        centerXAnchor.constraint(equalTo: cv.centerXAnchor, constant: offsetX).isActive = true
        centerYAnchor.constraint(equalTo: cv.centerYAnchor, constant: offsetY).isActive = true
        widthAnchor.constraint(equalToConstant: width).isActive = true
        heightAnchor.constraint(equalToConstant: height).isActive = true
    }
    
    func fillSuperview(padding: UIEdgeInsets = .zero) {
        guard let sv = self.superview else { return }
        self.translatesAutoresizingMaskIntoConstraints = false
        
        leftAnchor.constraint(equalTo: sv.leftAnchor, constant: padding.left).isActive = true
        topAnchor.constraint(equalTo: sv.topAnchor, constant: padding.top).isActive = true
        rightAnchor.constraint(equalTo: sv.rightAnchor, constant: -padding.right).isActive = true
        bottomAnchor.constraint(equalTo: sv.bottomAnchor, constant: -padding.bottom).isActive = true
    }
    
    func drawStroke(startPoint: CGPoint, endPoint: CGPoint, color: UIColor, lineWidth: CGFloat) {
        let aPath = UIBezierPath()
        aPath.move(to: startPoint)
        aPath.addLine(to: endPoint)
        
        let lineLayer = CAShapeLayer()
        lineLayer.path = aPath.cgPath
        lineLayer.strokeColor = color.cgColor
        lineLayer.lineWidth = lineWidth
        lineLayer.lineJoin = CAShapeLayerLineJoin.round
        
        layer.addSublayer(lineLayer)
    }
}



