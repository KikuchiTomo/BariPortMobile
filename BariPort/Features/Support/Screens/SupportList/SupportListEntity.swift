import Foundation
import UIKit
import UIComponents

struct SupportListEntity{
    struct Cell: SupportListTableViewDataframe{
        var imageURL: URL?
        var companyName: String
        var comment: String
        var createdAt: Date
        var reputationValue: Float
        
        init(imageURL: URL? = nil, companyName: String, comment: String, createdAt: Date, reputationValue: Float) {
            self.imageURL = imageURL
            self.companyName = companyName
            self.comment = comment
            self.createdAt = createdAt
            self.reputationValue = reputationValue
        }
    }
}
