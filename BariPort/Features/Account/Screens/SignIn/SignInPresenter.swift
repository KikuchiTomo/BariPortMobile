import UIKit
import UIComponents
import Foundation

protocol SignInPresentation: AnyObject {
    func viewDidTapCloseButton()
    func viewDidTapSignInButton(email: String, password: String)
    func viewDidTapSignInButtonWithEmptyEmail()
    func viewDidTapSignInButtonWithEmptyPassword()
}

final class SignInPresenter: SignInPresentation{
    private weak var view: SignInView?
    private let router: SignInWireframe
    private let interactor: SignInUsecase

    init(view: SignInView,
         router: SignInWireframe,
         interactor: SignInUsecase) {

        self.view = view
        self.router = router
        self.interactor = interactor
    }
    
    func viewDidTapCloseButton() {
        Task{ @MainActor in
            self.router.dismiss()
        }
    }
    
    func viewDidTapSignInButton(email: String, password: String){
        // Check
        guard email != "" else {
            viewDidTapSignInButtonWithEmptyEmail()
            return
        }
        
        guard password != "" else {
            viewDidTapSignInButtonWithEmptyPassword()
            return
        }
        
        guard isValidMailAddress(email) else{
            Task{ @MainActor in
                self.router.presentAlert(
                    type: .alert(
                        LocalizationString.commonError.localized,
                        LocalizationString.alertNotAllowInvalidEmail.localized,
                        [.ok({ _ in})]
                    ))
            }
            return
        }
        
        // TODO password形式のチェック
        
        Task{
            do{
                _ = try await AuthenticationManager.shared.signIn(email: email, password: password)
                Task{ @MainActor in
                    self.router.presentTabHostView()
                }
            }catch(let error){
                Task{ @MainActor in
                    self.router.presentError(error: error)
                }
            }
        }
    }
    
    func viewDidTapSignInButtonWithEmptyEmail(){
        Task{ @MainActor in
            self.router.presentAlert(
                type: .alert(
                    LocalizationString.commonError.localized,
                    LocalizationString.alertNotAllowEmptyEmail.localized,
                    [.ok({ _ in})]
                ))
        }
    }
    
    func viewDidTapSignInButtonWithEmptyPassword(){
        Task{ @MainActor in
            self.router.presentAlert(
                type: .alert(
                    LocalizationString.commonError.localized,
                    LocalizationString.alertNotAllowEmptyPassword.localized,
                    [.ok({ _ in})]
                ))
        }
    }
    
    
    private func isValidMailAddress(_ string: String) -> Bool {
        let mailAddressRegEx = "[A-Z0-9a-z._+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        let mailAddressTest = NSPredicate(format:"SELF MATCHES %@", mailAddressRegEx)
        let result = mailAddressTest.evaluate(with: string)
        return result
    }
}

final class MockSignInPresenter: SignInPresentation{
    func viewDidTapCloseButton() {
        
    }
    
    func viewDidTapSignInButton(email: String, password: String){
        
    }
    
    func viewDidTapSignInButtonWithEmptyEmail(){
        
    }
    
    func viewDidTapSignInButtonWithEmptyPassword(){
        
    }
}
