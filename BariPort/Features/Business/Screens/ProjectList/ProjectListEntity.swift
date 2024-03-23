import Foundation
import UIComponents
import UIKit

struct ProjectListEntity{
    struct Cell: ProjectListTableViewDataframe{
        var url: URL
        
        var id: String
        var projectName: String
        var companyName: String
        var comment: String
        
        init(url: URL, id: String, projectName: String, companyName: String, comment: String) {
            self.url = url
            self.id = id
            self.projectName = projectName
            self.companyName = companyName
            self.comment = comment
        }
    }
}
