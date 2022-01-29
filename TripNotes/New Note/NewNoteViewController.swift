//
//  NewNoteViewController.swift
//  TripNotes
//
//  Created by Владислав Сизонов on 11.01.2022.
//

import UIKit

class NewNoteViewController: UIViewController {
    
    // MARK: Dependencies
    
    var viewModel: NewNoteViewModelProtocol?
    
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
    
    private lazy var redView: UIView = {
        let redView = UIView()
        redView.backgroundColor = .tripRed
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
    
    private lazy var categoryLabel: UILabel = {
        let label = SectionLabel(labelText: "Category")
        return label
    }()
    
    private lazy var transportLabel: UILabel = {
        let lb = SelectionLabel(labelText: "Transport")
        return lb
    }()
    
    private lazy var hotelLabel: UILabel = {
        let lb = SelectionLabel(labelText: "Hotels")
        return lb
    }()
    
    private lazy var foodLabel: UILabel = {
        let lb = SelectionLabel(labelText: "Restaurants")
        return lb
    }()
    
    private lazy var activityLabel: UILabel = {
        let lb = SelectionLabel(labelText: "Activities")
        return lb
    }()
    
    private lazy var perhaseLabel: UILabel = {
        let lb = SelectionLabel(labelText: "Perhases")
        return lb
    }()
    
    private lazy var otherLabel: SelectionLabel = {
        let lb = SelectionLabel(labelText: "Other")
        return lb
    }()
    
    private lazy var transportButton: SelectionButton = {
        let transportButton = SelectionButton()
        transportButton.setImage(imageName: "tram.tunnel.fill")
        transportButton.addTarget(self, action: #selector(selectCategory(_:)), for: .touchUpInside)
        return transportButton
    }()
    
    private lazy var hotelsButton: SelectionButton = {
        let hotelsButton = SelectionButton()
        hotelsButton.setImage(imageName: "building.fill")
        hotelsButton.addTarget(self, action: #selector(selectCategory(_:)), for: .touchUpInside)
        return hotelsButton
    }()
    
    private lazy var foodButton: SelectionButton = {
        let foodButton = SelectionButton()
        foodButton.setImage(imageName: "hourglass.tophalf.fill")
        foodButton.addTarget(self, action: #selector(selectCategory(_:)), for: .touchUpInside)
        return foodButton
    }()
    
    private lazy var activityButton: SelectionButton = {
        let activityButton = SelectionButton()
        activityButton.setImage(imageName: "camera.on.rectangle.fill")
        activityButton.addTarget(self, action: #selector(selectCategory(_:)), for: .touchUpInside)
        return activityButton
    }()
    
    private lazy var perchaseButton: SelectionButton = {
        let purchaseButton = SelectionButton()
        purchaseButton.setImage(imageName: "creditcard.fill")
        purchaseButton.addTarget(self, action: #selector(selectCategory(_:)), for: .touchUpInside)
        return purchaseButton
    }()
    
    private lazy var otherButton: SelectionButton = {
        let otherButton = SelectionButton()
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
        let textField = CustomTextField(imageName: "building.2.fill")
        textField.placeholder = "Enter city"
        return textField
    }()
    
    private lazy var priceLabel: UILabel = {
        let label = SectionLabel(labelText: "Price")
        return label
    }()
    
    private lazy var priceTextField: CustomTextField = {
        let textField = CustomTextField(imageName: "eurosign.square")
        textField.placeholder = "Enter price"
        return textField
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = SectionLabel(labelText: "Description")
        return label
    }()
    
    private lazy var descruptionTextView: UITextView = {
        let textView = UITextView()
        textView.backgroundColor = .tripGrey
        textView.layer.cornerRadius = 10
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
        let stack = UIStackView(arrangedSubviews: [descriptionLabel, descruptionTextView], axis: .vertical, spacing: 6, distribution: .fill)
        return stack
    }()
    
    private lazy var adressButton: UIButton = {
        let button = UIButton()
        button.setTitle(" Adress", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .heavy)
        button.tintColor = .tripBlue
        button.setTitleColor(.tripBlue, for: .normal)
        button.backgroundColor = .tripGrey
        button.setImage(UIImage(systemName: "magnifyingglass"), for: .normal)
        button.layer.cornerRadius = 6
        button.layer.shadowColor = UIColor.darkGray.cgColor
        button.layer.shadowRadius = 4
        button.layer.shadowOpacity = 0.4
        button.layer.shadowOffset = CGSize(width: 0, height: 5)
        button.addTarget(self, action: #selector(getAdress), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var addNoteTripButton: UIButton = {
        let addNoteTripButton = UIButton()
        addNoteTripButton.backgroundColor = .tripRed
        addNoteTripButton.layer.cornerRadius = 10
        addNoteTripButton.setTitle("+ Add Note", for: .normal)
        addNoteTripButton.titleLabel?.font = .systemFont(ofSize: 20, weight: .regular)
        addNoteTripButton.layer.shadowColor = UIColor.darkGray.cgColor
        addNoteTripButton.layer.shadowRadius = 4
        addNoteTripButton.layer.shadowOpacity = 0.4
        addNoteTripButton.layer.shadowOffset = CGSize(width: 0, height: 5)
        addNoteTripButton.translatesAutoresizingMaskIntoConstraints = false
        return addNoteTripButton
    }()
    
    // MARK: Life Time
    
    init(viewModel: NewNoteViewModelProtocol) {
        super.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
    }
    
    // MARK: Actions
    
    @objc func backButtonPressed() {
        dismiss(animated: true)
    }
    
    @objc func selectCategory(_ sender: SelectionButton) {
        buttonArray.forEach {
            $0.isSelected = false
            $0.stopAnimation()
        }
        sender.isSelected = true
        sender.pulsate()
    }
    
    @objc func getAdress() {
        let mapVC = MapViewController()
        present(mapVC, animated: true)
    }
    
    // MARK: Layout
    
    private func setupConstraints() {
        setupScrollViewConstraints()
        setupLowerViewConstraints()
        setupRedViewConstraints()
        setupBackButtonConstraints()
        setupAddNewTripButtonConstraints()
        setupCategoryLabelConstraints()
        setupStackViewConstraints()
        setupOtherStackViewConstraints()
        setupDescriptionStackViewConstraints()
        setupAdressButtonConstraints()
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
    
    private func setupRedViewConstraints() {
        lowerView.addSubview(redView)
        NSLayoutConstraint.activate([
            redView.topAnchor.constraint(equalTo: lowerView.topAnchor, constant: 0),
            redView.leadingAnchor.constraint(equalTo: lowerView.leadingAnchor, constant: 0),
            redView.trailingAnchor.constraint(equalTo: lowerView.trailingAnchor, constant: 0),
            redView.heightAnchor.constraint(equalToConstant: 42)
        ])
    }
    
    private func setupBackButtonConstraints() {
        lowerView.addSubview(backButton)
        NSLayoutConstraint.activate([
            backButton.topAnchor.constraint(equalTo: lowerView.topAnchor, constant: 10),
            backButton.leadingAnchor.constraint(equalTo: lowerView.leadingAnchor, constant: 10),
            backButton.heightAnchor.constraint(equalToConstant: 26),
            backButton.widthAnchor.constraint(equalToConstant: 26)
        ])
    }
    
    private func setupCategoryLabelConstraints() {
        lowerView.addSubview(categoryLabel)
        NSLayoutConstraint.activate([
            categoryLabel.topAnchor.constraint(equalTo: redView.bottomAnchor, constant: 10),
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
            descriptionStack.bottomAnchor.constraint(equalTo: addNoteTripButton.topAnchor, constant: -10)
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
        lowerView.addSubview(addNoteTripButton)
        NSLayoutConstraint.activate([
            addNoteTripButton.bottomAnchor.constraint(equalTo: lowerView.bottomAnchor, constant: -35),
            addNoteTripButton.leadingAnchor.constraint(equalTo: lowerView.leadingAnchor, constant: 20),
            addNoteTripButton.trailingAnchor.constraint(equalTo: lowerView.trailingAnchor, constant: -20),
            addNoteTripButton.heightAnchor.constraint(equalToConstant: 58)
        ])
    }
}





