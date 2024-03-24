import UIKit
import Foundation
import UIComponents

protocol SignUpPresentation: AnyObject {
    func viewDidTapCloseButton()
    func viewDidTapSignUpButton(email: String, password: String)
    func viewDidTapSignUpButtonWithEmptyEmail()
    func viewDidTapSignUpButtonWithEmptyPassword()
}

final class SignUpPresenter: SignUpPresentation{
    func viewDidTapCloseButton() {
        Task{ @MainActor in
            self.router.dismiss()
        }
    }
    
    func viewDidTapSignUpButton(email: String, password: String){
        // Check
        guard email != "" else {
            viewDidTapSignUpButtonWithEmptyEmail()
            return
        }
        
        guard password != "" else {
            viewDidTapSignUpButtonWithEmptyPassword()
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
                _ = try await AuthenticationManager.shared.signUp(email: email, password: password)
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
    
    func viewDidTapSignUpButtonWithEmptyEmail(){
        Task{ @MainActor in
            self.router.presentAlert(
                type: .alert(
                    LocalizationString.commonError.localized,
                    LocalizationString.alertNotAllowEmptyEmail.localized,
                    [.ok({ _ in})]
                ))
        }
    }
    
    func viewDidTapSignUpButtonWithEmptyPassword(){
        Task{ @MainActor in
            self.router.presentAlert(
                type: .alert(
                    LocalizationString.commonError.localized,
                    LocalizationString.alertNotAllowEmptyPassword.localized,
                    [.ok({ _ in})]
                ))
        }
    }
    
    private weak var view: SignUpView?
    private let router: SignUpWireframe
    private let interactor: SignUpUsecase

    init(view: SignUpView,
         router: SignUpWireframe,
         interactor: SignUpUsecase) {

        self.view = view
        self.router = router
        self.interactor = interactor
    }
}

extension SignUpPresentation{
    internal func isValidMailAddress(_ string: String) -> Bool {
        let mailAddressRegEx = "^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}$"
        let mailAddressTest = NSPredicate(format:"SELF MATCHES %@", mailAddressRegEx)
        let result = mailAddressTest.evaluate(with: string)
        return result
    }
}

final class MockSignUpPresenter: SignUpPresentation{
    func viewDidTapCloseButton() {
        
    }
    
    func viewDidTapSignUpButton(email: String, password: String){
        
    }
    
    func viewDidTapSignUpButtonWithEmptyEmail(){
        
    }
    
    func viewDidTapSignUpButtonWithEmptyPassword(){
        
    }
}
