//
// InlineResponse2001.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation



public struct InlineResponse2001: Codable {

    public var _id: String?
    public var company: ChatRoomParticipantsChatRooomCompany?
    public var userId: String?
    public var evaluationScore: Int?
    public var _description: String?
    public var sendAt: String?

    public init(_id: String? = nil, company: ChatRoomParticipantsChatRooomCompany? = nil, userId: String? = nil, evaluationScore: Int? = nil, _description: String? = nil, sendAt: String? = nil) {
        self._id = _id
        self.company = company
        self.userId = userId
        self.evaluationScore = evaluationScore
        self._description = _description
        self.sendAt = sendAt
    }

    public enum CodingKeys: String, CodingKey { 
        case _id = "id"
        case company
        case userId
        case evaluationScore
        case _description = "description"
        case sendAt
    }

}
