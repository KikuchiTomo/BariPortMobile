//
//  DirectMessageListTableView.swift
//  UIComponents
//
//  Created by Tomo Kikuchi on 2024/03/18.
//

import Foundation
import UIKit

public protocol DirectMessageListTableViewDataframe{   
    var imageURL: URL? { get }
    var productName: String { get }
    var companyName: String { get }
    var summary: String { get }
}

public class DirectMessageListTableCell<Dataframe: DirectMessageListTableViewDataframe>: UITableViewCell{
    private var content: Dataframe?
    
    enum LabelStyle{
        case caption
        case title
        
        var font: UIFont{
            switch(self){
            case .caption:
                    UIFont.systemFont(ofSize: 12.0, weight: .regular)
            case .title:
                    UIFont.systemFont(ofSize: 15.0, weight: .semibold)
            }
        }
        
        var lineLimit: Int{
            switch(self){
            case .caption:
                return 3
            case .title:
                return 1
            }
        }
    }
    
    private lazy var productLabel: UILabel = generateLabel(.title)
    private lazy var companyLabel: UILabel = generateLabel(.title)
    private lazy var summaryLabel: UILabel = generateLabel(.caption)
    private lazy var contextGuide: UILayoutGuide = generateGuide()
    private lazy var iconView: UIImageView = generateImageView()
        
    public init(reuseIdentifier: String){
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        
        self.setupViewsEmpty()
        self.layoutViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func updateContent(content: Dataframe){
        self.content = content
        productLabel.text = content.productName + " / "
        companyLabel.text = content.companyName
        summaryLabel.text = content.summary
        
        if let imageURL = content.imageURL{
            let image = UIImage(url: imageURL)
            iconView.image = image
        }else{
            let image = UIImage.Messages.NoImageUser
            iconView.image = image.withRenderingMode(.alwaysTemplate)
            iconView.tintColor = .gray
        }
        
        self.setNeedsDisplay()
    }
}

extension DirectMessageListTableCell{
    fileprivate func generateLabel(_ style: LabelStyle) -> UILabel{
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = style.font
        view.textAlignment = .left
        view.numberOfLines = style.lineLimit
        return view
    }
    
    fileprivate func generateImageView() -> UIImageView{
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }
    
    fileprivate func generateGuide() -> UILayoutGuide{
        let view = UILayoutGuide()
        return view
    }
    
    fileprivate func setupViewsEmpty(){
        productLabel.text = ""
        companyLabel.text = ""
        summaryLabel.text = ""
    }
    
    fileprivate func layoutViews(){
        addSubview(iconView)
        addLayoutGuide(contextGuide)
        addSubview(companyLabel)
        addSubview(productLabel)
        addSubview(summaryLabel)
        
        productLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        companyLabel.setContentHuggingPriority(.defaultLow, for: .horizontal)
               
        NSLayoutConstraint.activate([
            iconView.centerYAnchor.constraint(equalTo: centerYAnchor),
            iconView.leftAnchor.constraint(equalTo: leftAnchor, constant: 16),
            iconView.heightAnchor.constraint(equalToConstant: 54),
            iconView.widthAnchor.constraint(equalToConstant: 54),
            
            contextGuide.topAnchor.constraint(equalTo: topAnchor, constant: 14),
            contextGuide.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -22),
            contextGuide.leftAnchor.constraint(equalTo: iconView.rightAnchor, constant: 8),
            contextGuide.rightAnchor.constraint(equalTo: rightAnchor, constant: -16),
            
            companyLabel.topAnchor.constraint(equalTo: contextGuide.topAnchor),
            companyLabel.rightAnchor.constraint(equalTo: contextGuide.rightAnchor),
            
            productLabel.topAnchor.constraint(equalTo: contextGuide.topAnchor),
            productLabel.leftAnchor.constraint(equalTo: contextGuide.leftAnchor),
            productLabel.rightAnchor.constraint(equalTo: companyLabel.leftAnchor),
            
            summaryLabel.topAnchor.constraint(equalTo: companyLabel.bottomAnchor, constant: 10),
            summaryLabel.bottomAnchor.constraint(equalTo: contextGuide.bottomAnchor),
            summaryLabel.leftAnchor.constraint(equalTo: contextGuide.leftAnchor),
            summaryLabel.rightAnchor.constraint(equalTo: contextGuide.rightAnchor),
        ])
    }
}
