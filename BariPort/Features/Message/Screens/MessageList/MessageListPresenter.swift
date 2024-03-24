import UIKit
import Foundation

protocol MessageListPresentation: AnyObject {
    func refreshControlViewDidAppear()
    func directMessageListCellDidTap(id: String)
    
    func viewDidAppear()
    func viewDidTapLogout()
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
                
                guard let userID = AuthenticationManager.shared.userID else {
                    return
                }
                
                print(userID)
                
                let data = try await self.interactor.fetchMessages(userID: userID)
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
    
    func viewDidTapLogout(){
        Task{ @MainActor in
            // TODO: ここ汚すぎるのでリファクタする
            // TODO: ローカライズする
            self.router.presentAlert(type:
                .alert(
                    "確認",
                    "ログアウトしますか？",
                    [
                        .ok({ _ in
                            Task{
                                do{
                                    _ = try await AuthenticationManager.shared.signOut()
                                    Task{ @MainActor in
                                        // TODO: ログアウト後の画面
                                    }
                                }catch(let error){
                                    Task{ @MainActor in
                                        self.router.presentError(error: error)
                                    }
                                }
                            }
                        }),
                        .cancel({ _ in
                            
                        })
                    ])
            )
        }
    }
}

final class MockMessageListPresenter: MessageListPresentation{
    func refreshControlViewDidAppear() {
        
    }
    
    func directMessageListCellDidTap(id: String) {
        
    }
    
    func viewDidAppear(){
        
    }
    
    func viewDidTapLogout(){
        
    }
}
