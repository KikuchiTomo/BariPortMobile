import UIKit
import Foundation

protocol TabHostWireframe: RootRouter, AnyObject{

}

final class TabHostRouter<TabItem: TabHostDataframe>: TabHostWireframe{
 
    
    internal unowned let viewController: UIViewController

    private init(viewController: UIViewController){
        self.viewController = viewController
    }
    
    static func assembleModules() -> UIViewController {
        fatalError("Not implemented")
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
        Switcher.shared.tabHostViewController = view
        
        return view
    }
}
