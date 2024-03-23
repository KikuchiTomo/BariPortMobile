//
//  ProjectListTableCell.swift
//  UIComponents
//
//  Created by 渡辺大智 on 2024/03/23.
//

import Foundation
import UIKit

public protocol ProjectListTableViewDataframe{
    var projectName: String { get }
    var companyName: String { get }
    var comment: String { get }
}

public class ProjectListTableCell<Dataframe: ProjectListTableViewDataframe>: UITableViewCell{
    private var content: Dataframe?
    
    enum LabelStyle{
        case caption
        case title
        case body
        
        var font: UIFont{
            switch(self){
            case .caption:
                    UIFont.systemFont(ofSize: 9.0, weight: .regular)
            case .body:
                UIFont.systemFont(ofSize: 12.0, weight: .regular)
            case .title:
                UIFont.systemFont(ofSize: 17.0, weight: .semibold)
            }
        }
        
        var textColor: UIColor{
            return .black
        }
        
        var lineLimit: Int{
            switch(self){
            case .body:
                return 0
            case .title:
                return 1
            case .caption:
                return 3
            }
        }
    }
    
    private lazy var projectLabel: UILabel = generateLabel(.title)
    private lazy var companyLabel: UILabel = generateLabel(.title)
    private lazy var commentLabel: UILabel = generateLabel(.body)
    private lazy var cornerView: UIView = generateView()
    private lazy var testerButton: UIButton = generateButton("テスターになる")
    private lazy var directMessageButton: UIButton = generateButton("個別DMを送る")
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
        
        self.projectLabel.text = content.projectName
        self.companyLabel.text = content.companyName
        self.commentLabel.text = content.comment
        
        self.projectLabel.font = UIFont.boldSystemFont(ofSize: 20)
        self.projectLabel.backgroundColor = UIColor.yellow.withAlphaComponent(0.4)
        
        self.companyLabel.font = UIFont.systemFont(ofSize: 14)
        self.companyLabel.textAlignment = .left
        
        self.commentLabel.textAlignment = .left
        self.commentLabel.font = UIFont.systemFont(ofSize: 14)
        
        layoutViews()
    }
    
    public func layoutViews(){
        NSLayoutConstraint.deactivate(layouts)
        
        self.layouts = [
            cornerView.topAnchor.constraint(equalTo: topAnchor, constant: 13),
            cornerView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -13),
            cornerView.widthAnchor.constraint(equalTo: widthAnchor),
            cornerView.centerXAnchor.constraint(equalTo: centerXAnchor),

            projectLabel.topAnchor.constraint(equalTo: cornerView.topAnchor, constant: 13),
            projectLabel.leftAnchor.constraint(equalTo: cornerView.leftAnchor, constant: 8),

            companyLabel.topAnchor.constraint(equalTo: cornerView.topAnchor, constant: 13),
            companyLabel.rightAnchor.constraint(equalTo: cornerView.rightAnchor, constant: -8),

            commentLabel.topAnchor.constraint(equalTo: companyLabel.bottomAnchor, constant: 16),
            commentLabel.centerXAnchor.constraint(equalTo: cornerView.centerXAnchor),
            commentLabel.widthAnchor.constraint(equalTo: cornerView.widthAnchor, constant: -32),
            
            // testerButtonの制約
            testerButton.topAnchor.constraint(equalTo: commentLabel.bottomAnchor, constant: 16),
            testerButton.leadingAnchor.constraint(equalTo: cornerView.leadingAnchor, constant: 16),
            testerButton.heightAnchor.constraint(equalToConstant: 44),
            
            // directMessageButtonの制約
            directMessageButton.topAnchor.constraint(equalTo: testerButton.topAnchor),
            directMessageButton.leadingAnchor.constraint(equalTo: testerButton.trailingAnchor, constant: 8), // testerButtonとの間隔
            directMessageButton.trailingAnchor.constraint(equalTo: cornerView.trailingAnchor, constant: -16),
            directMessageButton.heightAnchor.constraint(equalTo: testerButton.heightAnchor),
            
            // ボタンの幅を等しくするための追加の制約
            directMessageButton.widthAnchor.constraint(equalTo: testerButton.widthAnchor),
            
            // cornerViewのbottomAnchorを更新する必要がある場合
            cornerView.bottomAnchor.constraint(greaterThanOrEqualTo: testerButton.bottomAnchor, constant: 16)
        ]
        
        NSLayoutConstraint.activate(layouts)
    }
    
    func configView(){
        self.addSubview(projectLabel)
        self.addSubview(commentLabel)
        self.addSubview(companyLabel)
        self.addSubview(testerButton)
        self.addSubview(directMessageButton)
        self.addSubview(cornerView)
        
        // Configs
        cornerView.layer.masksToBounds = true
        cornerView.layer.cornerRadius = 12
        cornerView.layer.borderWidth = 1
        cornerView.layer.borderColor = UIColor.black.cgColor
        selectionStyle = .none
    }
}

extension ProjectListTableCell{
    fileprivate func generateLabel(_ style: LabelStyle) -> UILabel{
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = style.font
        view.textColor = style.textColor
        view.textAlignment = .left
        view.numberOfLines = style.lineLimit
        return view
    }
    
    fileprivate func generateView() -> UIView{
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }
    
    fileprivate func generateButton(_ buttonLabel: String) -> UIButton{
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .systemCyan
        button.layer.cornerRadius = 10
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.black.cgColor
        button.setTitle(buttonLabel, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        return button
    }
}
