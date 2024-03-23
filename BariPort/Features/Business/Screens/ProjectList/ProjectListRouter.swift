import UIKit
import Foundation
import UIComponents

protocol ProjectListWireframe: RootRouter, AnyObject{

}

final class ProjectListRouter: ProjectListWireframe{
    internal unowned let viewController: UIViewController

    private init(viewController: UIViewController){
        self.viewController = viewController
    }

    @MainActor static func assembleModules() -> UIViewController{
        let view = ProjectListViewController()
        let router = ProjectListRouter(viewController: view)
        let interactor = ProjectListInteractor()

        let presenter = ProjectListPresenter(
          view: view,
          router: router,
          interactor: interactor                        
        )

        view.presenter = presenter
        return view      
    }
    
    @MainActor static func assembleModules(tag: Int) -> TabHostEntity.TabItem{
        .init(
            viewController: ProjectListRouter.assembleModules(),
            tabItem: .homeTabBarItem(tag: tag)
        )
    }
}
