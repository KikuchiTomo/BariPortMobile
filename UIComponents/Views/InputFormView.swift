//
//  InputFormVIew.swift
//  BariPort
//
//  Created by 渡辺大智 on 2024/03/23.
//

import Foundation
import UIKit

public class InputFormView: UIView, UITextViewDelegate {
    private let textField = InputFormTextField()
    private let sendButton = UIButton(type: .system) // 送信ボタン
    
    public init(){
        super.init(frame: .zero)
        addViews()
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        setupView()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addViews(){
        addSubview(textField)
        addSubview(sendButton)
    }
    
    private func setupView() {
        backgroundColor = UIColor.secondary
        
        // TextFieldの設定
        // textField.placeholder = "a"
        textField.backgroundColor = .white // 背景色を白に設定
        textField.layer.cornerRadius = 18  // 角を丸くする
        textField.layer.masksToBounds = true // 角丸設定を有効に
        textField.dataDetectorTypes = UIDataDetectorTypes.all
        textField.textContainerInset = InputFormTextField.insets
        textField.delegate = self
        textField.isScrollEnabled = false
        
        // Sendボタンの設定
        sendButton.setImage(UIImage(systemName: "paperplane.fill"), for: .normal) // 紙飛行機のアイコン
        sendButton.tintColor = UIColor.primary
        
        // Auto Layoutの設定
        textField.translatesAutoresizingMaskIntoConstraints = false
        sendButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            // TextFieldの制約
            textField.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            textField.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
            textField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            textField.trailingAnchor.constraint(equalTo: sendButton.leadingAnchor, constant: -8),
            
            // Sendボタンの制約
            sendButton.topAnchor.constraint(equalTo: topAnchor, constant: 2),
            sendButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            sendButton.widthAnchor.constraint(equalToConstant: 44), // 適当なサイズに調整
            sendButton.heightAnchor.constraint(equalToConstant: 44) // 適当なサイズに調整
        ])
    }
}


fileprivate class InputFormTextField: UITextView{
    static let topPadding: CGFloat = 9
    static let bottomPadding: CGFloat = 10
    static let leftPadding: CGFloat = 14
    static let rightPadding: CGFloat = 14
    
    internal static let insets: UIEdgeInsets = .init(top: topPadding, left: leftPadding, bottom: bottomPadding, right: rightPadding)
}
