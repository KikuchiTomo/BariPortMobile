import UIKit
import Foundation
import UIComponents

protocol ProjectListView: AnyObject{

}

class ProjectListViewController: UIViewController{
    var presenter: ProjectListPresentation!

    override func viewDidLoad() {
        super.viewDidLoad()        
        self.title = LocalizationString.homeTabBarItemLabel.localized
        self.view.backgroundColor = .white
    }
}

extension ProjectListViewController: ProjectListView{

}
