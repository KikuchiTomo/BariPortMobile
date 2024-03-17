import UIKit
import Foundation
import UIComponents

protocol MessageListView: AnyObject{

}

class MessageListViewController: UIViewController{
    var presenter: MessageListPresentation!

    override func viewDidLoad() {
        super.viewDidLoad()    
        self.title = LocalizationString.directMessageTabBarItemLabel.localized
        self.view.backgroundColor = .systemYellow
    }
}

extension MessageListViewController: MessageListView{

}
