import UIKit
import Foundation
import UIComponents
import CryptoKit

protocol SignUpView: AnyObject{
    
}

class SignUpViewController: UIViewController{
    enum TextFieldType: Int{
        case email
        case password
    }
    
    var presenter: SignUpPresentation!
    
    let backView: TitleBackView = {
        let view = TitleBackView()
        return view
    }()
    
    
    let closeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "chevron.left")!.withRenderingMode(.alwaysTemplate), for: .normal)
        button.tintColor = .white
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 5
        return button
    }()
    
    let emailTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.keyboardType = .emailAddress
        textField.autocapitalizationType = .none
        textField.tag = TextFieldType.email.rawValue
        return textField
    }()
    
    let emailLabel: UILabel = {
        let label = UILabel()
        label.text = "メールアドレス"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .monospacedSystemFont(ofSize: 12, weight: .semibold)
        label.textColor = .white
        return label
    }()
    
    var emailValidLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .monospacedDigitSystemFont(ofSize: 12, weight: .semibold)
        label.textColor = .error
        return label
    }()
    
    let welcomeLabel: UILabel = {
        let label = UILabel()
        label.text = "ようこそ\nBariPort へ"
        label.textAlignment = .center
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 22, weight: .bold)
        label.textColor = .primary
        return label
    }()
    
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "BariPortは、北九州市の誘致を条件にITスタートアップの手助けをするアプリです"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 12, weight: .semibold)
        label.textColor = .secondary
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
    
    var passwordValidLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .monospacedDigitSystemFont(ofSize: 12, weight: .semibold)
        label.textColor = .error
        return label
    }()
    
    let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.isSecureTextEntry = true
        textField.tag = TextFieldType.password.rawValue
        return textField
    }()
    
    let signUpButton: UIButton = {
        let button = UIButton(type: .system)
        let attributedTitle = NSAttributedString(string: LocalizationString.commonSignup.localized, attributes: [.font:  UIFont.systemFont(ofSize: 20, weight: .semibold)])
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
      
        signUpButton.addTarget(self, action: #selector(signUpButtonTapped), for: .touchUpInside)
        closeButton.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
    }
    
    private func addSubviews() {
        view.addSubview(backView)
        view.addSubview(emailTextField)
        view.addSubview(passwordTextField)
        view.addSubview(signUpButton)
        view.addSubview(closeButton)
        view.addSubview(emailLabel)
        view.addSubview(passwordLabel)
        view.addSubview(welcomeLabel)
        view.addSubview(descriptionLabel)
        view.addSubview(emailValidLabel)
        view.addSubview(passwordValidLabel)
    }
    
    private func setUpConstraints() {
        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        signUpButton.translatesAutoresizingMaskIntoConstraints = false
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        backView.translatesAutoresizingMaskIntoConstraints = false
        
        emailTextField.delegate = self
        passwordTextField.delegate = self
        
        NSLayoutConstraint.activate([
            welcomeLabel.bottomAnchor.constraint(equalTo: descriptionLabel.topAnchor, constant: -18),
            welcomeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            welcomeLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.7),
            
            descriptionLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            descriptionLabel.bottomAnchor.constraint(equalTo: emailLabel.topAnchor, constant: -50),
            descriptionLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.7),
            
            backView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            backView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            backView.widthAnchor.constraint(equalTo: view.widthAnchor),
            backView.heightAnchor.constraint(equalTo: view.heightAnchor),
            
            closeButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            closeButton.leftAnchor.constraint(equalTo: view.leftAnchor),
            closeButton.widthAnchor.constraint(equalToConstant: 50),
            closeButton.widthAnchor.constraint(equalToConstant: 50),
            
            emailLabel.leftAnchor.constraint(equalTo: emailTextField.leftAnchor),
            emailLabel.bottomAnchor.constraint(equalTo: emailTextField.topAnchor, constant: -10),
            
            emailValidLabel.rightAnchor.constraint(equalTo: emailTextField.rightAnchor),
            emailValidLabel.leftAnchor.constraint(equalTo: emailLabel.rightAnchor),
            emailValidLabel.bottomAnchor.constraint(equalTo: emailTextField.topAnchor, constant: -10),
            
            emailTextField.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -40),
            emailTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            emailTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            passwordLabel.leftAnchor.constraint(equalTo: passwordTextField.leftAnchor),
            passwordLabel.bottomAnchor.constraint(equalTo: passwordTextField.topAnchor, constant: -10),
            
            passwordTextField.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 40),
            passwordTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            passwordTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            passwordValidLabel.rightAnchor.constraint(equalTo: passwordTextField.rightAnchor),
            passwordValidLabel.leftAnchor.constraint(equalTo: passwordLabel.rightAnchor),
            passwordValidLabel.bottomAnchor.constraint(equalTo: passwordTextField.topAnchor, constant: -10),
            
            signUpButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -70),
            signUpButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            signUpButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            signUpButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
     
    @objc private func closeButtonTapped(){
        self.presenter.viewDidTapCloseButton()
    }
    
    @objc private func signUpButtonTapped() {
        guard let email = self.emailTextField.text else {
            self.presenter.viewDidTapSignUpButtonWithEmptyEmail()
            return
        }

        guard let pass = self.passwordTextField.text else {
            self.presenter.viewDidTapSignUpButtonWithEmptyPassword()
            return
        }

        self.presenter.viewDidTapSignUpButton(email: email, password: pass)
    }
}

// TODO: Presenterへ外だし. 時間なさすぎなので，一旦ここに書く
extension SignUpViewController: UITextFieldDelegate{
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let tag = TextFieldType.init(rawValue: textField.tag) else { return true}
        switch(tag){
        case .email:
            // TODO: Validatorの定義をする
            if presenter.isValidMailAddress(self.emailTextField.text ?? ""){
                self.emailValidLabel.text = ""
            }else{
                self.emailValidLabel.text = "メールアドレスが正しくありません"
            }
            
            self.emailValidLabel.setNeedsDisplay()
        case .password:
            self.passwordValidLabel.text = PasswordValidator.shared.passwordCheck(password: self.passwordTextField.text).message
            self.passwordValidLabel.setNeedsDisplay()
        }
        return true
    }
}

extension SignUpViewController: SignUpView{
    
}
