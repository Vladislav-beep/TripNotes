//
//  AuthViewController.swift
//  TripNotes
//
//  Created by Владислав Сизонов on 24.01.2022.
//

import UIKit

class AuthViewController: UIViewController {
    
    // MARK: - Dependencies
    
    private var viewModel: AuthViewModelProtocol
    private lazy var keyboard = KeyboardHelper(scrollView: scrollView, offSet: 100)
    private lazy var animator = Animator(container: view)
    var configurator: Configurator?
    
    // MARK: - UI
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private lazy var lowerView: UIView = {
        let lowerView = UIView()
        lowerView.backgroundColor = .white
        lowerView.translatesAutoresizingMaskIntoConstraints = false
        return lowerView
    }()
    
    private lazy var welcomeLabel: WelcomeLabel = {
        let welcomeLabel = WelcomeLabel()
        return welcomeLabel
    }()
    
    private lazy var emailTextField: AuthTextField = {
        let loginTextField = AuthTextField(placeHolder: I.emailTextFieldPlaceholder)
        return loginTextField
    }()
    
    private lazy var passwordTextField: AuthTextField = {
        let passwordTextField = AuthTextField(placeHolder: I.passwordTextFieldPlaceholder)
        passwordTextField.isSecureTextEntry = true
        return passwordTextField
    }()
    
    private let signInButton: SignInButton = {
        let signInButton = SignInButton(title: I.signInButtonTitle, colorOfBackground: .tripRed)
        signInButton.addTarget(self,
                               action: #selector(showTabbar),
                               for: .touchUpInside)
        return signInButton
    }()
    
    private lazy var textFieldStack: UIStackView = {
        let textFieldStack = UIStackView(arrangedSubviews: [emailTextField, passwordTextField],
                                         axis: .vertical,
                                         spacing: 16,
                                         distribution: .fillEqually)
        return textFieldStack
    }()
    
    private lazy var createLabel: CreateLabel = {
        let createLabel = CreateLabel()
        return createLabel
    }()
    
    private lazy var createButton: CreateButton = {
        let createButton = CreateButton()
        createButton.addTarget(self, action: #selector(createNewAccount), for: .touchUpInside)
        return createButton
    }()
    
    private lazy var createStack: UIStackView = {
        let createStack = UIStackView(arrangedSubviews: [createLabel, createButton],
                                      axis: .vertical,
                                      spacing: 8,
                                      distribution: .fillEqually)
        return createStack
    }()
    
    private lazy var endEditingGestureRecognizer: UITapGestureRecognizer = {
        let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        return tap
    }()
    
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        return activityIndicator
    }()
    
    // MARK: - Life Time
    
    init(viewModel: AuthViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        checkSignIn()
        setupConstraints()
        keyboard.registerKeyBoardNotification()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addGestureRecognizer(endEditingGestureRecognizer)
        emailTextField.delegate = self
        passwordTextField.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        emailTextField.text = ""
        passwordTextField.text = ""
    }
    
    deinit {
        keyboard.removeKeyboardNotification()
    }
    
    // MARK: - Actions
    
    @objc func createNewAccount() {
        let newVC = configurator?.configureNewAcc() ?? UIViewController()
        present(newVC, animated: true)
    }
    
    @objc func showTabbar() {
        activityIndicator.startAnimating()
        guard let email = emailTextField.text, email != "",
              let password = passwordTextField.text, password != ""
        else {
            self.showAlert(title: I.error, message: I.emptyFieldsWarning)
            activityIndicator.stopAnimating()
            return
        }
        
        viewModel.signIn(withEmail: email, password: password) { [weak self] in
            let tabBar = self?.configurator?.configureTabbar() ?? UIViewController()
            self?.present(tabBar, animated: true)
            self?.activityIndicator.stopAnimating()
        } errorComletion: { [weak self] in
            let warningText = I.incorrectWarning
            self?.showAlert(title: "Error", message: warningText)
            self?.activityIndicator.stopAnimating()
        }
    }
    
    // MARK: - Private methods
    
    private func checkSignIn() {
        viewModel.checkSignIn { [weak self] in
            let tabBar = self?.configurator?.configureTabbar() ?? UIViewController()
            tabBar.modalPresentationStyle = .fullScreen
            self?.present(tabBar, animated: true)
        }
    }
    
    // MARK: - Layout
    
    private func setupConstraints() {
        setupScrollViewConstraints()
        setupLowerViewConstraints()
        setupWelcomeLabelConstraints()
        setupTextFieldStackConstraints()
        setupSignInButtonConstraints()
        setupCreateButtonConstraints()
        setupActivityIndicatorConstraints()
    }
    
    private func setupScrollViewConstraints() {
        view.addSubview(scrollView)
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
        ])
    }
    
    private func setupLowerViewConstraints() {
        scrollView.addSubview(lowerView)
        NSLayoutConstraint.activate([
            lowerView.centerYAnchor.constraint(equalTo: scrollView.centerYAnchor),
            lowerView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            lowerView.heightAnchor.constraint(equalTo: view.heightAnchor),
            lowerView.widthAnchor.constraint(equalTo: view.widthAnchor)
        ])
    }
    
    private func setupWelcomeLabelConstraints() {
        lowerView.addSubview(welcomeLabel)
        NSLayoutConstraint.activate([
            welcomeLabel.topAnchor.constraint(equalTo: lowerView.topAnchor, constant: 120),
            welcomeLabel.leadingAnchor.constraint(equalTo: lowerView.leadingAnchor, constant: 20),
            welcomeLabel.trailingAnchor.constraint(equalTo: lowerView.trailingAnchor, constant: -20),
            welcomeLabel.heightAnchor.constraint(equalToConstant: 70)
        ])
    }
    
    private func setupTextFieldStackConstraints() {
        lowerView.addSubview(textFieldStack)
        NSLayoutConstraint.activate([
            textFieldStack.topAnchor.constraint(equalTo: welcomeLabel.bottomAnchor, constant: 80),
            textFieldStack.leadingAnchor.constraint(equalTo: lowerView.leadingAnchor, constant: 10),
            textFieldStack.trailingAnchor.constraint(equalTo: lowerView.trailingAnchor, constant: -10),
            textFieldStack.heightAnchor.constraint(equalToConstant: 140)
        ])
    }
    
    private func setupSignInButtonConstraints() {
        lowerView.addSubview(signInButton)
        NSLayoutConstraint.activate([
            signInButton.topAnchor.constraint(equalTo: textFieldStack.bottomAnchor, constant: 22),
            signInButton.leadingAnchor.constraint(equalTo: lowerView.leadingAnchor, constant: 10),
            signInButton.trailingAnchor.constraint(equalTo: lowerView.trailingAnchor, constant: -10),
            signInButton.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
    
    private func setupCreateButtonConstraints() {
        lowerView.addSubview(createStack)
        NSLayoutConstraint.activate([
            createStack.bottomAnchor.constraint(equalTo: lowerView.bottomAnchor, constant: -40),
            createStack.centerXAnchor.constraint(equalTo: lowerView.centerXAnchor, constant: 0),
            createStack.heightAnchor.constraint(equalToConstant: 55),
            createStack.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width / 2)
        ])
    }
    
    private func setupActivityIndicatorConstraints() {
        view.addSubview(activityIndicator)
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.topAnchor.constraint(equalTo: welcomeLabel.bottomAnchor, constant: 40)
        ])
    }
}

// MARK: - TextFieldDelegate

extension AuthViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case emailTextField:
            passwordTextField.becomeFirstResponder()
        case passwordTextField:
            passwordTextField.resignFirstResponder()
        default:
            textField.resignFirstResponder()
        }
        return true
    }
}
