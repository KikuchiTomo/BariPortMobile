import UIKit
import Foundation

protocol SignUpView: AnyObject{
    
}

class SignUpViewController: UIViewController{
    var presenter: SignUpPresentation!

    override func viewDidLoad() {
        super.viewDidLoad()     
        self.view.backgroundColor = .yellow
    }
}

extension SignUpViewController: SignUpView{

}
