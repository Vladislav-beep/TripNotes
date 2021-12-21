//
//  NewTripViewController.swift
//  TripNotes
//
//  Created by Владислав Сизонов on 21.12.2021.
//

import UIKit


class NewTripViewController: UIViewController {
    
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
        avatarImageView.layer.opacity = 0.65
        avatarImageView.translatesAutoresizingMaskIntoConstraints = false
        return avatarImageView
    }()
    
    private lazy var countryTextField: CustomTextField = {
        let countryTextField = CustomTextField()
        countryTextField.placeholder = "Enter country"
        return countryTextField
    }()
    
    private lazy var beginDateTextField: CustomTextField = {
        let beginDateTextField = CustomTextField()
        beginDateTextField.placeholder = "Date when trip begins"
        return beginDateTextField
    }()
    
    private lazy var finishDateTextField: CustomTextField = {
        let finishDateTextField = CustomTextField()
        finishDateTextField.placeholder = "Date when trip ends"
        return finishDateTextField
    }()
    
    private lazy var descriptionTextField: CustomTextField = {
        let descriptionTextField = CustomTextField()
        descriptionTextField.placeholder = "Descripe shortly ypur trip"
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
    
    private lazy var addNewTripButton: UIButton = {
        let addNewTripButton = UIButton()
        addNewTripButton.backgroundColor = .tripRed
        addNewTripButton.layer.cornerRadius = 10
        addNewTripButton.setTitle("Plan new Trip", for: .normal)
        addNewTripButton.translatesAutoresizingMaskIntoConstraints = false
        return addNewTripButton
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupScrollViewConstraints()
        setupLowerViewConstraints()
        setupAvatarConstraints()
        setupTextFieldsStackViewConstraints()
        setupAddNewTripButtonConstraints()
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
    
    private func setupTextFieldsStackViewConstraints() {
        lowerView.addSubview(textFieldsStackView)
        NSLayoutConstraint.activate([
            textFieldsStackView.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: 40),
            textFieldsStackView.leadingAnchor.constraint(equalTo: lowerView.leadingAnchor, constant: 20),
            textFieldsStackView.trailingAnchor.constraint(equalTo: lowerView.trailingAnchor, constant: -20),
            textFieldsStackView.heightAnchor.constraint(equalToConstant: 280)
        ])
    }
    
    private func setupAddNewTripButtonConstraints() {
        lowerView.addSubview(addNewTripButton)
        NSLayoutConstraint.activate([
            addNewTripButton.bottomAnchor.constraint(equalTo: lowerView.bottomAnchor, constant: -55),
            addNewTripButton.leadingAnchor.constraint(equalTo: lowerView.leadingAnchor, constant: 20),
            addNewTripButton.trailingAnchor.constraint(equalTo: lowerView.trailingAnchor, constant: -20),
            addNewTripButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}
