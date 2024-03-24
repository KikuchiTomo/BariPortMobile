//
//  ProjectListTableCell.swift
//  UIComponents
//
//  Created by 渡辺大智 on 2024/03/23.
//

import Foundation
import UIKit

public protocol ProjectListTableViewDataframe{
    var id: String { get }
    var projectName: String { get }
    var companyName: String { get }
    var comment: String { get }
    var url: URL{ get }
}

public class ProjectListTableCell<Dataframe: ProjectListTableViewDataframe>: UITableViewCell{
    private var content: Dataframe?
    
    public var viewDidTapDirectMessage: ((_ id: String) -> Void)? = nil
    public var viewDidTapTester: ((_ url: URL) -> Void)? = nil
    
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
    private lazy var projectLabelBackgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(displayP3Red: 255/255.0, green: 254/255.0, blue: 233/255.0, alpha: 1.0)
        view.layer.cornerRadius = 6
        view.layer.masksToBounds = true
        return view
    }()
    private lazy var projectLabel: UILabel = generateLabel(.title)
    private lazy var companyLabel: UILabel = generateLabel(.title)
    private lazy var commentLabel: UILabel = generateLabel(.body)
    private lazy var cornerView: UIView = generateView()
    private lazy var testerButton: UIButton = generateButton("テスターになる")
    private lazy var directMessageButton: UIButton = generateButton("個別DMを送る")
    private var layouts: [NSLayoutConstraint] = []
    
    public init(reuseIdentifier: String){
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        self.contentView.isUserInteractionEnabled = false
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

            projectLabel.topAnchor.constraint(equalTo: cornerView.topAnchor, constant: 20),
            projectLabel.leftAnchor.constraint(equalTo: cornerView.leftAnchor, constant: 20),
            projectLabelBackgroundView.topAnchor.constraint(equalTo: projectLabel.topAnchor, constant: -8), // 上下左右に余白を追加
            projectLabelBackgroundView.bottomAnchor.constraint(equalTo: projectLabel.bottomAnchor, constant: 8),
            projectLabelBackgroundView.leadingAnchor.constraint(equalTo: projectLabel.leadingAnchor, constant: -8),
            projectLabelBackgroundView.trailingAnchor.constraint(equalTo: projectLabel.trailingAnchor, constant: 8),

            companyLabel.topAnchor.constraint(equalTo: cornerView.topAnchor, constant: 13),
            companyLabel.rightAnchor.constraint(equalTo: cornerView.rightAnchor, constant: -16),

            commentLabel.topAnchor.constraint(equalTo: projectLabelBackgroundView.bottomAnchor, constant: 24),
            commentLabel.centerXAnchor.constraint(equalTo: cornerView.centerXAnchor),
            commentLabel.widthAnchor.constraint(equalTo: cornerView.widthAnchor, constant: -32),
            
            // testerButtonの制約
            testerButton.topAnchor.constraint(equalTo: commentLabel.bottomAnchor, constant: 16),
            testerButton.leadingAnchor.constraint(equalTo: cornerView.leadingAnchor, constant: 24),
            testerButton.heightAnchor.constraint(equalToConstant: 40),
            
            // directMessageButtonの制約
            directMessageButton.topAnchor.constraint(equalTo: testerButton.topAnchor),
            directMessageButton.leadingAnchor.constraint(equalTo: testerButton.trailingAnchor, constant: 16), // testerButtonとの間隔
            directMessageButton.trailingAnchor.constraint(equalTo: cornerView.trailingAnchor, constant: -24),
            directMessageButton.heightAnchor.constraint(equalTo: testerButton.heightAnchor),
            
            // ボタンの幅を等しくするための追加の制約
            directMessageButton.widthAnchor.constraint(equalTo: testerButton.widthAnchor),
            
            // cornerViewのbottomAnchorを更新する必要がある場合
            cornerView.bottomAnchor.constraint(greaterThanOrEqualTo: testerButton.bottomAnchor, constant: 16)
        ]
        
        NSLayoutConstraint.activate(layouts)
    }
    
    func configView(){
        self.addSubview(commentLabel)
        self.addSubview(companyLabel)
        self.addSubview(testerButton)
        self.addSubview(directMessageButton)
        self.addSubview(cornerView)
        cornerView.addSubview(projectLabelBackgroundView)
        cornerView.addSubview(projectLabel)
        
        // UIViewに隠れるので前に持ってきてますw
        self.bringSubviewToFront(directMessageButton)
        self.bringSubviewToFront(testerButton)
        
        // Configs
        cornerView.layer.masksToBounds = true
        cornerView.layer.cornerRadius = 12
        cornerView.layer.borderWidth = 2
        cornerView.layer.borderColor = UIColor.systemGray3.cgColor
        cornerView.isUserInteractionEnabled = true
        selectionStyle = .none
        
        projectLabelBackgroundView.translatesAutoresizingMaskIntoConstraints = false
        
        self.directMessageButton.addTarget(self, action: #selector(tapActionDM), for: .touchUpInside)
        self.testerButton.addTarget(self, action: #selector(tapActionTester), for: .touchUpInside)
    }
    
    @objc func tapActionDM() {
        if let id = content?.id {
            viewDidTapDirectMessage?(id)
        }
    }
    
    @objc func tapActionTester(){
        if let url = content?.url{
            viewDidTapTester?(url)
        }
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
        button.backgroundColor = UIColor.systemCyan.withAlphaComponent(0.1)
        button.layer.cornerRadius = 10
        button.layer.borderWidth = 0.8
        button.layer.borderColor = UIColor.black.cgColor
        button.setTitle(buttonLabel, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.setTitleColor(.gray, for: .normal)
        return button
    }
}
