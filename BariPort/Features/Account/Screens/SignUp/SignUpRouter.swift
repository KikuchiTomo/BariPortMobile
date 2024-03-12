import UIKit
import Foundation

protocol SignUpWireframe: AnyObject{

}

final class SignUpRouter: SignUpWireframe{
    private unowned let viewController: UIViewController

    private init(viewController: UIViewController){
        self.viewController = viewController
    }

    @MainActor static func assembleModules() -> UIViewController{
        let view = SignUpViewController()
        let router = SignUpRouter(viewController: view)
        let interactor = SignUpInteractor()

        let presenter = SignUpPresenter(
          view: view,
          router: router,
          interactor: interactor                        
        )

        view.presenter = presenter
        return view      
    }
}
