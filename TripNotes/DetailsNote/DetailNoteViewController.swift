//
//  DetailNoteViewController.swift
//  TripNotes
//
//  Created by Владислав Сизонов on 06.02.2022.
//

import UIKit

class DetailNoteViewController: UIViewController {
    
    private var viewModel: NoteCellViewModel
    
    var isFavourite = false
    
    lazy var contraint = heartImageView.heightAnchor.constraint(equalToConstant: 0)
    lazy var animator = Animator(layoutConstraint: contraint, container: view)
        
    private lazy var yellowView: UIView = {
        let redView = UIView()
        redView.backgroundColor = .tripYellow
        redView.layer.cornerRadius = 20
        redView.translatesAutoresizingMaskIntoConstraints = false
        return redView
    }()
    
    private lazy var closeButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(systemName: "xmark.circle.fill"), for: .normal)
        button.tintColor = .tripBlue
        button.addTarget(self, action: #selector(closeScreen), for: .touchUpInside)
        button.layer.shadowColor = UIColor.darkGray.cgColor
        button.layer.shadowRadius = 5
        button.layer.shadowOffset = CGSize(width: 0, height: 5)
        button.layer.shadowOpacity = 0.5
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var likeButton: UIButton = {
        let like = UIButton()
        like.setBackgroundImage(UIImage(systemName: "heart.fill"), for: .normal)
        like.tintColor = .tripGrey
        like.layer.shadowColor = UIColor.darkGray.cgColor
        like.layer.shadowRadius = 3
        like.layer.shadowOffset = CGSize(width: 0, height: 2)
        like.layer.shadowOpacity = 0.3
        like.addTarget(self, action: #selector(toggleFavourite), for: .touchUpInside)
        like.translatesAutoresizingMaskIntoConstraints = false
        return like
    }()
    
    private lazy var categoryImageView: UIImageView = {
        let categoryImageView = UIImageView()
        categoryImageView.layer.cornerRadius = 5
        categoryImageView.tintColor = .tripBlue
        categoryImageView.contentMode = .scaleAspectFit
        categoryImageView.translatesAutoresizingMaskIntoConstraints = false
        return categoryImageView
    }()
    
    private lazy var categoryLabel: NoteLabel = {
        let categoryLabel = NoteLabel(fontSize: 20, fontWeight: .heavy)
        
        categoryLabel.textAlignment = .center
        return categoryLabel
    }()
    private lazy var cityLabel: NoteLabel = {
        let cityLabel = NoteLabel(fontSize: 18, fontWeight: .bold)
        return cityLabel
    }()
    
    private lazy var descriptionLabel: NoteLabel = {
        let descriptionLabel = NoteLabel(fontSize: 15, fontWeight: .medium)
        descriptionLabel.numberOfLines = 0
        return descriptionLabel
    }()
    
    private lazy var deleteButton: UIButton = {
        let deleteButton = UIButton()
        deleteButton.setTitle(" Delete", for: .normal)
        deleteButton.setImage(UIImage(systemName: "trash"), for: .normal)
        deleteButton.tintColor = .tripWhite
        deleteButton.backgroundColor = .tripRed
        deleteButton.layer.cornerRadius = 4
        deleteButton.addTarget(self, action: #selector(deleteNote), for: .touchUpInside)
        deleteButton.layer.shadowColor = UIColor.darkGray.cgColor
        deleteButton.layer.shadowRadius = 5
        deleteButton.layer.shadowOffset = CGSize(width: 0, height: 5)
        deleteButton.layer.shadowOpacity = 0.5
        deleteButton.translatesAutoresizingMaskIntoConstraints = false
        return deleteButton
    }()
    
    private lazy var editButton: UIButton = {
        let editButton = UIButton()
        editButton.setTitle(" Edit", for: .normal)
        editButton.setImage(UIImage(systemName: "square.and.pencil"), for: .normal)
        editButton.tintColor = .tripWhite
        editButton.backgroundColor = .tripBlue
        editButton.layer.cornerRadius = 4
        editButton.addTarget(self, action: #selector(editNote), for: .touchUpInside)
        editButton.layer.shadowColor = UIColor.darkGray.cgColor
        editButton.layer.shadowRadius = 5
        editButton.layer.shadowOffset = CGSize(width: 0, height: 5)
        editButton.layer.shadowOpacity = 0.5
        editButton.translatesAutoresizingMaskIntoConstraints = false
        return editButton
    }()
    
    private lazy var editDeleteButtonStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [deleteButton, editButton],
                                axis: .horizontal,
                                spacing: 25,
                                distribution: .fillEqually)
        return stack
    }()
    
    private lazy var dateLabel: NoteLabel = {
        let dateLabel = NoteLabel(fontSize: 14, fontWeight: .regular)
        dateLabel.adjustsFontSizeToFitWidth = true
        dateLabel.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
        return dateLabel
    }()
    
    private lazy var labelStackView: UIStackView = {
        let labelStackView = UIStackView(arrangedSubviews: [categoryLabel, cityLabel, descriptionLabel],
                                         axis: .vertical,
                                         spacing: 8,
                                         distribution: .fillProportionally)
        labelStackView.translatesAutoresizingMaskIntoConstraints = false
        return labelStackView
    }()
    
    private lazy var dateSumStack: UIStackView = {
        let dateSumStack = UIStackView(arrangedSubviews: [dateLabel, sumLabel],
                                       axis: .horizontal,
                                       spacing: 0,
                                       distribution: .fillEqually)
        return dateSumStack
    }()
    
    private lazy var sumLabel: UILabel = {
        let sumLabel = UILabel()
        sumLabel.adjustsFontSizeToFitWidth = true
        sumLabel.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        sumLabel.font = UIFont.systemFont(ofSize: 24, weight: .heavy)
        sumLabel.minimumScaleFactor = 0.3
        sumLabel.textAlignment = .right
        sumLabel.textColor = .tripBlue
        sumLabel.translatesAutoresizingMaskIntoConstraints = false
        return sumLabel
    }()
    
    private lazy var heartImageView: UIImageView = {
        let heartImageView = UIImageView()
        heartImageView.image = UIImage(named: "heart-color1")
        heartImageView.tintColor = .tripRed
        heartImageView.translatesAutoresizingMaskIntoConstraints = false
        return heartImageView
    }()
    
    init(viewModel: NoteCellViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .tripGrey
        view.layer.cornerRadius = 20

        cityLabel.text = viewModel.city
        categoryLabel.text = viewModel.category
        descriptionLabel.text = viewModel.description
        dateLabel.text = viewModel.date
        sumLabel.text = viewModel.price
        categoryImageView.image = setImage(for: viewModel.category)
        
        if viewModel.isFavourite {
            likeButton.tintColor = .tripRed
        }
        
        setupAllConstraints()
    }
    
    
    @objc func closeScreen() {
        dismiss(animated: true)
    }
    
    
    @objc func deleteNote() {
        viewModel.deleteNote()
        dismiss(animated: true)
    }
    
    @objc func editNote() {
        dismiss(animated: true)
        let tripId = viewModel.getTripId()
        let noteId = viewModel.getNoteId()
        let newVm = NewNoteViewModel(tripId: tripId, noteId: noteId)
        let newNoteVC = NewNoteViewController(viewModel: newVm, isEdited: true)
        newNoteVC.modalPresentationStyle = .fullScreen
       // present(newNoteVC, animated: true)
        presentingViewController?.present(newNoteVC, animated: true, completion: nil)
    }
    
    @objc func toggleFavourite() {
        if likeButton.tintColor == .tripGrey {
            animator.animate { [weak self] in
                self?.likeButton.tintColor = .tripRed
            }
            isFavourite = true
            viewModel.toggleFavourite(isFavourite: isFavourite)
        } else {
            likeButton.tintColor = .tripGrey
            isFavourite = false
            viewModel.toggleFavourite(isFavourite: isFavourite)
        }
    }
    
    private func setupAllConstraints() {
        setupYellowViewConstraints()
        setupCloseButtonConstraints()
        setupLikeButtonConstraints()
        setupSumLabelConstraints()
        setupDeleteButtonConsytaints()
        setupStackViewConstraints()
        setupLabelStackConstraints()
        setupDeleteButtonConsytaints()
        setupHeartImageViewConstraints()
    }
    
    private func setImage(for category: String) -> UIImage {
        switch category {
        case "Hotels":
            return UIImage(systemName: "building.fill") ?? UIImage()
        case "Transport":
            return UIImage(systemName: "tram.tunnel.fill") ?? UIImage()
        case "Food":
            return UIImage(systemName: "hourglass.tophalf.fill") ?? UIImage()
        case "Activities":
            return UIImage(systemName: "camera.on.rectangle.fill") ?? UIImage()
        case "Purchases":
            return UIImage(systemName: "creditcard.fill") ?? UIImage()
        case "Other":
            return UIImage(systemName: "square.3.stack.3d.bottom.fill") ?? UIImage()
        default:
            return UIImage(systemName: "square") ?? UIImage()
        }
    }
    
    private func setupYellowViewConstraints() {
        view.addSubview(yellowView)
        NSLayoutConstraint.activate([
            yellowView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            yellowView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
            yellowView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            yellowView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0)
        ])
    }

    private func setupCloseButtonConstraints() {
        yellowView.addSubview(closeButton)
        NSLayoutConstraint.activate([
            closeButton.heightAnchor.constraint(equalToConstant: 35),
            closeButton.widthAnchor.constraint(equalTo: closeButton.heightAnchor),
            closeButton.topAnchor.constraint(equalTo: yellowView.topAnchor, constant: 8),
            closeButton.leadingAnchor.constraint(equalTo: yellowView.leadingAnchor, constant: 8),
        ])
    }
    
    private func setupLikeButtonConstraints() {
        yellowView.addSubview(likeButton)
        NSLayoutConstraint.activate([
            likeButton.heightAnchor.constraint(equalToConstant: 35),
            likeButton.widthAnchor.constraint(equalTo: closeButton.heightAnchor),
            likeButton.trailingAnchor.constraint(equalTo: yellowView.trailingAnchor, constant: -8),
            likeButton.topAnchor.constraint(equalTo: yellowView.topAnchor, constant: 8)
        ])
    }
        
    private func setupStackViewConstraints() {
        yellowView.addSubview(categoryImageView)
        NSLayoutConstraint.activate([
            categoryImageView.topAnchor.constraint(equalTo: yellowView.topAnchor, constant: 8),
            categoryImageView.heightAnchor.constraint(equalToConstant: 50),
            categoryImageView.widthAnchor.constraint(equalToConstant: 50),
            categoryImageView.centerXAnchor.constraint(equalTo: yellowView.centerXAnchor, constant: 0)
        ])
    }
    
    private func setupLabelStackConstraints() {
        yellowView.addSubview(labelStackView)
        NSLayoutConstraint.activate([
            categoryLabel.heightAnchor.constraint(equalToConstant: 20),
            cityLabel.heightAnchor.constraint(equalToConstant: 20),
            labelStackView.topAnchor.constraint(equalTo: categoryImageView.bottomAnchor, constant: 8),
            labelStackView.bottomAnchor.constraint(equalTo: deleteButton.topAnchor, constant: -8),
            labelStackView.trailingAnchor.constraint(equalTo: yellowView.trailingAnchor, constant: -10),
            labelStackView.leadingAnchor.constraint(equalTo: yellowView.leadingAnchor, constant: 10)
        ])
    }
    
    private func setupSumLabelConstraints() {
        yellowView.addSubview(dateSumStack)
        NSLayoutConstraint.activate([
            dateSumStack.bottomAnchor.constraint(equalTo: yellowView.bottomAnchor, constant: -20),
            dateSumStack.leadingAnchor.constraint(equalTo: yellowView.leadingAnchor, constant: 20),
            dateSumStack.trailingAnchor.constraint(equalTo: yellowView.trailingAnchor, constant: -20),
            dateSumStack.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    private func setupDeleteButtonConsytaints() {
        yellowView.addSubview(editDeleteButtonStack)
        NSLayoutConstraint.activate([
            editDeleteButtonStack.bottomAnchor.constraint(equalTo: dateSumStack.topAnchor, constant: -20),
            editDeleteButtonStack.leadingAnchor.constraint(equalTo: yellowView.leadingAnchor, constant: 30),
            editDeleteButtonStack.trailingAnchor.constraint(equalTo: yellowView.trailingAnchor, constant: -30),
            editDeleteButtonStack.heightAnchor.constraint(equalToConstant: 40),
        ])
    }
    
    private func setupHeartImageViewConstraints() {
        labelStackView.addSubview(heartImageView)
        NSLayoutConstraint.activate([
            heartImageView.centerXAnchor.constraint(equalTo: labelStackView.centerXAnchor, constant: 0),
            heartImageView.centerYAnchor.constraint(equalTo: labelStackView.centerYAnchor, constant: 0),
            contraint,
            heartImageView.widthAnchor.constraint(equalTo: heartImageView.heightAnchor)
        ])
    }
    
    
//    private func setupStackViewConstraints() {
//
//
//        lowerView.addSubview(labelStackView)
//        let k = categoryLabel.heightAnchor.constraint(equalToConstant: 40).constant
//        let a = cityLabel.heightAnchor.constraint(equalToConstant: 40).constant
//        let b = dateLabel.heightAnchor.constraint(equalToConstant: 40).constant
//        let c = descriptionLabel.intrinsicContentSize.height
//
//
//        let h = k + a + b + c
//        print(descriptionLabel.intrinsicContentSize.height)
//        print(categoryLabel.heightAnchor.constraint(equalToConstant: 40).constant)
//        NSLayoutConstraint.activate([
//         //   categoryLabel.heightAnchor.constraint(equalToConstant: 20),
//         //   cityLabel.heightAnchor.constraint(equalToConstant: 20),
//           // dateLabel.heightAnchor.constraint(equalToConstant: 20),
//            labelStackView.bottomAnchor.constraint(equalTo: lowerView.bottomAnchor, constant: -30),
//            labelStackView.heightAnchor.constraint(equalToConstant: h),
//            labelStackView.trailingAnchor.constraint(equalTo: lowerView.trailingAnchor, constant: -10),
//            labelStackView.leadingAnchor.constraint(equalTo: lowerView.leadingAnchor, constant: 10)
//        ])
//
//        lowerView.addSubview(categoryImageView)
//        NSLayoutConstraint.activate([
//            categoryImageView.bottomAnchor.constraint(equalTo: labelStackView.topAnchor, constant: -8),
//            categoryImageView.heightAnchor.constraint(equalToConstant: 50),
//            categoryImageView.widthAnchor.constraint(equalToConstant: 50),
//            categoryImageView.centerXAnchor.constraint(equalTo: lowerView.centerXAnchor, constant: 0)
//        ])
//
//
    
}
