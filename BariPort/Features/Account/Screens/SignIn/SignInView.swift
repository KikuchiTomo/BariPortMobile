import UIKit
import Foundation
import UIComponents

protocol SignInView: AnyObject{

}

class SignInViewController: UIViewController{
    var presenter: SignInPresentation!
    
    let backView: TitleBackView = {
        let view = TitleBackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let closeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "chevron.left")!.withRenderingMode(.alwaysTemplate), for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 5
        return button
    }()
    
    let emailLabel: UILabel = {
        let label = UILabel()
        label.text = "メールアドレス"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .monospacedSystemFont(ofSize: 12, weight: .semibold)
        label.textColor = .white
        return label
    }()
    
    let passwordLabel: UILabel = {
        let label = UILabel()
        label.text = "パスワード"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .monospacedSystemFont(ofSize: 12, weight: .semibold)
        label.textColor = .white
        return label
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "BariPort"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 24, weight: .semibold)
        label.textColor = .primary
        return label
    }()
    
    let emailTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.keyboardType = .emailAddress
        textField.autocapitalizationType = .none
        return textField
    }()
    
    let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.isSecureTextEntry = true
        return textField
    }()
    
    let signInButton: UIButton = {
        let button = UIButton(type: .system)
        let attributedTitle = NSAttributedString(string: LocalizationString.commonSignIn.localized, attributes: [.font:  UIFont.systemFont(ofSize: 20, weight: .semibold)])
        button.setAttributedTitle(attributedTitle, for: .normal)
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 25
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .secondary
        
        addSubviews()
        setUpConstraints()
        signInButton.addTarget(self, action: #selector(signInButtonTapped), for: .touchUpInside)
        closeButton.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
    }
    
    private func addSubviews() {
        view.addSubview(backView)
        view.addSubview(emailTextField)
        view.addSubview(passwordTextField)
        view.addSubview(signInButton)
        view.addSubview(closeButton)
        view.addSubview(emailLabel)
        view.addSubview(passwordLabel)
        view.addSubview(titleLabel)
    }
    
    private func setUpConstraints() {
        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        signInButton.translatesAutoresizingMaskIntoConstraints = false
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            backView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            backView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            backView.widthAnchor.constraint(equalTo: view.widthAnchor),
            backView.heightAnchor.constraint(equalTo: view.heightAnchor),
            
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: emailLabel.topAnchor, constant: -70),        
            
            closeButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            closeButton.leftAnchor.constraint(equalTo: view.leftAnchor),
            closeButton.widthAnchor.constraint(equalToConstant: 50),
            closeButton.widthAnchor.constraint(equalToConstant: 50),
            
            emailLabel.leftAnchor.constraint(equalTo: emailTextField.leftAnchor),
            emailLabel.bottomAnchor.constraint(equalTo: emailTextField.topAnchor, constant: -10),
            
            emailTextField.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -40),
            emailTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            emailTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            passwordLabel.leftAnchor.constraint(equalTo: passwordTextField.leftAnchor),
            passwordLabel.bottomAnchor.constraint(equalTo: passwordTextField.topAnchor, constant: -10),
            
            passwordTextField.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 40),
            passwordTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            passwordTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            signInButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -70),
            signInButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            signInButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            signInButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
 
    @objc private func closeButtonTapped(){
        self.presenter.viewDidTapCloseButton()
    }
    
    @objc private func signInButtonTapped() {
        guard let email = self.emailTextField.text else {
            self.presenter.viewDidTapSignInButtonWithEmptyEmail()
            return
        }

        guard let pass = self.passwordTextField.text else {
            self.presenter.viewDidTapSignInButtonWithEmptyPassword()
            return
        }

        self.presenter.viewDidTapSignInButton(email: email, password: pass)
    }
}

extension SignInView{
    func generateLabel() -> UILabel{
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }
}

extension SignInViewController: SignInView{

}
