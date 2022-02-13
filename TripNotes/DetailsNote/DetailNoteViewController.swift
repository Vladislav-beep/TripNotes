//
//  DetailNoteViewController.swift
//  TripNotes
//
//  Created by Владислав Сизонов on 06.02.2022.
//

import UIKit

class DetailNoteViewController: UIViewController {
    
    private var viewModel: NoteCellViewModel
    
    lazy var contraint = heartImageView.heightAnchor.constraint(equalToConstant: 0)
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private lazy var lowerView: UIView = {
        let lowerView = UIView()
        lowerView.translatesAutoresizingMaskIntoConstraints = false
        return lowerView
    }()
    
    private lazy var redView: UIView = {
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
    
    private lazy var dateLabel: NoteLabel = {
        let dateLabel = NoteLabel(fontSize: 14, fontWeight: .regular)
        dateLabel.adjustsFontSizeToFitWidth = true
        dateLabel.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
        return dateLabel
    }()
    
    private lazy var labelStackView: UIStackView = {
        let labelStackView = UIStackView(arrangedSubviews: [categoryLabel, cityLabel, descriptionLabel, dateSumStack],
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
        heartImageView.image = UIImage(systemName: "heart.fill")
        heartImageView.tintColor = .tripRed
        heartImageView.translatesAutoresizingMaskIntoConstraints = false
        return heartImageView
    }()
    
    lazy var animator = Animator(layoutConstraint: contraint, container: view)
    
    init(viewModel: NoteCellViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .clear

        cityLabel.text = viewModel.city
        categoryLabel.text = viewModel.category
        descriptionLabel.text = viewModel.description
        dateLabel.text = viewModel.date
        sumLabel.text = viewModel.price
        categoryImageView.image = setImage(for: viewModel.imageCategory)
        
        setupAllConstraints()
    }
    
    @objc func closeScreen() {
        dismiss(animated: true)
    }
    
    @objc func toggleFavourite() {
        
        animator.animate { [weak self] in
            self?.likeButton.tintColor = .tripRed
        }
    }
    
    private func setupAllConstraints() {
    //    setupScrollViewConstraints()
      //  setupLowerViewConstraints()
        setupRedView()
        setupCloseButtonConstraints()
        setupLikeButtonConstraints()
        
        setupStackViewConstraints()
        setupHeartImageViewConstraints()
    }
    
    private func setImage(for category: Category) -> UIImage {
        switch category {
        case .hotels:
            return UIImage(systemName: "building.fill") ?? UIImage()
        case .tranport:
            return UIImage(systemName: "tram.tunnel.fill") ?? UIImage()
        case .foodAndRestaurants:
            return UIImage(systemName: "hourglass.tophalf.fill") ?? UIImage()
        case .activity:
            return UIImage(systemName: "camera.on.rectangle.fill") ?? UIImage()
        case .purchases:
            return UIImage(systemName: "creditcard.fill") ?? UIImage()
        case .other:
            return UIImage(systemName: "square.3.stack.3d.bottom.fill") ?? UIImage()
        }
    }
    
//    private func setupScrollViewConstraints() {
//        view.addSubview(scrollView)
//        NSLayoutConstraint.activate([
//            scrollView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
//            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
//            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
//            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
//        ])
//    }
    
//    private func setupLowerViewConstraints() {
//        scrollView.addSubview(lowerView)
//        NSLayoutConstraint.activate([
//            lowerView.centerYAnchor.constraint(equalTo: scrollView.centerYAnchor),
//            lowerView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
//            lowerView.heightAnchor.constraint(equalTo: view.heightAnchor),
//            lowerView.widthAnchor.constraint(equalTo: view.widthAnchor)
//        ])
//    }
    
    private func setupRedView() {
        view.addSubview(redView)
        NSLayoutConstraint.activate([
            redView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -35),
            redView.heightAnchor.constraint(equalToConstant: 400),
            redView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            redView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10)
        ])
    }

    private func setupCloseButtonConstraints() {
        redView.addSubview(closeButton)
        NSLayoutConstraint.activate([
            closeButton.heightAnchor.constraint(equalToConstant: 35),
            closeButton.widthAnchor.constraint(equalTo: closeButton.heightAnchor),
            closeButton.topAnchor.constraint(equalTo: redView.topAnchor, constant: 8),
            closeButton.leadingAnchor.constraint(equalTo: redView.leadingAnchor, constant: 8),
        ])
    }
    
    private func setupLikeButtonConstraints() {
        redView.addSubview(likeButton)
        NSLayoutConstraint.activate([
            likeButton.heightAnchor.constraint(equalToConstant: 35),
            likeButton.widthAnchor.constraint(equalTo: closeButton.heightAnchor),
            likeButton.trailingAnchor.constraint(equalTo: redView.trailingAnchor, constant: -8),
            likeButton.topAnchor.constraint(equalTo: redView.topAnchor, constant: 8)
        ])
    }
        
    private func setupStackViewConstraints() {
        redView.addSubview(categoryImageView)
        NSLayoutConstraint.activate([
            categoryImageView.topAnchor.constraint(equalTo: redView.topAnchor, constant: 8),
            categoryImageView.heightAnchor.constraint(equalToConstant: 50),
            categoryImageView.widthAnchor.constraint(equalToConstant: 50),
            categoryImageView.centerXAnchor.constraint(equalTo: redView.centerXAnchor, constant: 0)
        ])

        redView.addSubview(labelStackView)
        NSLayoutConstraint.activate([
            categoryLabel.heightAnchor.constraint(equalToConstant: 20),
            cityLabel.heightAnchor.constraint(equalToConstant: 20),
            dateLabel.heightAnchor.constraint(equalToConstant: 20),
            labelStackView.topAnchor.constraint(equalTo: categoryImageView.bottomAnchor, constant: 8),
            labelStackView.bottomAnchor.constraint(equalTo: redView.bottomAnchor, constant: -8),
            labelStackView.trailingAnchor.constraint(equalTo: redView.trailingAnchor, constant: -10),
            labelStackView.leadingAnchor.constraint(equalTo: redView.leadingAnchor, constant: 10)
        ])
    }
    
    private func setupHeartImageViewConstraints() {
        redView.addSubview(heartImageView)
        NSLayoutConstraint.activate([
            heartImageView.centerXAnchor.constraint(equalTo: redView.centerXAnchor, constant: 0),
            heartImageView.centerYAnchor.constraint(equalTo: redView.centerYAnchor, constant: 0),
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
