import UIKit
import Foundation

protocol LandingWireframe: RootRouter, AnyObject{
    func presnetSignInView()
    func presentSignUpView()
}

final class LandingRouter: LandingWireframe{
    func presnetSignInView() {
        let vc = SignInRouter.assembleModules()
        vc.modalPresentationStyle = .fullScreen
        vc.modalTransitionStyle = .crossDissolve
        
        if let rootVC = RootViewController.appRootViewControllerInstance(){
            rootVC.show(vc, sender: nil)
        }else{
            self.viewController.present(vc, animated: true)
        }
    }
    
    func presentSignUpView() {
        let vc = SignUpRouter.assembleModules()
        vc.modalPresentationStyle = .fullScreen
        vc.modalTransitionStyle = .crossDissolve
        
        if let rootVC = RootViewController.appRootViewControllerInstance(){
            rootVC.show(vc, sender: nil)
        }else{
            self.viewController.present(vc, animated: true)
        }
    }
    
    internal unowned let viewController: UIViewController

    private init(viewController: UIViewController){
        self.viewController = viewController
    }

    @MainActor static func assembleModules() -> UIViewController{
        let view = LandingViewController()
        let router = LandingRouter(viewController: view)
        let interactor = LandingInteractor()

        let presenter = LandingPresenter(
          view: view,
          router: router,
          interactor: interactor                        
        )

        view.presenter = presenter
        return view      
    }
}
