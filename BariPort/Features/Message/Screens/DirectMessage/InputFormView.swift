//
//  InputFormVIew.swift
//  BariPort
//
//  Created by 渡辺大智 on 2024/03/23.
//

import Foundation
import UIKit

class InputFormView: UIView {
    private let textField = UITextField()
    private let sendButton = UIButton(type: .system) // 送信ボタン
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        backgroundColor = .systemCyan // 背景色をsystemCyanに設定
        
        // TextFieldの設定
        textField.placeholder = "ここに入力"
        textField.backgroundColor = .white // 背景色を白に設定
        textField.layer.cornerRadius = 8 // 角を丸くする
        textField.layer.masksToBounds = true // 角丸設定を有効に
        addSubview(textField)
        
        // Sendボタンの設定
        sendButton.setImage(UIImage(systemName: "paperplane.fill"), for: .normal) // 紙飛行機のアイコン
        sendButton.tintColor = .white
        addSubview(sendButton)
        
        // Auto Layoutの設定
        textField.translatesAutoresizingMaskIntoConstraints = false
        sendButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            // TextFieldの制約
            textField.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            textField.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
            textField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            textField.trailingAnchor.constraint(equalTo: sendButton.leadingAnchor, constant: -8), // TextFieldの右側をSendボタンに合わせる
            
            // Sendボタンの制約
            sendButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            sendButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            sendButton.widthAnchor.constraint(equalToConstant: 44), // 適当なサイズに調整
            sendButton.heightAnchor.constraint(equalToConstant: 44) // 適当なサイズに調整
        ])
    }
}
