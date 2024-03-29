//
// InlineResponse200.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation



public struct InlineResponse200: Codable {

    public var _id: String?
    public var name: String?
    public var _description: String?
    public var company: ProjectslistCompany?

    public init(_id: String? = nil, name: String? = nil, _description: String? = nil, company: ProjectslistCompany? = nil) {
        self._id = _id
        self.name = name
        self._description = _description
        self.company = company
    }

    public enum CodingKeys: String, CodingKey { 
        case _id = "id"
        case name
        case _description = "description"
        case company
    }

}
