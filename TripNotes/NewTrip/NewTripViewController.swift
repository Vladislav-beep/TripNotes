//
//  NewTripViewController.swift
//  TripNotes
//
//  Created by Владислав Сизонов on 21.12.2021.
//

import UIKit


class NewTripViewController: UIViewController {
    
    var viewModel: NewTripViewModelProtocol?
   
    
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
    
    private lazy var avatarImageView: UIImageView = {
        let avatarImageView = UIImageView()
        avatarImageView.backgroundColor = .tripRed
        avatarImageView.image = UIImage(named: Constants.ImageNames.tripPlaceHolderImage.rawValue)
        avatarImageView.clipsToBounds = true
        avatarImageView.contentMode = .scaleAspectFill
        avatarImageView.layer.opacity = 0.8
        avatarImageView.addGestureRecognizer(tapGestureRecognizer)
        avatarImageView.isUserInteractionEnabled = true
        avatarImageView.translatesAutoresizingMaskIntoConstraints = false
        return avatarImageView
    }()
    
    private lazy var redView: UIView = {
        let redView = UIView()
        redView.backgroundColor = .tripRed
        redView.layer.opacity = 0.6
        redView.layer.cornerRadius = 4
        redView.translatesAutoresizingMaskIntoConstraints = false
        return redView
    }()
    
    private lazy var backButton: UIButton = {
        let backButton = UIButton()
        let image = UIImage(systemName: "chevron.compact.left")
        backButton.tintColor = .tripWhite
        backButton.setBackgroundImage(image, for: .normal)
        backButton.addTarget(self, action: #selector(backButtonPressed), for: .touchUpInside)
        backButton.translatesAutoresizingMaskIntoConstraints = false
        return backButton
    }()
    
    private lazy var countryTextField: CustomTextField = {
        let countryTextField = CustomTextField(imageName: "flag")
        countryTextField.placeholder = "Country"
        return countryTextField
    }()
    
    private lazy var beginDateTextField: CustomTextField = {
        let beginDateTextField = CustomTextField(imageName: "calendar")
        beginDateTextField.placeholder = "Date when trip begins"
        return beginDateTextField
    }()
    
    private lazy var finishDateTextField: CustomTextField = {
        let finishDateTextField = CustomTextField(imageName: "calendar")
        finishDateTextField.placeholder = "Date when trip ends"
        return finishDateTextField
    }()
    
    private lazy var descriptionTextField: CustomTextField = {
        let descriptionTextField = CustomTextField(imageName: "pencil.and.outline")
        descriptionTextField.placeholder = "Describe your trip shortly"
        return descriptionTextField
    }()
    
    private lazy var textFieldsStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [countryTextField,
                                                   beginDateTextField,
                                                   finishDateTextField,
                                                   descriptionTextField],
                                axis: .vertical,
                                spacing: 20,
                                distribution: .fillEqually)
        return stack
    }()
    
    private lazy var dollarButton: CurrencyButton = {
        let dollarButton = CurrencyButton(title: "$")
        dollarButton.addTarget(self, action: #selector(selectCurrency(_:)), for: .touchUpInside)
        return dollarButton
    }()
    
    private lazy var rubleButton: CurrencyButton = {
        let rubleButton = CurrencyButton(title: "₽")
        rubleButton.addTarget(self, action: #selector(selectCurrency(_:)), for: .touchUpInside)
        return rubleButton
    }()
    
    private lazy var euroButton: CurrencyButton = {
        let euroButton = CurrencyButton(title: "€")
        euroButton.addTarget(self, action: #selector(selectCurrency(_:)), for: .touchUpInside)
        return euroButton
    }()
    
    private lazy var buttonArray: [UIButton] = {
        let array = [dollarButton, rubleButton, euroButton]
        return array
    }()
    
    private lazy var buttonStack: UIStackView = {
        let buttonStack = UIStackView(arrangedSubviews: [dollarButton, rubleButton, euroButton],
                                      axis: .horizontal,
                                      spacing: 14,
                                      distribution: .fillEqually)
        buttonStack.translatesAutoresizingMaskIntoConstraints = false
        return buttonStack
    }()
    
    private lazy var addNewTripButton: UIButton = {
        let addNewTripButton = UIButton()
        addNewTripButton.backgroundColor = .tripRed
        addNewTripButton.layer.cornerRadius = 10
        addNewTripButton.setTitle("Plan new Trip", for: .normal)
        addNewTripButton.translatesAutoresizingMaskIntoConstraints = false
        return addNewTripButton
    }()
    
    private lazy var tapGestureRecognizer: UITapGestureRecognizer = {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self,
                                                          action: #selector(setAvatarImage(_:)))
        
        return tapGestureRecognizer
    }()
    
    init(viewModel: NewTripViewModelProtocol) {
        super.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
        setupScrollViewConstraints()
        setupLowerViewConstraints()
        setupAvatarConstraints()
        setupRedViewConstraints()
        setupBackButtonConstraints()
        setupTextFieldsStackViewConstraints()
        setupAddNewTripButtonConstraints()
        setupCurrencyButtonsConstraints()
        
        registerKeyBoardNotification()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        removeKeyboardNotification()
    }
    
    @objc func backButtonPressed() {
        dismiss(animated: true)
    }
    
    @objc func selectCurrency(_ sender: UIButton) {
        buttonArray.forEach { $0.isSelected = false }
        sender.isSelected = true
    }
    
    @objc func setAvatarImage(_ sender: UITapGestureRecognizer) {
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let camera = UIAlertAction(title: "Camera", style: .default) { _ in
            self.chooseImagePicker(source: .camera)
        }
        
        let photo = UIAlertAction(title: "Gallery", style: .default) { _ in
            self.chooseImagePicker(source: .photoLibrary)
        }
        
        let cancel = UIAlertAction(title: "Cancel", style: .cancel)
        
        actionSheet.addAction(camera)
        actionSheet.addAction(photo)
        actionSheet.addAction(cancel)
        
        present(actionSheet, animated: true)
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
    
    private func setupAvatarConstraints() {
        lowerView.addSubview(avatarImageView)
        NSLayoutConstraint.activate([
            avatarImageView.topAnchor.constraint(equalTo: lowerView.topAnchor, constant: 0),
            avatarImageView.leadingAnchor.constraint(equalTo: lowerView.leadingAnchor, constant: 0),
            avatarImageView.trailingAnchor.constraint(equalTo: lowerView.trailingAnchor, constant: 0),
            avatarImageView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height / 4)
        ])
    }
    
    private func setupRedViewConstraints() {
        lowerView.addSubview(redView)
        NSLayoutConstraint.activate([
            redView.topAnchor.constraint(equalTo: lowerView.topAnchor, constant: 0),
            redView.leadingAnchor.constraint(equalTo: lowerView.leadingAnchor, constant: 10),
            redView.bottomAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: 20),
            redView.widthAnchor.constraint(equalToConstant: 60)
        ])
    }
    
    private func setupBackButtonConstraints() {
        lowerView.addSubview(backButton)
        NSLayoutConstraint.activate([
            backButton.topAnchor.constraint(equalTo: lowerView.topAnchor, constant: 10),
            backButton.leadingAnchor.constraint(equalTo: lowerView.leadingAnchor, constant: 27),
            backButton.heightAnchor.constraint(equalToConstant: 26),
            backButton.widthAnchor.constraint(equalToConstant: 26)
        ])
    }
    
    private func setupTextFieldsStackViewConstraints() {
        lowerView.addSubview(textFieldsStackView)
        NSLayoutConstraint.activate([
            textFieldsStackView.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: 40),
            textFieldsStackView.leadingAnchor.constraint(equalTo: lowerView.leadingAnchor, constant: 20),
            textFieldsStackView.trailingAnchor.constraint(equalTo: lowerView.trailingAnchor, constant: -20),
            textFieldsStackView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height * 0.344)
        ])
    }
    
    private func setupCurrencyButtonsConstraints() {
        lowerView.addSubview(buttonStack)
        NSLayoutConstraint.activate([
            buttonStack.topAnchor.constraint(equalTo: textFieldsStackView.bottomAnchor, constant: 20),
            buttonStack.centerXAnchor.constraint(equalTo: lowerView.centerXAnchor, constant: 0),
            buttonStack.heightAnchor.constraint(equalTo: textFieldsStackView.heightAnchor,
                                                multiplier: 0.28),
            buttonStack.widthAnchor.constraint(equalTo: buttonStack.heightAnchor, multiplier: 3)
        ])
    }
    
    private func setupAddNewTripButtonConstraints() {
        lowerView.addSubview(addNewTripButton)
        NSLayoutConstraint.activate([
            addNewTripButton.bottomAnchor.constraint(equalTo: lowerView.bottomAnchor, constant: -35),
            addNewTripButton.leadingAnchor.constraint(equalTo: lowerView.leadingAnchor, constant: 20),
            addNewTripButton.trailingAnchor.constraint(equalTo: lowerView.trailingAnchor, constant: -20),
            addNewTripButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}

extension NewTripViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func chooseImagePicker(source: UIImagePickerController.SourceType) {
        if UIImagePickerController.isSourceTypeAvailable(source) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.allowsEditing = true
            imagePicker.sourceType = source
            present(imagePicker, animated: true)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        avatarImageView.image = info[.editedImage] as? UIImage
        avatarImageView.contentMode = .scaleAspectFill
        avatarImageView.clipsToBounds = true
        
        dismiss(animated: true)
    }
}

extension NewTripViewController {
    
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
        scrollView.contentOffset = CGPoint(x: 0, y: (keyboardFrame?.height ?? 0) / 2)
    }
    
    @objc private func keyboardWillHide(notification: Notification) {
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
