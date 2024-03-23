import UIKit
import Foundation

protocol SignInView: AnyObject{

}

class SignInViewController: UIViewController{
    var presenter: SignInPresentation!

    override func viewDidLoad() {
        super.viewDidLoad()        
    }
}

extension SignInViewController: SignInView{

}
