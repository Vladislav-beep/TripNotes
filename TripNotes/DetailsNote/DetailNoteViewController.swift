//
//  DetailNoteViewController.swift
//  TripNotes
//
//  Created by Владислав Сизонов on 06.02.2022.
//

import UIKit

class DetailNoteViewController: UIViewController {
    
    // MARK: Dependencies
    
    private var viewModel: NoteCellViewModel
    
    // MARK: Properties
    
    var isFavourite = false
    lazy var contraint = heartImageView.heightAnchor.constraint(equalToConstant: 0)
    lazy var animator = Animator(container: view)
    
    // MARK: UI
        
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
        let deleteButton = EditDeleteNoteButton(title: " Delete",
                                                imageName: "trash",
                                                backgroud: .tripRed)
        deleteButton.addTarget(self, action: #selector(deleteNote), for: .touchUpInside)
        return deleteButton
    }()
    
    private lazy var editButton: EditDeleteNoteButton = {
        let editButton = EditDeleteNoteButton(title: " Edit",
                                              imageName: "square.and.pencil",
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
        heartImageView.image = UIImage(named: "heart-color1")
        heartImageView.tintColor = .tripRed
        heartImageView.translatesAutoresizingMaskIntoConstraints = false
        return heartImageView
    }()
    
    // MARK: Life Time
    
    init(viewModel: NoteCellViewModel) {
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
    
    // MARK: Actions
    
    @objc func closeScreen() {
        dismiss(animated: true)
    }
    
    @objc func deleteNote() {
        viewModel.deleteNote()
        postNotification()
        dismiss(animated: true)
    }
    
    @objc func editNote() {
        dismiss(animated: true)
        let tripId = viewModel.getTripId()
        let noteId = viewModel.getNoteId()
        let newVm = NewNoteViewModel(tripId: tripId, noteId: noteId)
        let newNoteVC = NewNoteViewController(viewModel: newVm, isEdited: true)
        newNoteVC.modalPresentationStyle = .fullScreen
        presentingViewController?.present(newNoteVC, animated: true, completion: nil)
    }
    
    @objc func toggleFavourite() {
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
    
    // MARK: Private methods
    
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
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "newDataNotif"), object: nil)
    }
    
    private func setImage(for category: String) -> UIImage {
        switch category {
        case Category.hotels.rawValue:
            return UIImage(systemName: "building.fill") ?? UIImage()
        case Category.transport.rawValue:
            return UIImage(systemName: "tram.tunnel.fill") ?? UIImage()
        case Category.food.rawValue:
            return UIImage(systemName: "hourglass.tophalf.fill") ?? UIImage()
        case Category.activity.rawValue:
            return UIImage(systemName: "camera.on.rectangle.fill") ?? UIImage()
        case Category.purchases.rawValue:
            return UIImage(systemName: "creditcard.fill") ?? UIImage()
        case Category.other.rawValue:
            return UIImage(systemName: "square.3.stack.3d.bottom.fill") ?? UIImage()
        default:
            return UIImage(systemName: "square") ?? UIImage()
        }
    }
    
    // MARK: Layout
    
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
    
