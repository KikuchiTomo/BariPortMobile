import Foundation
import UIComponents
import UIKit

struct ProjectListEntity{
    struct Cell: ProjectListTableViewDataframe{
        var projectName: String
        var companyName: String
        var comment: String
        
        init(projectName: String, companyName: String, comment: String) {
            self.projectName = projectName
            self.companyName = companyName
            self.comment = comment
        }
    }
}
