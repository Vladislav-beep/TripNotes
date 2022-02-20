//
//  AuthViewController.swift
//  TripNotes
//
//  Created by Владислав Сизонов on 24.01.2022.
//

import UIKit
import Firebase

class AuthViewController: UIViewController {
    
    // MARK: Dependencies
    
    private var viewModel: AuthViewModelProtocol
    var coordinator: AppCoordinator?
    
    // MARK: UI
    
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
    
    private lazy var welcomeLabel: UILabel = {
        let welcomeLabel = UILabel()
        welcomeLabel.numberOfLines = 2
        welcomeLabel.text = "Welcome to \n TripNotes"
        welcomeLabel.textAlignment = .center
        welcomeLabel.textColor = .tripBlue
        welcomeLabel.adjustsFontSizeToFitWidth = true
        welcomeLabel.font = UIFont.systemFont(ofSize: 30, weight: .regular)
        welcomeLabel.translatesAutoresizingMaskIntoConstraints = false
        return welcomeLabel
    }()
    
    private lazy var loginTextField: AuthTextField = {
        let loginTextField = AuthTextField(placeHolder: "Login")
        return loginTextField
    }()
    
    private lazy var passwordTextField: AuthTextField = {
        let passwordTextField = AuthTextField(placeHolder: "Password")
        return passwordTextField
    }()
    
    private let signInButton: SignInButton = {
        let signInButton = SignInButton()
        signInButton.addTarget(self, action: #selector(showTabbar), for: .touchUpInside)
        return signInButton
    }()
    
    private lazy var textFieldStack: UIStackView = {
        let textFieldStack = UIStackView(arrangedSubviews: [loginTextField, passwordTextField],
                                         axis: .vertical,
                                         spacing: 16,
                                         distribution: .fillEqually)
        return textFieldStack
    }()
    
    private lazy var createLabel: UILabel = {
        let createLabel = UILabel()
        createLabel.text = "I don't have an account"
        createLabel.textAlignment = .center
        createLabel.textColor = .tripBlue
        createLabel.layer.opacity = 0.5
        createLabel.translatesAutoresizingMaskIntoConstraints = false
        return createLabel
    }()
    
    private lazy var createButton: UIButton = {
        let createButton = UIButton()
        createButton.setTitle("Create new account", for: .normal)
        createButton.setTitleColor(.tripBlue, for: .normal)
        createButton.addTarget(self, action: #selector(createNewAccount), for: .touchUpInside)
        createButton.translatesAutoresizingMaskIntoConstraints = false
        return createButton
    }()
    
    private lazy var createStack: UIStackView = {
        let createStack = UIStackView(arrangedSubviews: [createLabel, createButton],
                                         axis: .vertical,
                                         spacing: 8,
                                         distribution: .fillEqually)
        return createStack
    }()
    
    // MARK: Life Time
    
    init(viewModel: AuthViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupConstraints()
        let fire = FireBaseService()
        fire.listenToTrips(forUser: "NUXiX5zSMiwYxmtCBpzO")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
        navigationController?.view.backgroundColor = UIColor.white
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    // MARK: Actions
    
    @objc func createNewAccount() {
        coordinator?.showAccount()
    }
    
    @objc func showTabbar() {
        
        guard let email = loginTextField.text,
              let password = passwordTextField.text,
              email != "",
              password != "" else {
            return
        }
        
        viewModel.signIn(withEmail: email, password: password) {
            let tab = TabBarViewController()
            tab.modalPresentationStyle = .fullScreen
            self.present(tab, animated: true)
        }
    }
        
    deinit {
        print("auth deinit")
    }
    
    // MARK: Layout
    
    private func setupConstraints() {
        setupScrollViewConstraints()
        setupLowerViewConstraints()
        setupWelcomeLabelConstraints()
        setupTextFieldStackConstraints()
        setupSignInButtonConstraints()
        setupCreateButtonConstraints()
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
            welcomeLabel.topAnchor.constraint(equalTo: lowerView.topAnchor, constant: 60),
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
            createStack.bottomAnchor.constraint(equalTo: lowerView.bottomAnchor, constant: -100),
            createStack.centerXAnchor.constraint(equalTo: lowerView.centerXAnchor, constant: 0),
            createStack.heightAnchor.constraint(equalToConstant: 55),
            createStack.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width / 2)
        ])
    }
}
