//
//  NewTripViewController.swift
//  TripNotes
//
//  Created by Владислав Сизонов on 21.12.2021.
//

import UIKit


class NewTripViewController: UIViewController {
    
    // MARK: Dependencies
    
    private var viewModel: NewTripViewModelProtocol?
    var coordinator: AppCoordinator?
    lazy var animator = Animator(container: view)
    
    // MARK: Properties
    
    var isEdited: Bool?
    
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
    
    private lazy var backButton: BackButton = {
        let backButton = BackButton()
        backButton.addTarget(self, action: #selector(backButtonPressed), for: .touchUpInside)
        return backButton
    }()
    
    private lazy var countryTextField: CustomTextField = {
        let countryTextField = CustomTextField(imageName: "flag-edit")
        countryTextField.placeholder = "Country"
        return countryTextField
    }()
    
    private lazy var beginDateTextField: CustomTextField = {
        let beginDateTextField = CustomTextField(imageName: "calendar-edit")
        beginDateTextField.placeholder = "Date when trip begins"
        beginDateTextField.setInputViewDatePicker(target: self, selector: #selector(tapDone))
        return beginDateTextField
    }()
    
    private lazy var finishDateTextField: CustomTextField = {
        let finishDateTextField = CustomTextField(imageName: "calendar-edit")
        finishDateTextField.placeholder = "Date when trip ends"
        finishDateTextField.setInputViewDatePicker(target: self, selector: #selector(tapDone3))
        return finishDateTextField
    }()
    
    private lazy var descriptionTextField: CustomTextField = {
        let descriptionTextField = CustomTextField(imageName: "pencil-edit")
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
    
    private lazy var dollarButton: SelectionButton = {
        let dollarButton = SelectionButton(title: "$", fontSize: 30)
        dollarButton.addTarget(self, action: #selector(selectCurrency(_:)), for: .touchUpInside)
        return dollarButton
    }()
    
    private lazy var rubleButton: SelectionButton = {
        let rubleButton = SelectionButton(title: "₽", fontSize: 30)
        rubleButton.addTarget(self, action: #selector(selectCurrency(_:)), for: .touchUpInside)
        return rubleButton
    }()
    
    private lazy var euroButton: SelectionButton = {
        let euroButton = SelectionButton(title: "€", fontSize: 30)
        euroButton.addTarget(self, action: #selector(selectCurrency(_:)), for: .touchUpInside)
        return euroButton
    }()
    
    private lazy var buttonArray: [SelectionButton] = {
        let array = [dollarButton, rubleButton, euroButton]
        return array
    }()
    
    private lazy var buttonStack: UIStackView = {
        let buttonStack = UIStackView(arrangedSubviews: [dollarButton, rubleButton, euroButton],
                                      axis: .horizontal,
                                      spacing: 14,
                                      distribution: .fillEqually)
        return buttonStack
    }()
    
    private lazy var addNewTripButton: AddButton = {
        let addNewTripButton = AddButton(imageName: nil, title: "+ Add Trip", cornerRadius: 10)
        addNewTripButton.titleLabel?.font = .systemFont(ofSize: 20, weight: .regular)
        addNewTripButton.addTarget(self, action: #selector(addTrip), for: .touchUpInside)
        return addNewTripButton
    }()
    
    
    
    private lazy var warningLabel: WarningLabel = {
        let warningLabel = WarningLabel(fontSize: 16)
        return warningLabel
    }()
    
    private lazy var tapGestureRecognizer: UITapGestureRecognizer = {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self,
                                                          action: #selector(setAvatarImage(_:)))
        return tapGestureRecognizer
    }()
    
    private lazy var endEditingGestureRecognizer: UITapGestureRecognizer = {
        let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        return tap
    }()
    
    // MARK: Life Time
    
    init(viewModel: NewTripViewModelProtocol, isEdited: Bool) {
        super.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
        self.isEdited = isEdited
        setupConstraints()
        registerKeyBoardNotification()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupDelegates()
        setupViewModelBindings()
        setupUI()
        view.addGestureRecognizer(endEditingGestureRecognizer)
    }
    
    deinit {
        removeKeyboardNotification()
    }
    
    // MARK: Actions
    
    @objc func addTrip() {
        guard let country = countryTextField.text,
              country != "",
              let description = descriptionTextField.text,
              description != "",
              let beginningDateText = beginDateTextField.text,
              beginningDateText != "",
              let finishingDateText = finishDateTextField.text,
              finishingDateText != ""
        else {
            let warningText = "None of fields can be empty"
            animator.animateWarningLabel(warningLabel: warningLabel, withText: warningText)
            return
        }
        
        var currency = ""
        for button in buttonArray {
            if button.backgroundColor == UIColor.tripRed {
                currency = button.titleLabel?.text ?? "$"
            }
        }
        
        guard currency != "" else {
            let currencyWarningText = "Choose currency"
            animator.animateWarningLabel(warningLabel: warningLabel, withText: currencyWarningText)
            return
        }
        
        let dateformatter = DateFormatter()
        dateformatter.dateStyle = .medium
        
        let bdate = dateformatter.date(from: beginningDateText)
        let fdate = dateformatter.date(from: finishingDateText)
        
        if isEdited ?? false {
            viewModel?.updateTrip(country: country, currency: currency, description: description, beginningDate: bdate ?? Date(), finishingDate: fdate ?? Date())
        } else {
            viewModel?.addTrip(country: country, currency: currency, description: description, beginningDate: bdate ?? Date(), finishingDate: fdate ?? Date())
        }
        dismiss(animated: true)
    }
    
    @objc func tapDone() {
        if let inputView = beginDateTextField.inputView {
            let dateformatter = DateFormatter()
            dateformatter.dateStyle = .medium
            var datePicker = UIDatePicker()
            for subview in inputView.subviews {
                if subview is UIDatePicker {
                    datePicker = subview as! UIDatePicker
                }
            }
            beginDateTextField.text = dateformatter.string(from: datePicker.date)
        }
        finishDateTextField.becomeFirstResponder()
    }
    
    @objc func tapDone3() {
        if let inputView = finishDateTextField.inputView {
            let dateformatter = DateFormatter()
            dateformatter.dateStyle = .medium
            var datePicker = UIDatePicker()
            for subview in inputView.subviews {
                if subview is UIDatePicker {
                    datePicker = subview as! UIDatePicker
                }
            }
            finishDateTextField.text = dateformatter.string(from: datePicker.date)
        }
        descriptionTextField.becomeFirstResponder()
    }
    
    //    @objc func tapDone2(_ sender: CustomTextField) {
    //        if let inputView = sender.inputView {
    //            let dateformatter = DateFormatter()
    //            dateformatter.dateStyle = .medium
    //            var datePicker = UIDatePicker()
    //            for subview in inputView.subviews {
    //                if subview is UIDatePicker {
    //                    datePicker = subview as? UIDatePicker ?? UIDatePicker()
    //                }
    //            }
    //            sender.text = dateformatter.string(from: datePicker.date)
    //        }
    //        switch sender {
    //        case beginDateTextField:
    //            finishDateTextField.becomeFirstResponder()
    //        case finishDateTextField:
    //            descriptionTextField.becomeFirstResponder()
    //        default:
    //            finishDateTextField.becomeFirstResponder()
    //        }
    //        descriptionTextField.becomeFirstResponder()
    //    }
    
    @objc func backButtonPressed() {
        dismiss(animated: true)
    }
    
    @objc func selectCurrency(_ sender: SelectionButton) {
        buttonArray.forEach {
            $0.isSelected = false
            $0.stopAnimation()
        }
        sender.isSelected = true
        sender.pulsate()
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
    
    // MARK: Private methods
    
    private func setupDelegates() {
        countryTextField.delegate = self
        beginDateTextField.delegate = self
        finishDateTextField.delegate = self
        descriptionTextField.delegate = self
    }
    
    private func setupUI() {
        if isEdited ?? false {
            addNewTripButton.backgroundColor = .tripBlue
            addNewTripButton.setTitle(" Edit Trip", for: .normal)
            addNewTripButton.setImage(UIImage(systemName: "square.and.pencil"), for: .normal)
            redView.backgroundColor = .tripBlue
            viewModel?.downloadTrip()
        }
    }
    
    private func setupViewModelBindings() {
        viewModel?.tripCompletion = { [weak self] in
            self?.countryTextField.text = self?.viewModel?.country
            self?.beginDateTextField.text = self?.viewModel?.beginningDate
            self?.finishDateTextField.text = self?.viewModel?.finishingDate
            self?.descriptionTextField.text = self?.viewModel?.description
            
            let currency = self?.viewModel?.currency
            switch currency {
            case "$":
                self?.dollarButton.pulsate()
                self?.dollarButton.backgroundColor = .tripRed
            case "€":
                self?.euroButton.pulsate()
                self?.euroButton.backgroundColor = .tripRed
            case "₽":
                self?.rubleButton.pulsate()
                self?.rubleButton.backgroundColor = .tripRed
            default:
                break
            }
        }
    }
    
    // MARK: Layout
    
    private func setupConstraints() {
        setupScrollViewConstraints()
        setupLowerViewConstraints()
        setupAvatarConstraints()
        setupRedViewConstraints()
        setupBackButtonConstraints()
        setupTextFieldsStackViewConstraints()
        setupWarningLabelConstraints()
        setupAddNewTripButtonConstraints()
        setupCurrencyButtonsConstraints()
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
    
    private func setupWarningLabelConstraints() {
        lowerView.addSubview(warningLabel)
        NSLayoutConstraint.activate([
            warningLabel.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: 5),
            warningLabel.leadingAnchor.constraint(equalTo: lowerView.leadingAnchor, constant: 20),
            warningLabel.trailingAnchor.constraint(equalTo: lowerView.trailingAnchor, constant: -20),
            warningLabel.bottomAnchor.constraint(equalTo: textFieldsStackView.topAnchor, constant: -5),
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
            backButton.topAnchor.constraint(equalTo: lowerView.topAnchor, constant: 30),
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
            addNewTripButton.heightAnchor.constraint(equalToConstant: 58)
        ])
    }
}

// MARK: ImagePicker

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

// MARK: TextFieldDelegate

extension NewTripViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case countryTextField:
            beginDateTextField.becomeFirstResponder()
        case beginDateTextField:
            finishDateTextField.becomeFirstResponder()
        case finishDateTextField:
            descriptionTextField.becomeFirstResponder()
        case descriptionTextField:
            descriptionTextField.resignFirstResponder()
        default:
            descriptionTextField.resignFirstResponder()
        }
        return true
    }
}

// MARK: Keyboard methods

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
