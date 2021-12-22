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
        countryTextField.placeholder = "Enter country"
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
        descriptionTextField.placeholder = "Descripe your trip shortly"
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
    
    private lazy var tapGestureRecognizer: UITapGestureRecognizer = {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self,
                                                          action: #selector(setAvatarImage(_:)))
        
        return tapGestureRecognizer
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupScrollViewConstraints()
        setupLowerViewConstraints()
        setupAvatarConstraints()
        setupRedViewConstraints()
        setupBackButtonConstraints()
        setupTextFieldsStackViewConstraints()
        setupAddNewTripButtonConstraints()
    }
    
    @objc func backButtonPressed() {
        dismiss(animated: true)
    }
    
    @objc func setAvatarImage(_ sender: UITapGestureRecognizer) {
        print("djjv")
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
            redView.topAnchor.constraint(equalTo: avatarImageView.topAnchor, constant: 0),
            redView.leadingAnchor.constraint(equalTo: avatarImageView.leadingAnchor, constant: 10),
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
