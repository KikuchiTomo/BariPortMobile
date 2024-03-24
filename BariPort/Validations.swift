//
//  Validations.swift
//  BariPort
//
//  Created by Tomo Kikuchi on 2024/03/24.
//

import Foundation

enum PasswordValidationResult {
    case valid
    case dataIsNil(section: String)
    case lengthInvalid(min: Int, max: Int)
    case characterIvalid
    
    var isValid: Bool {
        switch self {
        case .valid:
            return true
        case .dataIsNil:
            return false
        case .lengthInvalid:
            return false
        case .characterIvalid:
            return false
        }
    }
    
    // TODO: localized
    var message: String {
        switch self {
        case .valid:
            return ""
        case .dataIsNil(let section):
            return "\(section)が空です"
        case .lengthInvalid(let min, let max):
            return "\(min)〜\(max)文字で入力してください"
        case .characterIvalid:
            return "使用できない文字が含まれています"
        }
    }
}

final class PasswordValidator {
    static let shared: PasswordValidator = .init()
    private init() {}
    
    func passwordCheck(password: String?) -> PasswordValidationResult {
        guard let password = password, !password.isEmpty else {
            return .dataIsNil(section: "パスワード")
        }
        
        guard password.count >= 8 && password.count <= 16 else {
            return .lengthInvalid(min: 8, max: 16)
        }
        
        let pattern = "[^a-zA-Z0-9]"
        if password.range(of: pattern, options: .regularExpression) != nil {
            return .characterIvalid
        }
        
        return .valid
    }


}
