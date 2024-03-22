import UIKit
import Foundation

protocol MessageListPresentation: AnyObject {
    func refreshControlViewDidAppear()
    func directMessageListCellDidTap(id: UUID)
}

@MainActor final class MessageListPresenter: MessageListPresentation{
    func directMessageListCellDidTap(id: UUID) {
        router.presentDirectMessageView(directMessageID: id)
    }
    
    func refreshControlViewDidAppear() {
        Task{ @MainActor in
            view?.updateDirectMessageList([
                .init(id: UUID(),
                      summary: "実際に使ってみて、日常の課題を解決できている実感ができました！便利です！！", productName: "事業名HOGEHOGE", companyName: "株式会社ABC")
            ])
            view?.endRefreshing()
        }
    }
    
    private weak var view: MessageListView?
    private let router: MessageListWireframe
    private let interactor: MessageListUsecase

    init(view: MessageListView,
         router: MessageListWireframe,
         interactor: MessageListUsecase) {

        self.view = view
        self.router = router
        self.interactor = interactor
        
        view.appendedDirectMessageList([
            .init(id: UUID(), summary: "実際に使ってみて、日常の課題を解決できている実感ができました！便利です！！", productName: "事業名HOGEHOGE", companyName: "株式会社ABC"),
            .init(id: UUID(), summary: "実際に使ってみて、日常の課題を解決できている実感ができました！便利です！！", productName: "事業名HOGEHOGE", companyName: "株式会社ABCABCABCABC"),
            .init(id: UUID(), summary: "実際に使ってみて、日常の課題を解決できている実感ができました！便利です！！", productName: "事業名HOGEHOGEPIYPFUGABAR", companyName: "株式会社ABCABCABCABC"),
            .init(id: UUID(), summary: "実際に使ってみて、日常の課題を解決できている実感ができました！便利です！！", productName: "事業名HOGEHOGEPIYPFUGABARPIYOHOGEHOGE", companyName: "株式会社ABCABCABCABC")
        ])
    }
}

final class MockMessageListPresenter: MessageListPresentation{
    func refreshControlViewDidAppear() {
        
    }
    
    func directMessageListCellDidTap(id: UUID) {
        
    }
}
