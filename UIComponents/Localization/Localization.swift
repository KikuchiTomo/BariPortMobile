//
//  Localization.swift
//  UIComponents
//
//  Created by Tomo Kikuchi on 2024/03/18.
//

import Foundation

public enum LocalizationString: String{
    case directMessageTabBarItemLabel
    case homeTabBarItemLabel
    case supportTabBarItemLabel
    case commonHereLabel
    case appDownloadLabel
    case supportButtonLabel
    case checkSupportDetailButtonLabel
    case reputationFromCorporationsLabel
    case supportListReputationLabel
    case alertCancel
    case alertOK
    case commonSignup
    case orLogin
    case commonSignIn
    case commonError
    case alertNotAllowEmptyEmail
    case alertNotAllowInvalidEmail
    case alertNotAllowEmptyPassword
    
    public var localized: String{
        get {
            NSLocalizedString(self.rawValue, tableName: nil, bundle: Bundle.current, comment: self.rawValue)
        }
    }
}
