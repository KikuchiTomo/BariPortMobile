//
//  BariPortAPIErrors.swift
//  BariPortAPI
//
//  Created by Tomo Kikuchi on 2024/03/23.
//

import Foundation

enum BariPortAPIErrors: Error {
    case NilResponse
}

extension BariPortAPIErrors: LocalizedError{
    var errorDescription: String? {
        switch(self){
        default:
            return "Unknown Error"
        }
    }
}
