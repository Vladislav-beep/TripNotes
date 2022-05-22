//
//  DetailNoteViewController.swift
//  TripNotes
//
//  Created by Владислав Сизонов on 06.02.2022.
//

import UIKit

class DetailNoteViewController: UIViewController {
    
    // MARK: - Dependencies
    
    private var viewModel: NoteCellViewModelProtocol
    private lazy var contraint = heartImageView.heightAnchor.constraint(equalToConstant: 0)
    private lazy var animator = Animator(container: view)
    var configurator: Configurator?
    
    // MARK: - Properties
    
    var isFavourite = false
    
    // MARK: - UI
    
    private lazy var yellowView: UIView = {
        let redView = UIView()
        redView.backgroundColor = .tripYellow
        redView.layer.cornerRadius = 20
        redView.translatesAutoresizingMaskIntoConstraints = false
        return redView
    }()
    
    private lazy var closeButton: CloseButton = {
        let closeButton = CloseButton()
        closeButton.addTarget(self, action: #selector(closeScreen), for: .touchUpInside)
        return closeButton
    }()
    
    private lazy var likeButton: LikeButton = {
        let like = LikeButton()
        like.addTarget(self, action: #selector(toggleFavourite), for: .touchUpInside)
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
    
    private lazy var deleteButton: EditDeleteNoteButton = {
        let deleteButton = EditDeleteNoteButton(title: I.deleteButtonTitle,
                                                imageName: C.ImageNames.deleteIcon.rawValue,
                                                backgroud: .tripRed)
        deleteButton.addTarget(self, action: #selector(deleteNote), for: .touchUpInside)
        return deleteButton
    }()
    
    private lazy var editButton: EditDeleteNoteButton = {
        let editButton = EditDeleteNoteButton(title: I.editButtonTitle,
                                              imageName: C.ImageNames.editIcon.rawValue,
                                              backgroud: .tripBlue)
        editButton.addTarget(self, action: #selector(editNote), for: .touchUpInside)
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
        heartImageView.image = UIImage(named: C.ImageNames.heartColor.rawValue)
        heartImageView.tintColor = .tripRed
        heartImageView.translatesAutoresizingMaskIntoConstraints = false
        return heartImageView
    }()
    
    // MARK: - Life Time
    
    init(viewModel: NoteCellViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        setupAllConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    // MARK: - Actions
    
    @objc private func closeScreen() {
        dismiss(animated: true)
    }
    
    @objc private func deleteNote() {
        viewModel.deleteNote()
        postNotification()
        dismiss(animated: true)
    }
    
    @objc private func editNote() {
        dismiss(animated: true)
        let userId = viewModel.userId
        let tripId = viewModel.getTripId()
        let noteId = viewModel.getNoteId()
        let newNoteVC = configurator?.configureNewNoteEdited(withUser: userId, tripId: tripId, noteId: noteId) ?? UIViewController()
        presentingViewController?.present(newNoteVC, animated: true, completion: nil)
    }
    
    @objc private func toggleFavourite() {
        if likeButton.tintColor == .tripGrey {
            animator.animate(layoutConstraint: contraint) { [weak self] in
                self?.likeButton.tintColor = .tripRed
            }
            isFavourite = true
            viewModel.toggleFavourite(isFavourite: isFavourite)
        } else {
            likeButton.tintColor = .tripGrey
            isFavourite = false
            viewModel.toggleFavourite(isFavourite: isFavourite)
        }
        postNotification()
    }
    
    // MARK: - Private methods
    
    private func setupUI() {
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
    }
    
    private func postNotification() {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: I.updateObserverName),
                                        object: nil)
    }
    
    // MARK: - Layout
    
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
}
