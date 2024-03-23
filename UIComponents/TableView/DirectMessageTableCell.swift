//
//  DirectMessageTableView.swift
//  UIComponents
//
//  Created by Tomo Kikuchi on 2024/03/18.
//

import Foundation
import UIKit

public enum DirectMessageCellUserType{
    case me
    case other
}

public protocol DirectMessageCellDataframe{
    var userName: String { get }
    var receivedAt: Date { get }
    var userType: DirectMessageCellUserType { get }
    var userIcon: UIImage? { get }
    var body: String { get }
}

public class DirectMessageTableCell<Dataframe: DirectMessageCellDataframe>: UITableViewCell{
    private var content: Dataframe? = nil
    
    private lazy var userNameLabel: UILabel = generateLabel()
    private lazy var datetimeLabel: UILabel = generateLabel()
    private lazy var bodyLabel: UILabel = generateLabel()
    private lazy var userIconView: UIImageView = generateImageView()
    private lazy var bodyBackView: UIView = generateView()
    private var bodyGuide: UILayoutGuide = UILayoutGuide()
    private var layouts: [NSLayoutConstraint] = []
    
    public init(reuseIdentifier: String){
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        self.configViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func updateContent(content: Dataframe){
        self.content = content
        
        // Set context
        self.bodyLabel.text = content.body
        self.userNameLabel.text = content.userName
        
        // Get local time
        let df = DateFormatter()
        df.timeStyle = .short
        df.dateStyle = .full
        df.locale = Locale(identifier: "ja_JP")
        
        self.datetimeLabel.text = df.string(from: content.receivedAt)
        
        // Set user icon
        if let image = content.userIcon{       
            self.userIconView.image = image
        }else{
            let image = UIImage.Messages.NoImageUser
            userIconView.image = image.withRenderingMode(.alwaysTemplate)
            userIconView.tintColor = .gray
        }
        
        self.layoutViews()
    }
}

extension DirectMessageTableCell{
    func generateLabel() -> UILabel{
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }
    
    func generateView() -> UIView{
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }
    
    func generateImageView() -> UIImageView{
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }
    
    func layoutViews(){
        NSLayoutConstraint.deactivate(layouts)
        
        guard let content = self.content else { return }
        
        let newLayouts: [NSLayoutConstraint]
        // TODO: 外だし
        switch(content.userType){
        case .other:
            newLayouts = [
                self.userIconView.topAnchor.constraint(equalTo: self.topAnchor, constant: 12),
                self.userIconView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 12),
                self.userIconView.heightAnchor.constraint(equalToConstant: 36),
                self.userIconView.widthAnchor.constraint(equalToConstant: 36),
                            
                self.bodyGuide.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.7),
                self.bodyGuide.leftAnchor.constraint(equalTo: self.userIconView.rightAnchor, constant: 12),
                self.bodyGuide.topAnchor.constraint(equalTo: self.userIconView.centerYAnchor, constant: 0),
                
                self.userNameLabel.bottomAnchor.constraint(equalTo: self.bodyGuide.topAnchor, constant: -4),
                self.userNameLabel.leftAnchor.constraint(equalTo: self.userIconView.rightAnchor, constant: 12),

                self.datetimeLabel.bottomAnchor.constraint(equalTo: self.userNameLabel.bottomAnchor),
                self.datetimeLabel.leftAnchor.constraint(equalTo: self.userNameLabel.rightAnchor, constant: 4),
                
                self.bodyBackView.centerXAnchor.constraint(equalTo: self.bodyGuide.centerXAnchor),
                self.bodyBackView.centerYAnchor.constraint(equalTo: self.bodyGuide.centerYAnchor),
                self.bodyBackView.widthAnchor.constraint(equalTo: self.bodyGuide.widthAnchor),
                self.bodyBackView.heightAnchor.constraint(equalTo: self.bodyGuide.heightAnchor),

                self.bodyLabel.topAnchor.constraint(equalTo: self.bodyGuide.topAnchor, constant: 8),
                self.bodyLabel.leftAnchor.constraint(equalTo: self.bodyGuide.leftAnchor, constant: 12),
                self.bodyLabel.widthAnchor.constraint(equalTo: self.bodyGuide.widthAnchor, constant: -24),
                self.bodyLabel.bottomAnchor.constraint(equalTo: self.bodyGuide.bottomAnchor, constant: -8),
                
                self.bodyGuide.bottomAnchor.constraint(equalTo: self.bottomAnchor)
            ]

        case .me:
            newLayouts = [
                self.userIconView.topAnchor.constraint(equalTo: self.topAnchor, constant: 12),
                self.userIconView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -12),
                self.userIconView.heightAnchor.constraint(equalToConstant: 36),
                self.userIconView.widthAnchor.constraint(equalToConstant: 36),
                            
                self.bodyGuide.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.7),
                self.bodyGuide.rightAnchor.constraint(equalTo: self.userIconView.leftAnchor, constant: -12),
                self.bodyGuide.topAnchor.constraint(equalTo: self.userIconView.centerYAnchor, constant: 0),
                
                self.userNameLabel.bottomAnchor.constraint(equalTo: self.bodyGuide.topAnchor, constant: -4),
                self.userNameLabel.rightAnchor.constraint(equalTo: self.userIconView.leftAnchor, constant: -12),

                self.datetimeLabel.bottomAnchor.constraint(equalTo: self.userNameLabel.bottomAnchor),
                self.datetimeLabel.rightAnchor.constraint(equalTo: self.userNameLabel.leftAnchor, constant: -4),
                
                self.bodyBackView.centerXAnchor.constraint(equalTo: self.bodyGuide.centerXAnchor),
                self.bodyBackView.centerYAnchor.constraint(equalTo: self.bodyGuide.centerYAnchor),
                self.bodyBackView.widthAnchor.constraint(equalTo: self.bodyGuide.widthAnchor),
                self.bodyBackView.heightAnchor.constraint(equalTo: self.bodyGuide.heightAnchor),

                self.bodyLabel.topAnchor.constraint(equalTo: self.bodyGuide.topAnchor, constant: 8),
                self.bodyLabel.rightAnchor.constraint(equalTo: self.bodyGuide.rightAnchor, constant: -12),
                self.bodyLabel.widthAnchor.constraint(equalTo: self.bodyGuide.widthAnchor, constant: -24),
                self.bodyLabel.bottomAnchor.constraint(equalTo: self.bodyGuide.bottomAnchor, constant: -8),
                
                self.bodyGuide.bottomAnchor.constraint(equalTo: self.bottomAnchor)
            ]
        }
                
        NSLayoutConstraint.activate(newLayouts)
        layouts = newLayouts
    }
    
    func configViews(){
        self.selectionStyle = .none
        
        self.userNameLabel.font = .systemFont(ofSize: 12, weight: .regular)
        self.datetimeLabel.font = .systemFont(ofSize: 10, weight: .regular)
        self.bodyLabel.font = .systemFont(ofSize: 12, weight: .regular)
        
        self.userNameLabel.textColor = .black
        self.datetimeLabel.textColor = .gray
        self.bodyLabel.textColor = .black
        
        self.userNameLabel.numberOfLines = 1
        self.datetimeLabel.numberOfLines = 1
        self.bodyLabel.numberOfLines = 0
        
        self.userIconView.layer.masksToBounds = true
        self.userIconView.layer.cornerRadius = CGFloat(36.0 / 2.0)
        
        self.bodyLabel.textAlignment = .left
        self.bodyBackView.backgroundColor = UIColor.secondary
        self.bodyBackView.layer.masksToBounds = true
        self.bodyBackView.layer.cornerRadius = 8.0
        
        self.addSubview(userIconView)
        self.addSubview(userNameLabel)
        self.addSubview(datetimeLabel)
        self.addSubview(bodyBackView)
        self.addSubview(bodyLabel)
        self.addLayoutGuide(bodyGuide)
    }
}
