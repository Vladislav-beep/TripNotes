//
//  NewAccountViewController.swift
//  TripNotes
//
//  Created by Владислав Сизонов on 25.01.2022.
//

import UIKit

class NewAccountViewController: UIViewController {
    
    // MARK: Dependencies
    
    private var viewModel: NewAccountViewModelProtocol
    
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
    
    private lazy var createNewAccountLabel: UILabel = {
        let welcomeLabel = UILabel()
        welcomeLabel.numberOfLines = 1
        welcomeLabel.text = "Create new account"
        welcomeLabel.textAlignment = .center
        welcomeLabel.textColor = .tripBlue
        welcomeLabel.adjustsFontSizeToFitWidth = true
        welcomeLabel.font = UIFont.systemFont(ofSize: 30, weight: .regular)
        welcomeLabel.translatesAutoresizingMaskIntoConstraints = false
        return welcomeLabel
    }()
    
    private lazy var nameTextField: AuthTextField = {
        let nameTextField = AuthTextField(placeHolder: "Name")
        return nameTextField
    }()
    
    private lazy var loginTextField: AuthTextField = {
        let loginTextField = AuthTextField(placeHolder: "Login")
        return loginTextField
    }()
    
    private lazy var passwordTextField: AuthTextField = {
        let passwordTextField = AuthTextField(placeHolder: "Password")
        return passwordTextField
    }()
    
    private let signUpButton: SignInButton = {
        let signInButton = SignInButton()
        return signInButton
    }()
    
    private lazy var textFieldStack: UIStackView = {
        let textFieldStack = UIStackView(arrangedSubviews: [nameTextField, loginTextField, passwordTextField],
                                         axis: .vertical,
                                         spacing: 16,
                                         distribution: .fillEqually)
        return textFieldStack
    }()
    
    private lazy var haveLabel: UILabel = {
        let createLabel = UILabel()
        createLabel.text = "Already have an account"
        createLabel.textAlignment = .center
        createLabel.textColor = .tripBlue
        createLabel.layer.opacity = 0.5
        createLabel.translatesAutoresizingMaskIntoConstraints = false
        return createLabel
    }()
    
    private lazy var logInButton: UIButton = {
        let createButton = UIButton()
        createButton.setTitle("Log in now", for: .normal)
        createButton.setTitleColor(.tripBlue, for: .normal)
       // createButton.addTarget(self, action: #selector(createNewAccount), for: .touchUpInside)
        createButton.translatesAutoresizingMaskIntoConstraints = false
        return createButton
    }()
    
    private lazy var logInStack: UIStackView = {
        let createStack = UIStackView(arrangedSubviews: [haveLabel, logInButton],
                                         axis: .vertical,
                                         spacing: 8,
                                         distribution: .fillEqually)
        return createStack
    }()
    
    // MARK: Life Time
    
    init(viewModel: NewAccountViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupConstraints()
    }
    
    // MARK: Layout
    
    private func setupConstraints() {
        setupScrollViewConstraints()
        setupLowerViewConstraints()
        setupCreateNewAccountLabelConstraints()
        setupTextFieldStackConstraints()
        setupSignUpButtonConstraints()
        setupLogInConstraints()
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
    
    private func setupCreateNewAccountLabelConstraints() {
        lowerView.addSubview(createNewAccountLabel)
        NSLayoutConstraint.activate([
            createNewAccountLabel.topAnchor.constraint(equalTo: lowerView.topAnchor, constant: 60),
            createNewAccountLabel.leadingAnchor.constraint(equalTo: lowerView.leadingAnchor, constant: 20),
            createNewAccountLabel.trailingAnchor.constraint(equalTo: lowerView.trailingAnchor, constant: -20),
            createNewAccountLabel.heightAnchor.constraint(equalToConstant: 70)
        ])
    }
    
    private func setupTextFieldStackConstraints() {
        lowerView.addSubview(textFieldStack)
        NSLayoutConstraint.activate([
            textFieldStack.topAnchor.constraint(equalTo: createNewAccountLabel.bottomAnchor, constant: 65),
            textFieldStack.leadingAnchor.constraint(equalTo: lowerView.leadingAnchor, constant: 10),
            textFieldStack.trailingAnchor.constraint(equalTo: lowerView.trailingAnchor, constant: -10),
            textFieldStack.heightAnchor.constraint(equalToConstant: 218)
        ])
    }
    
    private func setupSignUpButtonConstraints() {
        lowerView.addSubview(signUpButton)
        NSLayoutConstraint.activate([
            signUpButton.topAnchor.constraint(equalTo: textFieldStack.bottomAnchor, constant: 22),
            signUpButton.leadingAnchor.constraint(equalTo: lowerView.leadingAnchor, constant: 10),
            signUpButton.trailingAnchor.constraint(equalTo: lowerView.trailingAnchor, constant: -10),
            signUpButton.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
    
    private func setupLogInConstraints() {
        lowerView.addSubview(logInStack)
        NSLayoutConstraint.activate([
            logInStack.bottomAnchor.constraint(equalTo: lowerView.bottomAnchor, constant: -50),
            logInStack.centerXAnchor.constraint(equalTo: lowerView.centerXAnchor, constant: 0),
            logInStack.heightAnchor.constraint(equalToConstant: 55),
            logInStack.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width / 2)
        ])
    }
}
