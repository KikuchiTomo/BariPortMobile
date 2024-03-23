import UIKit
import Foundation

protocol SignInView: AnyObject{

}

class SignInViewController: UIViewController{
    var presenter: SignInPresentation!

    lazy var emailLabel: UILabel = generateLabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()        
    }
}

extension SignInView{
    func generateLabel() -> UILabel{
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }
}

extension SignInViewController: SignInView{

}
