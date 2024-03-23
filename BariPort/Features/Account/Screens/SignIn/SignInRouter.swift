import UIKit
import Foundation

protocol SignInWireframe: RootRouter, AnyObject{

}

final class SignInRouter: SignInWireframe{
    internal unowned let viewController: UIViewController

    private init(viewController: UIViewController){
        self.viewController = viewController
    }

    @MainActor static func assembleModules() -> UIViewController{
        let view = SignInViewController()
        let router = SignInRouter(viewController: view)
        let interactor = SignInInteractor()

        let presenter = SignInPresenter(
          view: view,
          router: router,
          interactor: interactor                        
        )

        view.presenter = presenter
        return view      
    }
}
