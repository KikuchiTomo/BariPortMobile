import Foundation
import UIKit
import UIComponents

struct MessageListEntity{
    struct Cell: DirectMessageListTableViewDataframe{
        var id: UUID
        var summary: String
        var productName: String
        var companyName: String
        var imageURL: URL?
        
        init(id: UUID, summary: String, productName: String, companyName: String, imageURL: URL? = nil) {
            self.id = id
            self.summary = summary
            self.productName = productName
            self.companyName = companyName
            self.imageURL = imageURL
        }
    }
}
