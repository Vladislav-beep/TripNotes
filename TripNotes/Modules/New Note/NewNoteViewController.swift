//
//  NewNoteViewController.swift
//  TripNotes
//
//  Created by Владислав Сизонов on 11.01.2022.
//

import UIKit

class NewNoteViewController: UIViewController, UIScrollViewDelegate {
    
    // MARK: - Dependencies
    
    private var viewModel: NewNoteViewModelProtocol?
    private lazy var keyboard = KeyboardHelper(scrollView: scrollView, offSet: -50)
    private lazy var animator = Animator(container: view)
    var configurator: Configurator?
    
    // MARK: - Properties
    
    var isEdited: Bool
    
    // MARK: - Private properties
    
    private var address: String?
    
    // MARK: - UI
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.delegate = self
        scrollView.contentSize = CGSize(width: view.frame.size.width, height: 1000)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private lazy var lowerView: UIView = {
        let lowerView = UIView()
        lowerView.backgroundColor = .white
        lowerView.translatesAutoresizingMaskIntoConstraints = false
        return lowerView
    }()
    
    private lazy var closeButton: CloseButton = {
        let button = CloseButton()
        button.addTarget(self, action: #selector(backButtonPressed), for: .touchUpInside)
        return button
    }()
    
    private lazy var categoryLabel: UILabel = {
        let categoryLabel = SectionLabel(labelText: I.categoryLabelText)
        return categoryLabel
    }()
    
    private lazy var transportLabel: UILabel = {
        let transportLabel = SelectionLabel(labelText: Category.transport.rawValue)
        return transportLabel
    }()
    
    private lazy var hotelLabel: UILabel = {
        let hotelLabel = SelectionLabel(labelText: Category.hotels.rawValue)
        return hotelLabel
    }()
    
    private lazy var foodLabel: UILabel = {
        let foodLabel = SelectionLabel(labelText: Category.food.rawValue)
        return foodLabel
    }()
    
    private lazy var activityLabel: UILabel = {
        let activityLabel = SelectionLabel(labelText: Category.activity.rawValue)
        return activityLabel
    }()
    
    private lazy var purhaseLabel: UILabel = {
        let perhaseLabel = SelectionLabel(labelText: Category.purchases.rawValue)
        return perhaseLabel
    }()
    
    private lazy var otherLabel: SelectionLabel = {
        let otherLabel = SelectionLabel(labelText: Category.other.rawValue)
        return otherLabel
    }()
    
    private lazy var transportButton: SelectionButton = {
        let transportButton = SelectionButton()
        transportButton.tag = 1
        transportButton.setImage(imageName: C.ImageNames.transport.rawValue)
        transportButton.addTarget(self, action: #selector(selectCategory(_:)), for: .touchUpInside)
        return transportButton
    }()
    
    private lazy var hotelsButton: SelectionButton = {
        let hotelsButton = SelectionButton()
        hotelsButton.tag = 2
        hotelsButton.setImage(imageName: C.ImageNames.hotel.rawValue)
        hotelsButton.addTarget(self, action: #selector(selectCategory(_:)), for: .touchUpInside)
        return hotelsButton
    }()
    
    private lazy var foodButton: SelectionButton = {
        let foodButton = SelectionButton()
        foodButton.tag = 3
        foodButton.setImage(imageName: C.ImageNames.food.rawValue)
        foodButton.addTarget(self, action: #selector(selectCategory(_:)), for: .touchUpInside)
        return foodButton
    }()
    
    private lazy var activityButton: SelectionButton = {
        let activityButton = SelectionButton()
        activityButton.tag = 4
        activityButton.setImage(imageName: C.ImageNames.activity.rawValue)
        activityButton.addTarget(self, action: #selector(selectCategory(_:)), for: .touchUpInside)
        return activityButton
    }()
    
    private lazy var purchaseButton: SelectionButton = {
        let purchaseButton = SelectionButton()
        purchaseButton.tag = 5
        purchaseButton.setImage(imageName: C.ImageNames.purchases.rawValue)
        purchaseButton.addTarget(self, action: #selector(selectCategory(_:)), for: .touchUpInside)
        return purchaseButton
    }()
    
    private lazy var otherButton: SelectionButton = {
        let otherButton = SelectionButton()
        otherButton.tag = 6
        otherButton.setImage(imageName: C.ImageNames.other.rawValue)
        otherButton.addTarget(self, action: #selector(selectCategory(_:)), for: .touchUpInside)
        return otherButton
    }()
    
    private lazy var buttonArray: [SelectionButton] = {
        let array = [transportButton, hotelsButton, foodButton, activityButton, purchaseButton, otherButton]
        return array
    }()
    
    private lazy var transportStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [transportLabel, transportButton], axis: .vertical, spacing: 5, distribution: .fillProportionally)
        return stack
    }()
    
    private lazy var hotelStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [hotelLabel, hotelsButton], axis: .vertical, spacing: 5, distribution: .fillProportionally)
        return stack
    }()
    
    private lazy var foodStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [foodLabel, foodButton], axis: .vertical, spacing: 5, distribution: .fillProportionally)
        return stack
    }()
    
    private lazy var activityStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [activityLabel, activityButton], axis: .vertical, spacing: 5, distribution: .fillProportionally)
        return stack
    }()
    
    private lazy var perhaseStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [purhaseLabel, purchaseButton], axis: .vertical, spacing: 5, distribution: .fillProportionally)
        return stack
    }()
    
    private lazy var otherStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [otherLabel, otherButton], axis: .vertical, spacing: 5, distribution: .fillProportionally)
        return stack
    }()
    
    private lazy var categoryOneStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [transportStackView, hotelStackView, foodStackView], axis: .horizontal, spacing: 5, distribution: .fillEqually)
        return stack
    }()
    
    private lazy var categoryTwoStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [activityStackView, perhaseStackView, otherStackView], axis: .horizontal, spacing: 5, distribution: .fillEqually)
        return stack
    }()
    
    private lazy var cityLabel: SectionLabel = {
        let label = SectionLabel(labelText: I.cityLabelText)
        return label
    }()
    
    private lazy var cityTextField: CustomTextField = {
        let textField = CustomTextField(imageName: C.ImageNames.buildings.rawValue)
        textField.placeholder = I.cityTextFieldPlaceHolder
        return textField
    }()
    
    private lazy var priceLabel: UILabel = {
        let label = SectionLabel(labelText: I.priceLabelText)
        return label
    }()
    
    private lazy var priceTextField: CustomTextField = {
        let textField = CustomTextField(imageName: C.ImageNames.money.rawValue)
        textField.placeholder = I.priceTextFieldPlaceHolder
        return textField
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = SectionLabel(labelText: I.descriptionLabelText)
        return label
    }()
    
    private lazy var descriptionTextView: UITextView = {
        let textView = UITextView()
        textView.backgroundColor = .tripGrey
        textView.layer.cornerRadius = 10
        textView.font = UIFont.systemFont(ofSize: 18)
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    private lazy var cityStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [cityLabel, cityTextField], axis: .vertical, spacing: 6, distribution: .fillProportionally)
        return stack
    }()
    
    private lazy var priceStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [priceLabel, priceTextField], axis: .vertical, spacing: 6, distribution: .fillProportionally)
        return stack
    }()
    
    private lazy var stack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [cityStack, priceStack], axis: .vertical, spacing: 20, distribution: .fillEqually)
        return stack
    }()
    
    private lazy var paidLabel: UILabel = {
        let paidLabel = UILabel()
        paidLabel.text = I.paidLabel
        paidLabel.textColor = .tripRed
        paidLabel.font = UIFont.systemFont(ofSize: 21, weight: .heavy)
        paidLabel.translatesAutoresizingMaskIntoConstraints = false
        return paidLabel
    }()

    private lazy var paidButton: SelectionButton = {
        let paidButton = SelectionButton(imageHeight: 25)
        paidButton.tag = 7
        paidButton.setImage(imageName: "checkmark")
        paidButton.addTarget(self, action: #selector(selectPayment), for: .touchUpInside)
        return paidButton
    }()
    
    private lazy var paidStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [paidLabel, paidButton],
                                axis: .horizontal,
                                spacing: 10,
                                distribution: .fillEqually)
        return stack
    }()
    
    private lazy var descriptionStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [descriptionLabel, descriptionTextView], axis: .vertical, spacing: 6, distribution: .fill)
        return stack
    }()
    
    private lazy var adressButton: AdressButton = {
        let adressButton = AdressButton()
        adressButton.addTarget(self, action: #selector(getAdress), for: .touchUpInside)
        return adressButton
    }()
    
    private lazy var addNewNoteButton: AddButton = {
        let addNoteTripButton = AddButton(imageName: nil, title: I.addNoteButtonTitle, cornerRadius: 10)
        addNoteTripButton.addTarget(self, action: #selector(addNote), for: .touchUpInside)
        return addNoteTripButton
    }()
    
    private lazy var warningLabel: WarningLabel = {
        let warningLabel = WarningLabel(fontSize: 16)
        warningLabel.adjustsFontSizeToFitWidth = true
        return warningLabel
    }()
    
    private lazy var countLabel: UILabel = {
        let countLabel = UILabel()
        countLabel.text = I.countLabelText
        countLabel.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        countLabel.textColor = .tripBlue
        countLabel.translatesAutoresizingMaskIntoConstraints = false
        return countLabel
    }()
    
    private lazy var endEditingGestureRecognizer: UITapGestureRecognizer = {
        let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        return tap
    }()
    
    // MARK: - Life Time
    
    init(viewModel: NewNoteViewModelProtocol, isEdited: Bool) {
        self.isEdited = isEdited
        super.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
        setupConstraints()
        keyboard.registerKeyBoardNotification()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupViewModelBindings()
        setupDelegates()
        
        view.addGestureRecognizer(endEditingGestureRecognizer)
    }
    
    deinit {
        keyboard.removeKeyboardNotification()
    }
    
    // MARK: - Actions
    
    private func setupViewModelBindings() {
        viewModel?.noteCompletion = { [weak self] in
            self?.cityTextField.text = self?.viewModel?.city
            self?.priceTextField.text = self?.viewModel?.price
            self?.descriptionTextView.text = self?.viewModel?.description
            let countCharacters = self?.descriptionTextView.text.count ?? 0
            self?.countLabel.text = "\(countCharacters)/\(I.maxCharCount)"
            
            let category = self?.viewModel?.category
            switch category {
            case Category.transport.rawValue:
                self?.transportButton.pulsate()
                self?.transportButton.backgroundColor = .tripRed
            case Category.hotels.rawValue:
                self?.hotelsButton.pulsate()
                self?.hotelsButton.backgroundColor = .tripRed
            case Category.food.rawValue:
                self?.foodButton.pulsate()
                self?.foodButton.backgroundColor = .tripRed
            case Category.activity.rawValue:
                self?.activityButton.pulsate()
                self?.activityButton.backgroundColor = .tripRed
            case Category.purchases.rawValue:
                self?.purchaseButton.pulsate()
                self?.purchaseButton.backgroundColor = .tripRed
            case Category.other.rawValue:
                self?.otherButton.pulsate()
                self?.otherButton.backgroundColor = .tripRed
            default:
                break
            }
            guard let isPaidByMe = self?.viewModel?.isPaidByMe else { return }
            if isPaidByMe {
                self?.paidButton.backgroundColor = .tripRed
                self?.paidButton.pulsate()
            }
        }
        
        viewModel?.errorCompletion = { [weak self] error in
            self?.showAlert(title: I.fetchNoteAlertTitle, message: error.errorDescription)
        }
    }
    
    @objc private func addNote() {
        guard let city = cityTextField.text,
              city != "",
              let description = descriptionTextView.text,
              description != "",
              let price = priceTextField.text,
              let priceDouble = Double(price)
        else {
            let warningText = I.fieldAndPriceWarning
            animator.animateWarningLabel(warningLabel: warningLabel, withText: warningText)
            return
        }
        
        var category = ""
        for button in buttonArray {
            if button.backgroundColor == UIColor.tripRed {
                switch button.tag {
                case 1:
                    category = Category.transport.rawValue
                case 2:
                    category = Category.hotels.rawValue
                case 3:
                    category = Category.food.rawValue
                case 4:
                    category = Category.activity.rawValue
                case 5:
                    category = Category.purchases.rawValue
                case 6:
                    category = Category.other.rawValue
                default:
                    category = Category.other.rawValue
                }
            }
        }
        
        guard category != "" else {
            let categoryWarningText = I.categoryWarningText
            animator.animateWarningLabel(warningLabel: warningLabel, withText: categoryWarningText)
            return
        }
        
        let isPaidByMe = paidButton.backgroundColor == .tripRed
        
        if isEdited {
            viewModel?.updateNote(city: city, category: category, description: description, price: priceDouble, address: address ?? "", isPaidByMe: isPaidByMe, errorCompletion: { [weak self] in
                self?.showAlert(title: I.updateNoteAlertTitle,
                                message: I.errorConnectionAlertMessage)
                return
            })
        } else {
            viewModel?.addNote(category: category, city: city, price: priceDouble, isFavourite: false, description: description, address: address ?? "", isPaidByMe: isPaidByMe, errorCompletion: { [weak self] in
                self?.showAlert(title: I.addNOteAlertTitle,
                                message: I.errorConnectionAlertMessage)
                return
            })
        }
        dismiss(animated: true)
    }
    
    @objc private func backButtonPressed() {
        dismiss(animated: true)
    }
    
    @objc private func selectCategory(_ sender: SelectionButton) {
        buttonArray.forEach {
            $0.isSelected = false
            $0.stopAnimation()
        }
        sender.isSelected = true
        sender.pulsate()
    }
    
    @objc private func selectPayment() {
        if paidButton.isSelected == false {
            paidButton.isSelected = true
            paidButton.pulsate()
        } else {
            paidButton.isSelected = false
            paidButton.stopAnimation()
        }
    }
    
    @objc private func getAdress() {
        guard let mapVC = configurator?.configureMapVC() else { return }
        mapVC.mapViewControllerDelegate = self
        present(mapVC, animated: true)
    }
    
    // MARK: - Private methods
    
    private func setupUI() {
        view.backgroundColor = .white
        cityTextField.text = viewModel?.getCityOrCountry()
        descriptionTextView.delegate = self
        
        if isEdited {
            addNewNoteButton.backgroundColor = .tripBlue
            addNewNoteButton.setTitle(I.editNoteButtonTitle, for: .normal)
            addNewNoteButton.setImage(UIImage(systemName: C.ImageNames.editIcon.rawValue), for: .normal)
            cityLabel.textColor = .tripBlue
            priceLabel.textColor = .tripBlue
            descriptionLabel.textColor = .tripBlue
            paidLabel.textColor = .tripBlue
            viewModel?.downloadNote()
        }
    }
    
    private func setupDelegates() {
        cityTextField.delegate = self
        priceTextField.delegate = self
    }
    
    // MARK: - Layout
    
    private func setupConstraints() {
        setupScrollViewConstraints()
        setupLowerViewConstraints()
        setupBackButtonConstraints()
        setupAddNewTripButtonConstraints()
        setupCategoryLabelConstraints()
        setupStackViewConstraints()
        setupOtherStackViewConstraints()
        setupPaidStackConstraints()
        setupDescriptionStackViewConstraints()
        setupAdressButtonConstraints()
        setupWarningLabelConstraints()
        setupCountLabelConstraints()
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
            lowerView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            lowerView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            lowerView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            lowerView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            lowerView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
    }
    
    private func setupBackButtonConstraints() {
        lowerView.addSubview(closeButton)
        NSLayoutConstraint.activate([
            closeButton.topAnchor.constraint(equalTo: lowerView.topAnchor, constant: 40),
            closeButton.leadingAnchor.constraint(equalTo: lowerView.leadingAnchor, constant: 10),
            closeButton.heightAnchor.constraint(equalToConstant: 35),
            closeButton.widthAnchor.constraint(equalTo: closeButton.heightAnchor)
        ])
    }
    
    private func setupCategoryLabelConstraints() {
        lowerView.addSubview(categoryLabel)
        NSLayoutConstraint.activate([
            categoryLabel.topAnchor.constraint(equalTo: closeButton.bottomAnchor, constant: 10),
            categoryLabel.leadingAnchor.constraint(equalTo: lowerView.leadingAnchor, constant: 10),
            categoryLabel.trailingAnchor.constraint(equalTo: lowerView.trailingAnchor, constant: -10),
            categoryLabel.heightAnchor.constraint(equalToConstant: 25)
        ])
    }
    
    private func setupStackViewConstraints() {
        lowerView.addSubview(categoryOneStackView)
        NSLayoutConstraint.activate([
            categoryOneStackView.topAnchor.constraint(equalTo: categoryLabel.bottomAnchor, constant: 8),
            categoryOneStackView.leadingAnchor.constraint(equalTo: lowerView.leadingAnchor, constant: 30),
            categoryOneStackView.trailingAnchor.constraint(equalTo: lowerView.trailingAnchor, constant: -30),
            categoryOneStackView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height * 0.1)
        ])
        
        lowerView.addSubview(categoryTwoStackView)
        NSLayoutConstraint.activate([
            categoryTwoStackView.topAnchor.constraint(equalTo: categoryOneStackView.bottomAnchor, constant: 10),
            categoryTwoStackView.leadingAnchor.constraint(equalTo: lowerView.leadingAnchor, constant: 30),
            categoryTwoStackView.trailingAnchor.constraint(equalTo: lowerView.trailingAnchor, constant: -30),
            categoryTwoStackView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height * 0.1)
        ])
    }
    
    private func setupOtherStackViewConstraints() {
        lowerView.addSubview(stack)
        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: categoryTwoStackView.bottomAnchor, constant: 20),
            stack.leadingAnchor.constraint(equalTo: lowerView.leadingAnchor, constant: 10),
            stack.trailingAnchor.constraint(equalTo: lowerView.trailingAnchor, constant: -10),
            stack.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height * 0.233)
        ])
    }
    
    private func setupPaidStackConstraints() {
        lowerView.addSubview(paidStack)
        NSLayoutConstraint.activate([
            paidStack.topAnchor.constraint(equalTo: stack.bottomAnchor, constant: 20),
            paidStack.leadingAnchor.constraint(equalTo: lowerView.leadingAnchor, constant: 10),
            paidStack.widthAnchor.constraint(equalToConstant: 135),
            paidStack.heightAnchor.constraint(equalToConstant: 45)
        ])
    }
    
    private func setupDescriptionStackViewConstraints() {
        lowerView.addSubview(descriptionStack)
        NSLayoutConstraint.activate([
            descriptionStack.topAnchor.constraint(equalTo: paidStack.bottomAnchor, constant: 20),
            descriptionStack.leadingAnchor.constraint(equalTo: lowerView.leadingAnchor, constant: 10),
            descriptionStack.trailingAnchor.constraint(equalTo: lowerView.trailingAnchor, constant: -10),
            descriptionStack.bottomAnchor.constraint(equalTo: addNewNoteButton.topAnchor, constant: -10),
            descriptionStack.heightAnchor.constraint(equalToConstant: 200)
        ])
    }
    
    private func setupAdressButtonConstraints() {
        lowerView.addSubview(adressButton)
        NSLayoutConstraint.activate([
            adressButton.topAnchor.constraint(equalTo: paidStack.bottomAnchor, constant: 20),
            adressButton.trailingAnchor.constraint(equalTo: lowerView.trailingAnchor, constant: -10),
            adressButton.widthAnchor.constraint(equalToConstant: 100),
            adressButton.heightAnchor.constraint(equalToConstant: 25)
        ])
    }
    
    private func setupAddNewTripButtonConstraints() {
        lowerView.addSubview(addNewNoteButton)
        NSLayoutConstraint.activate([
            addNewNoteButton.bottomAnchor.constraint(equalTo: lowerView.bottomAnchor, constant: -35),
            addNewNoteButton.leadingAnchor.constraint(equalTo: lowerView.leadingAnchor, constant: 20),
            addNewNoteButton.trailingAnchor.constraint(equalTo: lowerView.trailingAnchor, constant: -20),
            addNewNoteButton.heightAnchor.constraint(equalToConstant: 58)
        ])
    }
    
    private func setupWarningLabelConstraints() {
        lowerView.addSubview(warningLabel)
        NSLayoutConstraint.activate([
            warningLabel.topAnchor.constraint(equalTo: categoryTwoStackView.bottomAnchor, constant: 20),
            warningLabel.trailingAnchor.constraint(equalTo: lowerView.trailingAnchor, constant: -30),
            warningLabel.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width * 2 / 3),
            warningLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
    
    private func setupCountLabelConstraints() {
        lowerView.addSubview(countLabel)
        NSLayoutConstraint.activate([
            countLabel.centerYAnchor.constraint(equalTo: adressButton.centerYAnchor, constant: 0),
            countLabel.widthAnchor.constraint(equalToConstant: 100),
            countLabel.trailingAnchor.constraint(equalTo: adressButton.leadingAnchor, constant: -10),
            countLabel.heightAnchor.constraint(equalToConstant: 25)
        ])
    }
}

// MARK: - UITextViewDelegate
extension NewNoteViewController: UITextViewDelegate {
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        return textView.text.count + (text.count - range.length) <= viewModel?.maxCharCount ?? 100
    }
    
    func textViewDidChange(_ textView: UITextView) {
        countLabel.text = "\(textView.text.count)/\(I.maxCharCount)"
    }
}

// MARK: - UITextFieldDelegate
extension NewNoteViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case cityTextField:
            priceTextField.becomeFirstResponder()
        case priceTextField:
            priceTextField.resignFirstResponder()
        default:
            textField.resignFirstResponder()
        }
        return true
    }
}

extension NewNoteViewController: MapViewControllerDelegate {
    
    func getAddress(_ adress: String?) {
        descriptionTextView.text = descriptionTextView.text + "\n" + (adress ?? "")
        address = adress ?? ""
    }
}
