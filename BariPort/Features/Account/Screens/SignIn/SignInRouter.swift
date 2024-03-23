import UIKit
import Foundation

protocol SignInWireframe: RootRouter, AnyObject{
    func presentTabHostView()
}

final class SignInRouter: SignInWireframe{
    func presentTabHostView() {
        let vc = TabHostRouter.assembleModules([
            ProjectListRouter.assembleModules(tag: 0),
            MessageListRouter.assembleModules(tag: 1),
            SupportListRouter.assembleModules(tag: 2)
        ])
        vc.modalPresentationStyle = .fullScreen
        self.viewController.present(vc, animated: true)
    }
    
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
