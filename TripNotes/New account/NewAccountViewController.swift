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
    var configurator: Configurator?
    
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
    
    private lazy var createNewAccountLabel: CreateNewAccountLabel = {
        let createNewAccountLabel = CreateNewAccountLabel()
        return createNewAccountLabel
    }()
    
    private lazy var nameTextField: AuthTextField = {
        let nameTextField = AuthTextField(placeHolder: "Name")
        return nameTextField
    }()
    
    private lazy var loginTextField: AuthTextField = {
        let loginTextField = AuthTextField(placeHolder: "Email")
        return loginTextField
    }()
    
    private lazy var passwordTextField: AuthTextField = {
        let passwordTextField = AuthTextField(placeHolder: "Password")
        passwordTextField.isSecureTextEntry = true
        return passwordTextField
    }()
    
    private let signUpButton: SignInButton = {
        let signInButton = SignInButton(title: "Sign up")
        signInButton.addTarget(self, action: #selector(signUpTapped), for: .touchUpInside)
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
        let logInButton = UIButton()
        logInButton.setTitle("Log in now", for: .normal)
        logInButton.setTitleColor(.tripBlue, for: .normal)
        logInButton.addTarget(self, action: #selector(logInTapped), for: .touchUpInside)
        logInButton.translatesAutoresizingMaskIntoConstraints = false
        return logInButton
    }()
    
    private lazy var logInStack: UIStackView = {
        let createStack = UIStackView(arrangedSubviews: [haveLabel, logInButton],
                                      axis: .vertical,
                                      spacing: 8,
                                      distribution: .fillEqually)
        return createStack
    }()
    
    private lazy var endEditingGestureRecognizer: UITapGestureRecognizer = {
        let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        return tap
    }()
    
    // MARK: Life Time
    
    init(viewModel: NewAccountViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        registerKeyBoardNotification()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupConstraints()
        loginTextField.delegate = self
        passwordTextField.delegate = self
        nameTextField.delegate = self
        view.addGestureRecognizer(endEditingGestureRecognizer)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavBarAppearence()
        passwordTextField.text = ""
    }
    
    deinit {
        removeKeyboardNotification()
    }
    
    // MARK: Actions
    
    @objc func logInTapped() {
        dismiss(animated: true)
    }
    
    @objc func signUpTapped() {
        let email = loginTextField.text ?? ""
        let password = passwordTextField.text ?? ""
        let name = nameTextField.text ?? ""
        
        viewModel.createNewUser(withEmail: email, password: password, name: name) { [weak self] in
            let tabbar = self?.configurator?.configureTabbar() ?? UIViewController()
            self?.present(tabbar, animated: true)
         //   self?.coordinator?.showTabBar()
        } errorCompletion: {
            self.showAlert(title: "We have some problems",
                             message: "Please, check your internet connection")
        }
        return
    }
    
    // MARK: Private methods
    
    private func setupNavBarAppearence() {
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.backgroundColor = .white
        navigationItem.hidesBackButton = true
        navigationController?.navigationBar.standardAppearance = navBarAppearance
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
            logInStack.bottomAnchor.constraint(equalTo: lowerView.bottomAnchor, constant: -130),
            logInStack.centerXAnchor.constraint(equalTo: lowerView.centerXAnchor, constant: 0),
            logInStack.heightAnchor.constraint(equalToConstant: 55),
            logInStack.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width / 2)
        ])
    }
}

extension NewAccountViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case nameTextField:
            loginTextField.becomeFirstResponder()
        case loginTextField:
            passwordTextField.becomeFirstResponder()
        case passwordTextField:
            passwordTextField.resignFirstResponder()
        default:
            textField.resignFirstResponder()
        }
        return true
    }
}

// MARK: Keyboard methods

extension NewAccountViewController {
    
    private func registerKeyBoardNotification() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillShow),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillHide),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
    }
    
    @objc private func keyboardWillShow(notification: Notification) {
        let userInfo = notification.userInfo
        let keyboardFrame = (userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
        scrollView.contentOffset = CGPoint(x: 0, y: ((keyboardFrame?.height ?? 0) / 2))
    }
    
    @objc private func keyboardWillHide(notification: Notification) {
        let userInfo = notification.userInfo
        let keyboardFrame = (userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
        scrollView.contentOffset = CGPoint.zero
    }
    
    private func removeKeyboardNotification() {
        NotificationCenter.default.removeObserver(self,
                                                  name: UIResponder.keyboardWillShowNotification,
                                                  object: nil)
        
        NotificationCenter.default.removeObserver(self,
                                                  name: UIResponder.keyboardWillHideNotification,
                                                  object: nil)
    }
}
