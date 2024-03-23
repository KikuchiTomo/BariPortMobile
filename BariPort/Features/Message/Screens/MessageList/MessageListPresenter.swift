import UIKit
import Foundation

protocol MessageListPresentation: AnyObject {
    func refreshControlViewDidAppear()
    func directMessageListCellDidTap(id: String)
    
    func viewDidAppear()
}

final class MessageListPresenter: MessageListPresentation{
    func directMessageListCellDidTap(id: String) {
        router.presetDirectMessageView(chatRoomID: id)
    }
    
    func refreshControlViewDidAppear() {
        fetchDatas()
    }
    
    func viewDidAppear(){
        fetchDatas()
    }
    
    fileprivate func fetchDatas(){
        Task{
            do {
                Task{ @MainActor in
                    self.view?.showLoadingView()
                }
                
                let data = try await self.interactor.fetchMessages(projectID: "")
                Task{ @MainActor in
                    self.view?.updateDirectMessageList(data)
                    self.view?.endRefreshing()
                    self.view?.hideLoadingView()
                }
            }catch let error{
                Task{ @MainActor in
                    self.view?.endRefreshing()
                    self.router.presentError(error: error)
                }
            }
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
        
        view.appendedDirectMessageList([])
    }
}

final class MockMessageListPresenter: MessageListPresentation{
    func refreshControlViewDidAppear() {
        
    }
    
    func directMessageListCellDidTap(id: String) {
        
    }
    
    func viewDidAppear(){
        
    }
}
