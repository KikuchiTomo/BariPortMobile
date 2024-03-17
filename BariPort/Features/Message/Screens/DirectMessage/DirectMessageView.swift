import UIKit
import Foundation

protocol DirectMessageView: AnyObject{

}

class DirectMessageViewController: UIViewController{
    var presenter: DirectMessagePresentation!

    override func viewDidLoad() {
        super.viewDidLoad()        
    }
}

extension DirectMessageViewController: DirectMessageView{

}
