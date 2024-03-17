import UIKit
import Foundation
import UIComponents

protocol SupportListView: AnyObject{

}

class SupportListViewController: UIViewController{
    var presenter: SupportListPresentation!

    override func viewDidLoad() {
        super.viewDidLoad() 
        self.title = LocalizationString.supportTabBarItemLabel.localized
        self.view.backgroundColor = .systemBlue
    }
}

extension SupportListViewController: SupportListView{

}
