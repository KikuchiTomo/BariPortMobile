import UIKit
import Foundation

protocol {{screen}}Presentation: AnyObject {

}

@MainActor final class {{screen}}Presenter: {{screen}}Presentation{
    private weak var view: {{screen}}View?
    private let router: {{screen}}Wireframe
    private let interactor: {{screen}}Usecase

    init(view: {{screen}}View,
         router: {{screen}}Wireframe,
         interactor: {{screen}}Usecase) {

        self.view = view
        self.router = router
        self.interactor = interactor
    }
}

final class Mock{{screen}}Presenter: {{screen}}Presentation{

}
