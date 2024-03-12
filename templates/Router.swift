import UIKit
import Foundation

protocol {{screen}}Wireframe: AnyObject{

}

final class {{screen}}Router: {{screen}}Wireframe{
    private unowned let viewController: UIViewController

    private init(viewController: UIViewController){
        self.viewController = viewController
    }

    @MainActor static func assembleModules() -> UIViewController{
        let view = {{screen}}ViewController()
        let router = {{screen}}Router(viewController: view)
        let interactor = {{screen}}Interactor()

        let presenter = {{screen}}Presenter(
          view: view,
          router: router,
          interactor: interactor                        
        )

        view.presenter = presenter
        return view      
    }
}
