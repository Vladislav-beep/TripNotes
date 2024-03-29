//
//  NewTripViewController.swift
//  TripNotes
//
//  Created by Владислав Сизонов on 21.12.2021.
//

import UIKit

class NewTripViewController: UIViewController {
    
    // MARK: - Dependencies
    
    private var viewModel: NewTripViewModelProtocol?
    private lazy var keyboard = KeyboardHelper(scrollView: scrollView, offSet: 100)
    private lazy var animator = Animator(container: view)
    
    // MARK: - Properties
    
    var isEdited: Bool?
    
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
    
    private lazy var avatarImageView: UIImageView = {
        let avatarImageView = UIImageView()
        avatarImageView.backgroundColor = .tripRed
        avatarImageView.image = UIImage(named: C.ImageNames.tripPlaceHolder.rawValue)
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
        let countryTextField = CustomTextField(imageName: C.ImageNames.country.rawValue)
        countryTextField.placeholder = I.countryTextFieldPlaceHolder
        return countryTextField
    }()
    
    private lazy var beginDateTextField: CustomTextField = {
        let beginDateTextField = CustomTextField(imageName: C.ImageNames.calendar.rawValue)
        beginDateTextField.placeholder = I.beginDateTextFieldPlaceHolder
        beginDateTextField.setInputViewDatePicker(target: self, selector: #selector(tapBeginningDate))
        return beginDateTextField
    }()
    
    private lazy var finishDateTextField: CustomTextField = {
        let finishDateTextField = CustomTextField(imageName: C.ImageNames.calendar.rawValue)
        finishDateTextField.placeholder = I.finishDateTextFieldPlaceHolder
        finishDateTextField.setInputViewDatePicker(target: self, selector: #selector(tapfinishingDate))
        return finishDateTextField
    }()
    
    private lazy var descriptionTextField: CustomTextField = {
        let descriptionTextField = CustomTextField(imageName: C.ImageNames.description.rawValue)
        descriptionTextField.placeholder = I.descriptionTextFieldPlaceHolder
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
        let dollarButton = SelectionButton(title: Currency.dollar.rawValue, fontSize: 30)
        dollarButton.addTarget(self, action: #selector(selectCurrency(_:)), for: .touchUpInside)
        return dollarButton
    }()
    
    private lazy var rubleButton: SelectionButton = {
        let rubleButton = SelectionButton(title: Currency.ruble.rawValue, fontSize: 30)
        rubleButton.addTarget(self, action: #selector(selectCurrency(_:)), for: .touchUpInside)
        return rubleButton
    }()
    
    private lazy var euroButton: SelectionButton = {
        let euroButton = SelectionButton(title: Currency.euro.rawValue, fontSize: 30)
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
        let addNewTripButton = AddButton(imageName: nil, title: I.addNewTripButtonTitle, cornerRadius: 10)
        addNewTripButton.titleLabel?.font = .systemFont(ofSize: 20, weight: .regular)
        addNewTripButton.addTarget(self, action: #selector(addTrip), for: .touchUpInside)
        return addNewTripButton
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
    
    // MARK: - Life Time
    
    init(viewModel: NewTripViewModelProtocol, isEdited: Bool) {
        super.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
        self.isEdited = isEdited
        setupConstraints()
        keyboard.registerKeyBoardNotification()
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
        keyboard.removeKeyboardNotification()
    }
    
    // MARK: - Actions
    
    @objc private func addTrip() {
        guard let country = countryTextField.text, country != "",
              let description = descriptionTextField.text, description != "",
              let beginningDateText = beginDateTextField.text, beginningDateText != "",
              let finishingDateText = finishDateTextField.text, finishingDateText != ""
        else {
            showAlert(title: I.error, message: I.emptyFieldsWarning)
            return
        }
        
        var currency = ""
        for button in buttonArray {
            if button.backgroundColor == UIColor.tripRed {
                currency = button.titleLabel?.text ?? Currency.dollar.rawValue
            }
        }
        
        guard currency != "" else {
            showAlert(title: I.error, message: I.currencyWarning)
            return
        }
        
        let dateformatter = DateFormatter()
        dateformatter.dateStyle = .medium
        
        guard let bdate = dateformatter.date(from: beginningDateText) else { return }
        guard let fdate = dateformatter.date(from: finishingDateText) else { return }
        
        guard bdate <= fdate else {
            showAlert(title: I.error, message: I.dateWarning)
            return
            
        }
        
        if self.isEdited ?? false {
            viewModel?.updateTrip(country: country, currency: currency, description: description, beginningDate: bdate , finishingDate: fdate , completion: { [weak self] docId in
                self?.updateImageAndCloseScreen(forKey: docId)
            }, errorCompletion: { [weak self] in
                self?.showAlert(title: I.updateTripAlertTitle,
                                message: I.errorConnectionAlertMessage)
                return
            })
        } else {
            viewModel?.addTrip(country: country, currency: currency, description: description, beginningDate: bdate , finishingDate: fdate , completion: { [weak self] docId in
                self?.updateImageAndCloseScreen(forKey: docId)
            }, errorCompletion: { [weak self] in
                self?.showAlert(title: I.addTripAlertTitle,
                                message: I.errorConnectionAlertMessage)
                return
            })
        }
    }
    
    @objc private func tapBeginningDate() {
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
    
    @objc func tapfinishingDate() {
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
    
    @objc private func backButtonPressed() {
        dismiss(animated: true)
    }
    
    @objc private func selectCurrency(_ sender: SelectionButton) {
        buttonArray.forEach {
            $0.isSelected = false
            $0.stopAnimation()
        }
        sender.isSelected = true
        sender.pulsate()
    }
    
    @objc private func setAvatarImage(_ sender: UITapGestureRecognizer) {
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let camera = UIAlertAction(title: I.cameraActionSheet, style: .default) { _ in
            self.chooseImagePicker(source: .camera)
        }
        camera.setValue(UIImage(named: "cameraSheet"), forKey: "image")
        camera.setValue(CATextLayerAlignmentMode.left, forKey: "titleTextAlignment")
        
        let photo = UIAlertAction(title: I.galleryActionSheet, style: .default) { _ in
            self.chooseImagePicker(source: .photoLibrary)
        }
        photo.setValue(UIImage(named: "photoSheet"), forKey: "image")
        photo.setValue(CATextLayerAlignmentMode.left, forKey: "titleTextAlignment")
        
        let placeHolderImage = UIAlertAction(title: I.placeHolderActionSheet, style: .default) { _ in
            self.avatarImageView.image = UIImage(named: C.ImageNames.tripPlaceHolder.rawValue)
        }
        placeHolderImage.setValue(UIImage(named: "placeholderSheet"), forKey: "image")
        placeHolderImage.setValue(CATextLayerAlignmentMode.left, forKey: "titleTextAlignment")
        
        let deleteImage = UIAlertAction(title: I.deleteActionSheet, style: .default) { _ in
            self.avatarImageView.image = nil
        }
        deleteImage.setValue(UIImage(named: "deleteSheet"), forKey: "image")
        deleteImage.setValue(CATextLayerAlignmentMode.left, forKey: "titleTextAlignment")
        
        let cancel = UIAlertAction(title: I.cancelActionSheet, style: .cancel)
        
        actionSheet.addAction(camera)
        actionSheet.addAction(photo)
        actionSheet.addAction(cancel)
        actionSheet.addAction(placeHolderImage)
        actionSheet.addAction(deleteImage)
        
        present(actionSheet, animated: true)
    }
    
    // MARK: - Private methods
    
    private func setupDelegates() {
        countryTextField.delegate = self
        beginDateTextField.delegate = self
        finishDateTextField.delegate = self
        descriptionTextField.delegate = self
    }
    
    private func setupUI() {
        if isEdited ?? false {
            addNewTripButton.backgroundColor = .tripBlue
            addNewTripButton.setTitle(I.addNewTripEditButtonTitle, for: .normal)
            addNewTripButton.setImage(UIImage(systemName: C.ImageNames.editIcon.rawValue), for: .normal)
            redView.backgroundColor = .tripBlue
            let imageData = viewModel?.retrieveImage()
            avatarImageView.image = UIImage(data: imageData ?? Data())
            
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
            case Currency.dollar.rawValue:
                self?.dollarButton.pulsate()
                self?.dollarButton.backgroundColor = .tripRed
                
            case Currency.euro.rawValue:
                self?.euroButton.pulsate()
                self?.euroButton.backgroundColor = .tripRed
                
            case Currency.ruble.rawValue:
                self?.rubleButton.pulsate()
                self?.rubleButton.backgroundColor = .tripRed
                
            default:
                break
            }
        }
        
        viewModel?.errorCompletion = { [weak self] error in
            self?.showAlert(title: I.fetchTripAlertTitle, message: error.errorDescription)
        }
    }
    
    private func updateImageAndCloseScreen(forKey key: String) {
        if avatarImageView.image == UIImage() {
            viewModel?.deleteImage(forKey: key)
        } else {
            
            let imageData = self.avatarImageView.image?.pngData()
            self.viewModel?.saveImage(data: imageData ?? Data(), key: key)
        }
        self.dismiss(animated: true)
    }
    
    // MARK: - Layout
    
    private func setupConstraints() {
        setupScrollViewConstraints()
        setupLowerViewConstraints()
        setupAvatarConstraints()
        setupRedViewConstraints()
        setupBackButtonConstraints()
        setupTextFieldsStackViewConstraints()
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

// MARK: - ImagePicker
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

// MARK: - TextFieldDelegate
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
