//
// Reviews.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation



public struct Reviews: Codable {

    public var _id: String?
    public var companyId: String?
    public var userId: String?
    public var evaluationScore: Int?
    public var _description: String?

    public init(_id: String? = nil, companyId: String? = nil, userId: String? = nil, evaluationScore: Int? = nil, _description: String? = nil) {
        self._id = _id
        self.companyId = companyId
        self.userId = userId
        self.evaluationScore = evaluationScore
        self._description = _description
    }

    public enum CodingKeys: String, CodingKey { 
        case _id = "id"
        case companyId
        case userId
        case evaluationScore
        case _description = "description"
    }

}