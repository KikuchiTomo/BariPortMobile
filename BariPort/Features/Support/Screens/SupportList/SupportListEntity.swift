import Foundation
import UIKit
import UIComponents

struct SupportListEntity{
    struct Cell: SupportListTableViewDataframe{
        var image: UIImage?
        var companyName: String
        var comment: String
        var createdAt: Date
        var reputationValue: Float
        
        init(image: UIImage? = nil, companyName: String, comment: String, createdAt: Date, reputationValue: Float) {
            self.image = image
            self.companyName = companyName
            self.comment = comment
            self.createdAt = createdAt
            self.reputationValue = reputationValue
        }
    }
}
