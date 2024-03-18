import UIKit
import Foundation

protocol SupportListWireframe: AnyObject{

}

final class SupportListRouter: SupportListWireframe{
    private unowned let viewController: UIViewController

    private init(viewController: UIViewController){
        self.viewController = viewController
    }

    @MainActor static func assembleModules() -> UIViewController{
        let view = SupportListViewController()
        let router = SupportListRouter(viewController: view)
        let interactor = SupportListInteractor()

        let presenter = SupportListPresenter(
          view: view,
          router: router,
          interactor: interactor                        
        )

        view.presenter = presenter
        return view      
    }
    
    @MainActor static func assembleModules(tag: Int) -> TabHostEntity.TabItem{
        .init(
            viewController: SupportListRouter.assembleModules(),
            tabItem: UITabBarItem.supportTabBarItem(tag: tag)
        )
    }
}
