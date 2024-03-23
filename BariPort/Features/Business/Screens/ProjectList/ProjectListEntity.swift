import Foundation
import UIComponents
import UIKit

struct ProjectListEntity{
    struct Cell: ProjectListTableViewDataframe{
        var id: String
        var projectName: String
        var companyName: String
        var comment: String
        
        init(id: String, projectName: String, companyName: String, comment: String) {
            self.id = id
            self.projectName = projectName
            self.companyName = companyName
            self.comment = comment
        }
    }
}
