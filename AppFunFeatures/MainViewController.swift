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
    
    let scrollView = UIScrollView()
    
    // for different cases
    let fbLikeTappingPageButton = UIButton()
    let caDisplayLinkButton = UIButton()
    let chatBubblePageButton = UIButton()
    let stretchyPageButton = UIButton()
    let animateTransPageButton = UIButton()
    let previewTransitPageButton = UIButton()
    
    let margin: CGFloat = 20
    let btnHeigh: CGFloat = 50
    var btnWidth: CGFloat = 160
    
    
    // MARK: - view cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        btnWidth = view.bounds.width - (margin * 2)
        
//        createUser()
//        getUsers()
//
//        let updateDeadLine = DispatchTime.now() + .seconds(3)
//        DispatchQueue.main.asyncAfter(deadline: updateDeadLine, execute: deleteUser)
        
        // custom demos
        setupScrollView()
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
    
    fileprivate func setupScrollView() {
        view.addSubview(scrollView)
        scrollView.fillSuperview()
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
        
        scrollView.addSubview(fbLikeTappingPageButton)
        fbLikeTappingPageButton.anchor(left: scrollView.leftAnchor, top: scrollView.topAnchor, right: scrollView.rightAnchor, bottom: nil, leftConstent: margin, topConstent: margin, rightConstent: margin, bottomConstent: 0, width: btnWidth, height: btnHeigh)
    }
    
    @objc private func fbLikeTapped() {
        let fbLikeAnimationVC = FbLikeAnimationViewController()
        self.navigationController?.pushViewController(fbLikeAnimationVC, animated: true)
    }
    
    
    //MARK: - CADisplayLink
    
    private func setupCaDisplayLinkButton() {
        caDisplayLinkButton.addTarget(self, action: #selector(caDisplayTapped), for: .touchUpInside)
        setupButtonUI(caDisplayLinkButton, title: "Go CADisplayLink page", titleColor: UIColor.orange, backgroundColor: #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1))
        
        scrollView.addSubview(caDisplayLinkButton)
        caDisplayLinkButton.anchor(left: fbLikeTappingPageButton.leftAnchor, top: fbLikeTappingPageButton.bottomAnchor, right: fbLikeTappingPageButton.rightAnchor, bottom: nil, width: 0, height: btnHeigh)
    }
    
    @objc private func caDisplayTapped() {
        let caVC = CADisplayLinkViewController()
        self.navigationController?.pushViewController(caVC, animated: true)
    }
    
    
    //MARK: - Chat bubble tableView
    
    private func setupChatBubblePageButton() {
        chatBubblePageButton.addTarget(self, action: #selector(chatBubbleButtonTapped), for: .touchUpInside)
        setupButtonUI(chatBubblePageButton, title: "Go Chat Bubble Page", titleColor: #colorLiteral(red: 0.01436066254, green: 0.579015544, blue: 0.07654116112, alpha: 1), backgroundColor:  #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1))
        
        scrollView.addSubview(chatBubblePageButton)
        chatBubblePageButton.anchor(left: fbLikeTappingPageButton.leftAnchor, top: caDisplayLinkButton.bottomAnchor, right: fbLikeTappingPageButton.rightAnchor, bottom: nil, width: 0, height: btnHeigh)
    }
    
    @objc private func chatBubbleButtonTapped() {
        let cv = ChatBubbleTableViewController()
        self.navigationController?.pushViewController(cv, animated: true)
    }
    
    
    //MARK: - Stretchy Collection View
    
    private func setupStretchyCollectionButton() {
        stretchyPageButton.addTarget(self, action: #selector(stretchButtonTapped), for: .touchUpInside)
        setupButtonUI(stretchyPageButton, title: "Go Stretchy Collection View", titleColor: #colorLiteral(red: 0.1787040276, green: 0.7140341645, blue: 0.6097396378, alpha: 1), backgroundColor: #colorLiteral(red: 0.7873243414, green: 0.9747681341, blue: 1, alpha: 1))
        
        scrollView.addSubview(stretchyPageButton)
        stretchyPageButton.anchor(left: fbLikeTappingPageButton.leftAnchor, top: chatBubblePageButton.bottomAnchor, right: fbLikeTappingPageButton.rightAnchor, bottom: nil, width: 0, height: btnHeigh)
    }
    
    @objc private func stretchButtonTapped() {
        let vc = StretchyCollectionViewController(collectionViewLayout: StretchyHeaderLayout())
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    //MARK: - Animate Trnasition
    
    private func setupAnimateTransitButton() {
        animateTransPageButton.addTarget(self, action: #selector(animateTransitButtonTapped), for: .touchUpInside)
        setupButtonUI(animateTransPageButton, title: "Animate Image Transition View", titleColor:  #colorLiteral(red: 0.5083335309, green: 0.3633212509, blue: 0.8074603303, alpha: 1), backgroundColor:  #colorLiteral(red: 0.7985388885, green: 0.8489709422, blue: 1, alpha: 1))
        
        scrollView.addSubview(animateTransPageButton)
        animateTransPageButton.anchor(left: fbLikeTappingPageButton.leftAnchor, top: stretchyPageButton.bottomAnchor, right: fbLikeTappingPageButton.rightAnchor, bottom: nil, width: 0, height: btnHeigh)
    }
    
    @objc private func animateTransitButtonTapped() {
        let vc = AnimateTransitBaseViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    //MARK: - PreviewTransition
    
    private func setupPreviewTransitButton() {
        previewTransitPageButton.addTarget(self, action: #selector(previewTransitTapped), for: .touchUpInside)
        setupButtonUI(previewTransitPageButton, title: "Preview Transit TableVC", titleColor:  #colorLiteral(red: 0.6615448133, green: 0.3673118929, blue: 0.8074603303, alpha: 1), backgroundColor:  #colorLiteral(red: 0.8897443573, green: 0.820095919, blue: 1, alpha: 1))
        
        scrollView.addSubview(previewTransitPageButton)
        previewTransitPageButton.anchor(left: fbLikeTappingPageButton.leftAnchor, top: animateTransPageButton.bottomAnchor, right: fbLikeTappingPageButton.rightAnchor, bottom: nil, width: 0, height: btnHeigh)
    }
    
    @objc private func previewTransitTapped() {
        let vc = ImagesTableViewController()
        let nav = UINavigationController(rootViewController: vc)
        self.present(nav, animated: true, completion: nil)
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



