import UIKit
import Foundation

protocol SignUpWireframe: RootRouter, AnyObject{
    func presentTabHostView()
}

final class SignUpRouter: SignUpWireframe{
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
