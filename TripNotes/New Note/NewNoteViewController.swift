//
//  NewNoteViewController.swift
//  TripNotes
//
//  Created by Владислав Сизонов on 11.01.2022.
//

import UIKit

class NewNoteViewController: UIViewController {
    
    var viewModel: NewNoteViewModelProtocol?
    
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
    
    private lazy var categoryStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [transportStackView, hotelStackView, foodStackView], axis: .horizontal, spacing: 5, distribution: .fillEqually)
        return stack
    }()
    
    private lazy var category2StackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [activityStackView, perhaseStackView, otherStackView], axis: .horizontal, spacing: 5, distribution: .fillEqually)
        return stack
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
    
    @objc func selectCategory(_ sender: SelectionButton) {
        buttonArray.forEach {
            $0.isSelected = false
            $0.stopAnimation()
        }
        sender.isSelected = true
        sender.pulsate()
    }
    
    private func setupConstraints() {
        setupScrollViewConstraints()
        setupLowerViewConstraints()
        setupAddNewTripButtonConstraints()
        setup()
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
    
    private func setupAddNewTripButtonConstraints() {
        lowerView.addSubview(addNoteTripButton)
        NSLayoutConstraint.activate([
            addNoteTripButton.bottomAnchor.constraint(equalTo: lowerView.bottomAnchor, constant: -35),
            addNoteTripButton.leadingAnchor.constraint(equalTo: lowerView.leadingAnchor, constant: 20),
            addNoteTripButton.trailingAnchor.constraint(equalTo: lowerView.trailingAnchor, constant: -20),
            addNoteTripButton.heightAnchor.constraint(equalToConstant: 58)
        ])
    }
    
    private func setup() {
        lowerView.addSubview(categoryStackView)
        NSLayoutConstraint.activate([
            categoryStackView.topAnchor.constraint(equalTo: lowerView.topAnchor, constant: 35),
            categoryStackView.leadingAnchor.constraint(equalTo: lowerView.leadingAnchor, constant: 30),
            categoryStackView.trailingAnchor.constraint(equalTo: lowerView.trailingAnchor, constant: -30),
            categoryStackView.heightAnchor.constraint(equalToConstant: 80)
        ])
        
        lowerView.addSubview(category2StackView)
        NSLayoutConstraint.activate([
            category2StackView.topAnchor.constraint(equalTo: categoryStackView.bottomAnchor, constant: 15),
            category2StackView.leadingAnchor.constraint(equalTo: lowerView.leadingAnchor, constant: 30),
            category2StackView.trailingAnchor.constraint(equalTo: lowerView.trailingAnchor, constant: -30),
            category2StackView.heightAnchor.constraint(equalToConstant: 80)
        ])
    }
}





