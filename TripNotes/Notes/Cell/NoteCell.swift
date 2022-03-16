//
//  NoteCell.swift
//  TripNotes
//
//  Created by Владислав Сизонов on 08.01.2022.
//

import UIKit

class NoteCell: UICollectionViewCell {
    
    // MARK: - Dependencies
    
    var viewModel: NoteCellViewModelProtocol! {
        didSet {
            categoryLabel.text = viewModel.category
            descriptionLabel.text = viewModel.description
            cityLabel.text = viewModel.city
            dateLabel.text = viewModel.date
            sumLabel.text = viewModel.price
            categoryImageView.image = setImage(for: viewModel.category)
            setupUI()
        }
    }
    
    // MARK: - UI
    
    private lazy var lowerView: UIView = {
        let lowerView = UIView()
        lowerView.backgroundColor = .tripYellow
        lowerView.layer.cornerRadius = 10
        lowerView.layer.opacity = 1
        lowerView.translatesAutoresizingMaskIntoConstraints = false
        return lowerView
    }()
    
    private lazy var categoryImageView: UIImageView = {
        let categoryImageView = UIImageView()
        categoryImageView.layer.cornerRadius = 5
        categoryImageView.tintColor = .tripBlue
        categoryImageView.contentMode = .scaleAspectFit
        categoryImageView.translatesAutoresizingMaskIntoConstraints = false
        return categoryImageView
    }()
    
    private lazy var infoLabel: UILabel = {
        let infoLabel = UILabel()
        infoLabel.textAlignment = .right
        infoLabel.textColor = .tripBlue
        infoLabel.numberOfLines = 2
        infoLabel.adjustsFontSizeToFitWidth = true
        infoLabel.isHidden = true
        infoLabel.translatesAutoresizingMaskIntoConstraints = false
        return infoLabel
    }()
    
    private lazy var categoryLabel: NoteLabel = {
        let categoryLabel = NoteLabel(fontSize: 17, fontWeight: .heavy)
        return categoryLabel
    }()
    private lazy var cityLabel: NoteLabel = {
        let cityLabel = NoteLabel(fontSize: 15, fontWeight: .bold)
        return cityLabel
    }()
    
    private lazy var descriptionLabel: NoteLabel = {
        let descriptionLabel = NoteLabel(fontSize: 14, fontWeight: .medium)
        descriptionLabel.numberOfLines = 2
        return descriptionLabel
    }()
    
    private lazy var dateLabel: NoteLabel = {
        let dateLabel = NoteLabel(fontSize: 13, fontWeight: .regular)
        return dateLabel
    }()
    
    private lazy var labelStackView: UIStackView = {
        let labelStackView = UIStackView(arrangedSubviews: [categoryLabel, cityLabel, descriptionLabel, dateLabel],
                                         axis: .vertical,
                                         spacing: 5,
                                         distribution: .fillProportionally)
        labelStackView.translatesAutoresizingMaskIntoConstraints = false
        return labelStackView
    }()
    
    private lazy var sumLabel: UILabel = {
        let sumLabel = UILabel()
        sumLabel.adjustsFontSizeToFitWidth = true
        sumLabel.font = UIFont.systemFont(ofSize: 24, weight: .heavy)
        sumLabel.minimumScaleFactor = 0.3
        sumLabel.textAlignment = .right
        sumLabel.textColor = .tripBlue
        sumLabel.translatesAutoresizingMaskIntoConstraints = false
        return sumLabel
    }()
    
    // MARK: - Life Time
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupAllConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private methods
    
    @objc func refresh() {
        setupUI()
    }
    
    private func setupUI() {
        if viewModel.isFavourite {
            lowerView.layer.borderWidth = 3.5
            lowerView.layer.borderColor = UIColor.tripRed.cgColor
        } else {
            lowerView.layer.borderWidth = 0
        }
        
        if viewModel.isInfoShown {
            infoLabel.isHidden = false
            infoLabel.text = viewModel.infoLabel
        }
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
    
    // MARK: - Layout
    
    private func setupAllConstraints() {
        setupLowerViewConstraints()
        setupCategoryImageViewConstraints()
        setupInfoLabelConstraints() 
        setupLabelStackViewConstraints()
        setupSumLabelConstraints()
    }
    
    private func setupLowerViewConstraints() {
        contentView.addSubview(lowerView)
        NSLayoutConstraint.activate([
            lowerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0),
            lowerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0),
            lowerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0),
            lowerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20)
        ])
    }
    
    private func setupCategoryImageViewConstraints() {
        contentView.addSubview(categoryImageView)
        NSLayoutConstraint.activate([
            categoryImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            categoryImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            categoryImageView.widthAnchor.constraint(equalTo: categoryImageView.heightAnchor),
            categoryImageView.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    private func setupInfoLabelConstraints() {
        contentView.addSubview(infoLabel)
        NSLayoutConstraint.activate([
            infoLabel.centerYAnchor.constraint(equalTo: categoryImageView.centerYAnchor, constant: 0),
            infoLabel.heightAnchor.constraint(equalTo: categoryImageView.heightAnchor),
            infoLabel.leadingAnchor.constraint(equalTo: categoryImageView.trailingAnchor, constant: 10),
            infoLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5)
        ])
    }
    
    private func setupLabelStackViewConstraints() {
        contentView.addSubview(labelStackView)
        NSLayoutConstraint.activate([
            labelStackView.topAnchor.constraint(equalTo: categoryImageView.bottomAnchor, constant: 5),
            labelStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            labelStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5),
            labelStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -30)
        ])
    }
    
    private func setupSumLabelConstraints() {
        contentView.addSubview(sumLabel)
        NSLayoutConstraint.activate([
            sumLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5),
            sumLabel.widthAnchor.constraint(equalToConstant: 100),
            sumLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -2),
            sumLabel.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
}
