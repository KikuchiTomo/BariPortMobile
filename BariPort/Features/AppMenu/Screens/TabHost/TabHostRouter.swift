import UIKit
import Foundation

protocol TabHostWireframe: AnyObject{

}

final class TabHostRouter<TabItem: TabHostDataframe>: TabHostWireframe{
    private unowned let viewController: UIViewController

    private init(viewController: UIViewController){
        self.viewController = viewController
    }

    @MainActor static func assembleModules(_ tabItems: [TabItem]) -> UIViewController{
        let view = TabHostViewController(tabItems: tabItems)
        let router = TabHostRouter(viewController: view)
        let interactor = TabHostInteractor()

        let presenter = TabHostPresenter(
          view: view,
          router: router,
          interactor: interactor                        
        )

        view.presenter = presenter
        return view      
    }
}
