import Foundation
import UIComponents

struct DirectMessageEntity{
    struct Message: DirectMessageCellDataframe{
        var userName: String
        var receivedAt: Date
        var userType: UIComponents.DirectMessageCellUserType
        var userIconURL: URL?
        var body: String                
    }
    
    struct Hello{
        let message: String
    }
}
