//
//  ChatBubbleTableViewController.swift
//  CoreDataSetup
//
//  Created by Xin Zou on 12/13/18.
//  Copyright © 2018 Xin Zou. All rights reserved.
//

import UIKit


struct ChatMessage {
    let text: String
    let isIncoming: Bool
    let date: Date
    
    init(_ text: String, _ isIncome: Bool, _ date: Date) {
        self.text = text
        isIncoming = isIncome
        self.date = date
    }
}

extension Date {
    static func fromString(_ customString: String) -> Date {
        let formater = DateFormatter()
        formater.dateFormat = "MM/dd/yyyy"
        return formater.date(from: customString) ?? Date()
    }
}

class ChatBubbleTableViewController: UITableViewController {
    
    let cellId = "cellId"
    
    var textMessages: [[ChatMessage]] = []
    
    let msgFromServer = [
        ChatMessage("1.一个完不成任务的刺客，却赢得了口碑，这个刺客不太冷《刺客伍六七》", true, Date.fromString("7/14/2018")),
        ChatMessage("2.也许这个时候再来写刺客伍六七有点晚了，有点炒的意味", false, Date.fromString("7/14/2018")),
        ChatMessage("3.可我真的要给个五星好评，一定给这部国漫写一段长评。", false, Date.fromString("7/14/2018")),
        
        ChatMessage("4.\"我今日就要写代码\"", true, Date.fromString("8/15/2018")),
        ChatMessage("5.我睇下边个够胆拦我", true, Date.fromString("8/15/2018")),
        ChatMessage("6.这部国漫给我最直观的感受就是——穷。虽然开篇以一段帅气的打斗戏开场，从开场看，阿七是一位很牛气的刺客，只为金钱和客户服务", false, Date.fromString("8/15/2018")),
        ChatMessage("7.从这点看，阿七如果是刺客，绝对是个实力和职业素养贼强的刺客。", false, Date.fromString("8/15/2018")),
        ChatMessage("8.1.人物的形象  阿七是主角是个刺客，更是社会的见证者。他看到了很多故事见到了许多人", true, Date.fromString("8/15/2018")),
        ChatMessage("8.2.阿七的两个伙伴——两只鸡；大叔的不被接受和不被理解；猫狗之间被现实隔断的爱情", false, Date.fromString("8/15/2018")),
        
        ChatMessage("9.然而这些画面有着简约到不能再简约的画风", true, Date.fromString("9/16/2018")),
        ChatMessage("10.令人卡心的帧数", false, Date.fromString("9/16/2018")),
        ChatMessage("11.我不禁疑问，这部国漫是怎么获得如此好评的？", false, Date.fromString("9/16/2018")),
        
        ChatMessage("12.我百度了一下这部国漫，不是特别上档次的制作组，没有特别充足的经费，就是这样的条件，它却成为法国动漫节唯一部得到提名完全由中国制作的动漫。慕其盛名，决定补一补！", true, Date.fromString("12/17/2018")),
    ]
    
    private func assembleGroupedMessages() {
        let groupDictionary = Dictionary(grouping: msgFromServer) { (element) -> Date in
            return element.date
        }
        let sortedKeys = groupDictionary.keys.sorted()
        sortedKeys.forEach { (dateKey) in
            textMessages.append(groupDictionary[dateKey] ?? [])
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        assembleGroupedMessages()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Messages"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        tableView.register(ChatBubbleTableCell.self, forCellReuseIdentifier: cellId)
        tableView.backgroundColor = UIColor(white: 0.96, alpha: 1)
        tableView.separatorStyle = .none
    }
    
    
}

extension ChatBubbleTableViewController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return textMessages.count
    }
    
//    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        if let d = textMessages[section].first?.date {
//            let formater = DateFormatter()
//            formater.dateFormat = "MM/dd/yyyy"
//            return formater.string(from: d)
//        }
//        return "Last messages"
//    }
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let d = textMessages[section].first?.date else { return nil }
        
        let formater = DateFormatter()
        formater.dateFormat = "MM/dd/yyyy"
        
        let lb = UILabel()
        lb.backgroundColor = #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)
        lb.textColor = .blue
        lb.textAlignment = .center
        lb.text = formater.string(from: d)
        lb.font = UIFont.boldSystemFont(ofSize: 14)
        let lbH = lb.intrinsicContentSize.height + 12
        lb.heightAnchor.constraint(equalToConstant: lbH).isActive = true
        lb.widthAnchor.constraint(equalToConstant: lb.intrinsicContentSize.width + 26).isActive = true
        lb.layer.cornerRadius = lbH / 2
        lb.layer.masksToBounds = true
        
        let containerView = UIView()
        containerView.addSubview(lb)
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
        lb.centerYAnchor.constraint(equalTo: containerView.centerYAnchor, constant: 6).isActive = true
        
        return containerView
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return textMessages[section].count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as? ChatBubbleTableCell else {
            return UITableViewCell()
        }
        cell.selectionStyle = .none
        if indexPath.row < textMessages[indexPath.section].count {
            cell.chatMessage = textMessages[indexPath.section][indexPath.row]
        }
        return cell
    }
    
}

class ChatBubbleTableCell: UITableViewCell {
    
    let backgroundColorView = UIView()
    let messageLabel = UILabel()
    
    var leadingConstraint: NSLayoutConstraint?
    var trailingConstraing: NSLayoutConstraint?
    
    var chatMessage: ChatMessage? {
        didSet {
            guard let msg = chatMessage else { return }
            updateCellFor(msg)
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        self.backgroundColor = .clear
        setupMessageLabel()
    }
    
    
    private func updateCellFor(_ msg: ChatMessage) {
        backgroundColorView.backgroundColor = msg.isIncoming ? #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0) : #colorLiteral(red: 0.09350001747, green: 0.7586018459, blue: 0.1113215755, alpha: 1)
        messageLabel.textColor = msg.isIncoming ? UIColor.black : UIColor.white
        messageLabel.text = msg.text
        leadingConstraint?.isActive = msg.isIncoming
        trailingConstraing?.isActive = !msg.isIncoming
    }
    
    private func setupMessageLabel() {
        backgroundColorView.layer.cornerRadius = 10
        backgroundColorView.layer.masksToBounds = true
        addSubview(backgroundColorView)
        
        messageLabel.numberOfLines = 0
        let padding: CGFloat = 26
        addSubview(messageLabel)
        messageLabel.anchor(top: topAnchor, bottom: bottomAnchor, topConstent: padding, bottomConstent: padding)
        messageLabel.widthAnchor.constraint(lessThanOrEqualToConstant: self.bounds.width * 0.8).isActive = true
        leadingConstraint = messageLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding)
        trailingConstraing = messageLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding)
        
        let margin: CGFloat = -10
        backgroundColorView.anchor(left: messageLabel.leftAnchor, top: messageLabel.topAnchor, right: messageLabel.rightAnchor, bottom: messageLabel.bottomAnchor, leftConstent: margin, topConstent: margin, rightConstent: margin, bottomConstent: margin, width: 0, height: 0)

    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        leadingConstraint?.isActive = false
        trailingConstraing?.isActive = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
