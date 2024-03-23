import UIKit
import Foundation

protocol SignUpWireframe: RootRouter, AnyObject{

}

final class SignUpRouter: SignUpWireframe{
    internal unowned let viewController: UIViewController

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
