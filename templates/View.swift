import UIKit
import Foundation

protocol {{screen}}View: AnyObject{

}

class {{screen}}ViewController: UIViewController{
    var presenter: {{screen}}Presentation!

    override func viewDidLoad() {
        super.viewDidLoad()        
    }
}

extension {{screen}}ViewController: {{screen}}View{

}