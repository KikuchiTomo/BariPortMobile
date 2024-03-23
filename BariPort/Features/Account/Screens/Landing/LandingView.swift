import UIKit
import Foundation
import UIComponents

protocol LandingView: AnyObject{

}

class LandingViewController: UIViewController{
    var presenter: LandingPresentation!
    
    private lazy var titleLabel: UILabel = generateLabel()
    private lazy var logoView: UIImageView = generateLogoView()
    private lazy var logoLabel: UILabel = generateLabel()
    private lazy var backView: TitleBackView = generateBackView()

    private lazy var loginButton: UIButton = generateButton()
    private lazy var signupButton: UIButton = generateButton()
    private lazy var blurView: UIVisualEffectView = generateBlurView()
   
    
    override func viewDidLoad() {
        super.viewDidLoad()  
        self.view.backgroundColor = .white

        self.addViews()
        self.configSignUpButton()
        self.configLoginButton()
        self.configs()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        self.layout()
    }
        
}

extension LandingViewController{
    func generateBlurView() -> UIVisualEffectView{
        let blurEffect = UIBlurEffect(style: .light)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        return blurEffectView
    }
    
    func  generateLabel() -> UILabel{
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textColor = .systemBlue
        return view
    }
    
    func generateLogoView() -> UIImageView{
        let view = UIImageView(image: UIImage.Account.Logo)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.tintColor = .systemBlue
        return view
    }
    
    func generateButton() -> UIButton{
        let view = UIButton()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }
    
    func  generateBackView() -> TitleBackView{
        let view = TitleBackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
        
    }
    func configSignUpButton(){
        var config = UIButton.Configuration.filled()
        let container = AttributeContainer([
            .font: UIFont.systemFont(ofSize: 20, weight: .semibold)
        ])
        config.attributedTitle = AttributedString( LocalizationString.commonSignup.localized, attributes: container)
        config.buttonSize = .large
        config.baseForegroundColor = .white
        config.baseBackgroundColor = .systemBlue
        config.cornerStyle = .capsule
        
        signupButton.configuration = config
        signupButton.setTitleShadowColor(.white, for: .normal)
        signupButton.setTitleColor(.white, for: .normal)
    }
    
    func configLoginButton(){
        var config = UIButton.Configuration.plain()
        let container = AttributeContainer([
            .font: UIFont.systemFont(ofSize: 14, weight: .semibold)
        ])
        config.attributedTitle = AttributedString(
            LocalizationString.orLogin.localized
            , attributes: container)
        config.buttonSize = .medium
        config.imagePlacement = .trailing
        config.image = UIImage(systemName: "chevron.right")!
            .resize(size: .init(width: 12, height: 12))!
            .withRenderingMode(.alwaysTemplate)
        config.baseForegroundColor = .white
        config.cornerStyle = .capsule
        
        loginButton.configuration = config
        loginButton.setTitleShadowColor(.white, for: .normal)
        loginButton.setTitleColor(.white, for: .normal)
    }
    
    func configs(){
        titleLabel.text = "BariPort"
        titleLabel.font = .systemFont(ofSize: 36, weight: .bold)
        titleLabel.textColor = .primary
                
        logoLabel.text = "北九州市"
        logoLabel.font = .systemFont(ofSize: 16, weight: .bold)
        logoLabel.textColor = .systemBlue
    }
    
    func layout(){
        blurView.frame = view.frame
        
        NSLayoutConstraint.activate([
            backView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            backView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            backView.widthAnchor.constraint(equalTo: view.widthAnchor),
            backView.heightAnchor.constraint(equalTo: view.heightAnchor),
            
            signupButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            signupButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100),
            signupButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
            
            loginButton.topAnchor.constraint(equalTo: signupButton.bottomAnchor, constant: 10),
            loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -60),
            
            logoView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 30),
            
            logoLabel.topAnchor.constraint(equalTo: logoView.bottomAnchor, constant: 10),
            logoLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
            
        ])
    }
    
    func addViews(){
        self.view.addSubview(backView)
        self.view.addSubview(blurView)
        self.view.addSubview(titleLabel)
        self.view.addSubview(logoView)
        self.view.addSubview(logoLabel)
        self.view.addSubview(loginButton)
        self.view.addSubview(signupButton)
    }
}

extension LandingViewController: LandingView{
    
}
