//
//  SupportListTableCell.swift
//  UIComponents
//
//  Created by Tomo Kikuchi on 2024/03/21.
//

import Foundation
import UIKit

public protocol SupportListTableViewDataframe{
    var imageURL: URL? { get }
    var companyName: String { get }
    var comment: String { get }
    var createdAt: Date { get }
    var reputationValue: Float { get }
}

public class SupportListTableCell<Dataframe: SupportListTableViewDataframe>: UITableViewCell{
    private var content: Dataframe?
    
    enum LabelStyle{
        case caption
        case title
        case body
        case date
        
        var font: UIFont{
            switch(self){
            case .caption:
                    UIFont.systemFont(ofSize: 9.0, weight: .regular)
            case .body:
                UIFont.systemFont(ofSize: 12.0, weight: .regular)
            case .date:
                UIFont.systemFont(ofSize: 12.0, weight: .regular)
            case .title:
                UIFont.systemFont(ofSize: 17.0, weight: .semibold)
            }
        }
        
        var textColor: UIColor{
            switch(self){
            case .caption, .body, .title:
                return .black
            case .date:
                return .gray
            }
        }
        
        var lineLimit: Int{
            switch(self){
            case .body:
                return 0
            case .date:
                return 1
            case .caption:
                return 3
            case .title:
                return 1
            }
        }
    }
    
    private lazy var companyLabel: UILabel = generateLabel(.title)
    private lazy var commentLabel: UILabel = generateLabel(.body)
    private lazy var datetimeLabel: UILabel = generateLabel(.date)
    private lazy var reputationLabel: UILabel = generateLabel(.caption)
    private lazy var cornerView: UIView = generateView()
    private lazy var reputationView: UIView = generateReputationView()
    private lazy var reputationStars: ReputationStarView = generateReputationStarView()
    private lazy var iconView: UIImageView = generateImageView()
    private var layouts: [NSLayoutConstraint] = []
    
    public init(reuseIdentifier: String){
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        configView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
       
    public func updateContent(content: Dataframe){
        self.content = content
        
        self.companyLabel.text = content.companyName
        self.commentLabel.text = content.comment
        
        self.reputationStars.setNeedsDisplay()
     
        let df = DateFormatter()
        df.timeStyle = .short
        df.dateStyle = .short
        df.locale = Locale(identifier: "ja_JP")
        
        self.datetimeLabel.text = df.string(from: content.createdAt)
        
        if let imageURL = content.imageURL{
            let image = UIImage(url: imageURL)
            self.iconView.image = image
        }else{
            let image = UIImage.Messages.NoImageUser
            iconView.image = image.withRenderingMode(.alwaysTemplate)
            iconView.tintColor = .gray
        }
        
        self.commentLabel.textAlignment = .left
        self.companyLabel.textAlignment = .left
        self.datetimeLabel.textAlignment = .right
        
        layoutViews()
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        guard let value = content?.reputationValue else { return }
        self.reputationStars.updateMaskLayers(value: value)
    }
    
    public func layoutViews(){
        NSLayoutConstraint.deactivate(layouts)
        
        self.layouts = [
            cornerView.topAnchor.constraint(equalTo: topAnchor, constant: 13),
            cornerView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -13),
            cornerView.widthAnchor.constraint(equalTo: widthAnchor),
            cornerView.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            iconView.topAnchor.constraint(equalTo: cornerView.topAnchor, constant: 16),
            iconView.leftAnchor.constraint(equalTo: cornerView.leftAnchor, constant: 17),
            iconView.heightAnchor.constraint(equalToConstant: 40),
            iconView.widthAnchor.constraint(equalToConstant: 40),
            
            companyLabel.topAnchor.constraint(equalTo: iconView.topAnchor),
            companyLabel.leftAnchor.constraint(equalTo: iconView.rightAnchor, constant: 8),
            
            datetimeLabel.topAnchor.constraint(equalTo: companyLabel.topAnchor),
            datetimeLabel.leftAnchor.constraint(equalTo: companyLabel.rightAnchor),
            datetimeLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -15),
            
            reputationView.topAnchor.constraint(equalTo: iconView.bottomAnchor, constant: 16),
            reputationView.centerXAnchor.constraint(equalTo: cornerView.centerXAnchor),
            reputationView.widthAnchor.constraint(equalTo: cornerView.widthAnchor, multiplier: 0.7),
            reputationView.heightAnchor.constraint(equalToConstant: 32),
            
            commentLabel.topAnchor.constraint(equalTo: reputationView.bottomAnchor, constant: 16),
            commentLabel.bottomAnchor.constraint(equalTo: cornerView.bottomAnchor, constant: -16),
            commentLabel.centerXAnchor.constraint(equalTo: cornerView.centerXAnchor),
            commentLabel.widthAnchor.constraint(equalTo: cornerView.widthAnchor, constant: -32),
            
            reputationLabel.centerYAnchor.constraint(equalTo: reputationView.centerYAnchor),
            reputationStars.centerYAnchor.constraint(equalTo: reputationView.centerYAnchor),
            
            reputationLabel.heightAnchor.constraint(equalTo: reputationView.heightAnchor),
            reputationStars.heightAnchor.constraint(equalTo: reputationView.heightAnchor),
            
            reputationLabel.leftAnchor.constraint(equalTo: reputationView.leftAnchor, constant: 15),
            reputationStars.rightAnchor.constraint(equalTo: reputationView.rightAnchor, constant: -15),

            reputationLabel.rightAnchor.constraint(equalTo: reputationStars.leftAnchor, constant: -15),
        ]
        
        NSLayoutConstraint.activate(layouts)
    }
    
    func configView(){
        self.addSubview(iconView)
        self.addSubview(datetimeLabel)
        self.addSubview(reputationView)
        self.addSubview(commentLabel)
        self.addSubview(companyLabel)
        self.addSubview(cornerView)
        self.reputationView.addSubview(reputationLabel)
        self.reputationView.addSubview(reputationStars)
        
        // Configs
        reputationLabel.text = LocalizationString.supportListReputationLabel.localized
        cornerView.layer.masksToBounds = true
        cornerView.layer.cornerRadius = 12
        cornerView.layer.borderWidth = 1
        cornerView.layer.borderColor = UIColor.black.cgColor
        selectionStyle = .none
    }
}

extension SupportListTableCell{
    fileprivate func generateLabel(_ style: LabelStyle) -> UILabel{
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = style.font
        view.textColor = style.textColor
        view.textAlignment = .left
        view.numberOfLines = style.lineLimit
        return view
    }
    
    fileprivate func generateImageView() -> UIImageView{
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }
    
    fileprivate func generateReputationView() -> UIView{
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 8
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.primary.cgColor
        return view
    }
    
    fileprivate func generateView() -> UIView{
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }
    
    fileprivate func generateReputationStarView() -> ReputationStarView{
        let view = ReputationStarView(16.0)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }
}
