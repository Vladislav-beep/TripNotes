//
//  NewNoteViewController.swift
//  TripNotes
//
//  Created by Владислав Сизонов on 11.01.2022.
//

import UIKit

class NewNoteViewController: UIViewController {
    
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
        let categoryLabel = SectionLabel(labelText: "Category")
        return categoryLabel
    }()
    
    private lazy var transportLabel: UILabel = {
        let transportLabel = SelectionLabel(labelText: "Transport")
        return transportLabel
    }()
    
    private lazy var hotelLabel: UILabel = {
        let hotelLabel = SelectionLabel(labelText: "Hotels")
        return hotelLabel
    }()
    
    private lazy var foodLabel: UILabel = {
        let foodLabel = SelectionLabel(labelText: "Restaurants")
        return foodLabel
    }()
    
    private lazy var activityLabel: UILabel = {
        let activityLabel = SelectionLabel(labelText: "Activities")
        return activityLabel
    }()
    
    private lazy var perhaseLabel: UILabel = {
        let perhaseLabel = SelectionLabel(labelText: "Perhases")
        return perhaseLabel
    }()
    
    private lazy var otherLabel: SelectionLabel = {
        let otherLabel = SelectionLabel(labelText: "Other")
        return otherLabel
    }()
    
    private lazy var transportButton: SelectionButton = {
        let transportButton = SelectionButton()
        transportButton.tag = 1
        transportButton.setImage(imageName: "tram.tunnel.fill")
        transportButton.addTarget(self, action: #selector(selectCategory(_:)), for: .touchUpInside)
        return transportButton
    }()
    
    private lazy var hotelsButton: SelectionButton = {
        let hotelsButton = SelectionButton()
        hotelsButton.tag = 2
        hotelsButton.setImage(imageName: "building.fill")
        hotelsButton.addTarget(self, action: #selector(selectCategory(_:)), for: .touchUpInside)
        return hotelsButton
    }()
    
    private lazy var foodButton: SelectionButton = {
        let foodButton = SelectionButton()
        foodButton.tag = 3
        foodButton.setImage(imageName: "hourglass.tophalf.fill")
        foodButton.addTarget(self, action: #selector(selectCategory(_:)), for: .touchUpInside)
        return foodButton
    }()
    
    private lazy var activityButton: SelectionButton = {
        let activityButton = SelectionButton()
        activityButton.tag = 4
        activityButton.setImage(imageName: "camera.on.rectangle.fill")
        activityButton.addTarget(self, action: #selector(selectCategory(_:)), for: .touchUpInside)
        return activityButton
    }()
    
    private lazy var perchaseButton: SelectionButton = {
        let purchaseButton = SelectionButton()
        purchaseButton.tag = 5
        purchaseButton.setImage(imageName: "creditcard.fill")
        purchaseButton.addTarget(self, action: #selector(selectCategory(_:)), for: .touchUpInside)
        return purchaseButton
    }()
    
    private lazy var otherButton: SelectionButton = {
        let otherButton = SelectionButton()
        otherButton.tag = 6
        otherButton.setImage(imageName: "square.3.stack.3d.bottom.fill")
        otherButton.addTarget(self, action: #selector(selectCategory(_:)), for: .touchUpInside)
        return otherButton
    }()
    
    private lazy var buttonArray: [SelectionButton] = {
        let array = [transportButton, hotelsButton, foodButton, activityButton, perchaseButton, otherButton]
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
        let stack = UIStackView(arrangedSubviews: [perhaseLabel, perchaseButton], axis: .vertical, spacing: 5, distribution: .fillProportionally)
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
        let label = SectionLabel(labelText: "City")
        return label
    }()
    
    private lazy var cityTextField: CustomTextField = {
        let textField = CustomTextField(imageName: "buildings")
        textField.placeholder = "Enter city"
        return textField
    }()
    
    private lazy var priceLabel: UILabel = {
        let label = SectionLabel(labelText: "Price")
        return label
    }()
    
    private lazy var priceTextField: CustomTextField = {
        let textField = CustomTextField(imageName: "money3")
        textField.placeholder = "Enter price"
        return textField
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = SectionLabel(labelText: "Description")
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
        let addNoteTripButton = AddButton(imageName: nil, title: "+ Add Note", cornerRadius: 10)
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
        countLabel.text = "0/360"
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
        view.addGestureRecognizer(endEditingGestureRecognizer)
        setupUI()
        setupViewModelBindings()
        setupDelegates()
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
            self?.countLabel.text = "\(countCharacters)/360"
            
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
                self?.perchaseButton.pulsate()
                self?.perchaseButton.backgroundColor = .tripRed
            case Category.other.rawValue:
                self?.otherButton.pulsate()
                self?.otherButton.backgroundColor = .tripRed
            default:
                break
            }
        }
        viewModel?.errorCompletion = { [weak self] error in
            self?.showAlert(title: "Error!", message: error.errorDescription)
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
            let warningText = "Fill all of fields or write correct price"
            animator.animateWarningLabel(warningLabel: warningLabel, withText: warningText)
            return
        }
        
        var category = ""
        for button in buttonArray {
            if button.backgroundColor == UIColor.tripRed {
                switch button.tag {
                case 1:
                    category = "Transport"
                case 2:
                    category = "Hotels"
                case 3:
                    category = "Food"
                case 4:
                    category = "Activities"
                case 5:
                    category = "Purchases"
                case 6:
                    category = "Other"
                default:
                    category = "Other"
                }
            }
        }
        
        guard category != "" else {
            let categoryWarningText = "Choose category"
            animator.animateWarningLabel(warningLabel: warningLabel, withText: categoryWarningText)
            return
        }
        
        if isEdited {
            viewModel?.updateNote(city: city, category: category, description: description, price: priceDouble, address: address ?? "", errorCompletion: {
                self.showAlert(title: "Unable to update note",
                               message: "Please, check internet connection")
                return
            })
        } else {
            viewModel?.addNote(category: category, city: city, price: priceDouble, isFavourite: false, description: description, address: address ?? "", errorCompletion: {
                self.showAlert(title: "Unable to add note",
                               message: "Please, check internet connection")
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
    
    @objc private func getAdress() {
        ////////
        
        let mapVM = MapViewModel()
        let mapVC = MapViewController(viewModel: mapVM)
        mapVC.mapViewControllerDelegate = self
        present(mapVC, animated: true)
        
        ///////
    }
    
    // MARK: - Private methods
    
    private func setupUI() {
        view.backgroundColor = .white
        descriptionTextView.delegate = self
        
        if isEdited {
            addNewNoteButton.backgroundColor = .tripBlue
            addNewNoteButton.setTitle(" Edit Note", for: .normal)
            addNewNoteButton.setImage(UIImage(systemName: "square.and.pencil"), for: .normal)
            cityLabel.textColor = .tripBlue
            priceLabel.textColor = .tripBlue
            descriptionLabel.textColor = .tripBlue
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
            lowerView.centerYAnchor.constraint(equalTo: scrollView.centerYAnchor),
            lowerView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            lowerView.heightAnchor.constraint(equalTo: view.heightAnchor),
            lowerView.widthAnchor.constraint(equalTo: view.widthAnchor)
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
    
    private func setupDescriptionStackViewConstraints() {
        lowerView.addSubview(descriptionStack)
        NSLayoutConstraint.activate([
            descriptionStack.topAnchor.constraint(equalTo: stack.bottomAnchor, constant: 20),
            descriptionStack.leadingAnchor.constraint(equalTo: lowerView.leadingAnchor, constant: 10),
            descriptionStack.trailingAnchor.constraint(equalTo: lowerView.trailingAnchor, constant: -10),
            descriptionStack.bottomAnchor.constraint(equalTo: addNewNoteButton.topAnchor, constant: -10)
        ])
    }
    
    private func setupAdressButtonConstraints() {
        lowerView.addSubview(adressButton)
        NSLayoutConstraint.activate([
            adressButton.topAnchor.constraint(equalTo: priceStack.bottomAnchor, constant: 20),
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
        return textView.text.count + (text.count - range.length) <= 360
    }
    
    func textViewDidChange(_ textView: UITextView) {
        countLabel.text = "\(textView.text.count)/360"
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





