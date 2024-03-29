import Foundation
import UIKit
import UIComponents

struct MessageListEntity{
    struct Cell: DirectMessageListTableViewDataframe{
        var id: String
        var summary: String
        var productName: String
        var companyName: String
        var image: UIImage?
        
        init(id: String, summary: String, productName: String, companyName: String, image: UIImage? = nil) {
            self.id = id
            self.summary = summary
            self.productName = productName
            self.companyName = companyName
            self.image = image
        }
    }
}
