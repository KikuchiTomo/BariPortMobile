//
//  AppDownloadButton.swift
//  UIComponents
//
//  Created by Tomo Kikuchi on 2024/03/18.
//

import Foundation
import UIKit

public class AppDownloadButton: UIButton{
    enum Category{
        case caption
        case primary
        case link
        
        
        var font: UIFont{
            switch(self){
            case .caption:
                return .systemFont(ofSize: 11, weight: .regular)
            case .primary, .link:
                return .systemFont(ofSize: 16, weight: .medium)
            }
        }
        
        var textDecoration: Bool{
            switch(self){
            case .caption, .primary:
                return false
            case .link:
                return true
            }
        }
        
        var color: UIColor{
            switch(self){
            case .caption, .primary:
                return .black
            case .link:
                return .systemBlue
            }
        }
    }
    
    private lazy var topLabel: UILabel = generateLabel()
    private lazy var bottomHeadLabel: UILabel = generateLabel()
    private lazy var bottomTailLabel: UILabel = generateLabel()
    private let mainGuide: UILayoutGuide = UILayoutGuide()
    private let bottomGuide: UILayoutGuide = UILayoutGuide()
    
    private let productName: String
    private let companyName: String
    
    public init(productName: String, companyName: String) {
        self.productName = productName
        self.companyName = companyName
        
        super.init(frame: .zero)
        
        self.setupLabel(label: topLabel, category: .caption, 
                        text: "\(productName) / \(companyName)")
        self.setupLabel(label: bottomHeadLabel, category: .primary,
                        text:LocalizationString.appDownloadLabel.localized)
        self.setupLabel(label: bottomTailLabel, category: .link,
                        text:LocalizationString.commonHereLabel.localized)
        
        self.layoutViews()
        self.configView()
        
        self.backgroundColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension AppDownloadButton{
    func generateLabel() -> UILabel{
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textAlignment = .center
        return view
    }
    
    func setupLabel(label: UILabel, category: Category, text: String){
        label.font = category.font
        label.textColor = category.color
        
        if category.textDecoration{
            let attributedText = NSMutableAttributedString(string: text)
            let range = NSMakeRange(0, text.count)
            attributedText.addAttribute(NSAttributedString.Key.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: range)
            label.attributedText = attributedText
        }else{
            label.text = text
        }
    }
    
    func layoutViews(){
        addSubview(topLabel)
        addSubview(bottomHeadLabel)
        addSubview(bottomTailLabel)
        addLayoutGuide(mainGuide)
        addLayoutGuide(bottomGuide)
        
        NSLayoutConstraint.activate([
            mainGuide.centerXAnchor.constraint(equalTo: centerXAnchor),
            mainGuide.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.9),
            mainGuide.topAnchor.constraint(equalTo: topAnchor, constant: 13),
            mainGuide.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -13),

            topLabel.bottomAnchor.constraint(equalTo: mainGuide.centerYAnchor, constant: -5),
            topLabel.centerXAnchor.constraint(equalTo: mainGuide.centerXAnchor),
                        
            bottomGuide.topAnchor.constraint(equalTo: mainGuide.centerYAnchor),
            bottomGuide.centerXAnchor.constraint(equalTo: centerXAnchor),
            bottomGuide.bottomAnchor.constraint(equalTo: mainGuide.bottomAnchor),
            bottomHeadLabel.leftAnchor.constraint(equalTo: bottomGuide.leftAnchor),
            bottomTailLabel.leftAnchor.constraint(equalTo: bottomHeadLabel.rightAnchor),
            bottomTailLabel.rightAnchor.constraint(equalTo: bottomGuide.rightAnchor),
            bottomHeadLabel.topAnchor.constraint(equalTo: bottomGuide.topAnchor),
            bottomTailLabel.topAnchor.constraint(equalTo: bottomGuide.topAnchor),
        ])
    }
    
    func configView(){
        self.layer.masksToBounds = true
        self.layer.cornerRadius = 12.0
        self.layer.borderWidth = 1.0
        self.layer.borderColor = UIColor.primary.cgColor
    }
}
