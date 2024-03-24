import UIKit
import Foundation

protocol DirectMessagePresentation: AnyObject {
    var dataSource: DirectMessageDataSource { get }
    
    func viewDidAppear()
    func viewWillRefresh()
    func viewDidTapSendButton(message: String)
}

final class DirectMessagePresenter: DirectMessagePresentation{
    private weak var view: DirectMessageView?
    private let router: DirectMessageWireframe
    private let interactor: DirectMessageUsecase
    private let chatRoomID: String
    
    internal var dataSource: DirectMessageDataSource       
    
    init(view: DirectMessageView,
         router: DirectMessageWireframe,
         interactor: DirectMessageUsecase,
         chatRoomID: String
    ) {
        self.view = view
        self.router = router
        self.interactor = interactor  
        self.chatRoomID = chatRoomID
        
        self.dataSource = .init()
    }
    
    private func fetchMaessages(){
        Task{
            do{
                guard let userID = AuthenticationManager.shared.userID else { return }                
                print("getss", self.chatRoomID, userID)
                let result = try await self.interactor.fetchMessages(chatRoomID: self.chatRoomID, loginUserId: userID)
                Task{ @MainActor in
                    self.dataSource.updateItems(result)
                    self.view?.viewWillUpdateTableView()
                }
            }catch(let error){
                Task{ @MainActor in
                    print(error)
                   //  self.router.presentError(error: error)
                }
            }
        }
    }
    
    func viewDidTapSendButton(message: String){
        Task{
            do{
                guard let userID = AuthenticationManager.shared.userID else { return }
                print(userID, "aaaaaaaaaaaaaaaaaa")
                try await self.interactor.postMessage(chatRoomID: self.chatRoomID, userID: userID, message: message)
            }catch(let error){
                Task{ @MainActor in
                    self.router.presentError(error: error)
                }
            }
        }
        
        fetchMaessages()
    }
    
    func viewDidAppear(){
        fetchMaessages()
    }
    
    func viewWillRefresh(){
        fetchMaessages()
    }
}

final class MockDirectMessagePresenter: DirectMessagePresentation{
    internal var dataSource: DirectMessageDataSource = .init()
    
    func viewDidAppear(){
        
    }
    
    func viewWillRefresh(){
        
    }
    
    func viewDidTapSendButton(message: String){
        
    }
    
}
