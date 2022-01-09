//
//  NoteCell.swift
//  TripNotes
//
//  Created by Владислав Сизонов on 08.01.2022.
//

import UIKit

class NoteCell: UICollectionViewCell {
    
    private lazy var lowerView: UIView = {
        let lowerView = UIView()
        lowerView.backgroundColor = .tripYellow
        lowerView.layer.cornerRadius = 10
        lowerView.layer.opacity = 0.5
        lowerView.translatesAutoresizingMaskIntoConstraints = false
        return lowerView
    }()
    
    private lazy var categoryImageView: UIImageView = {
        let categoryImageView = UIImageView()
        categoryImageView.layer.cornerRadius = 5
        categoryImageView.translatesAutoresizingMaskIntoConstraints = false
        categoryImageView.backgroundColor = .tripBlue
        return categoryImageView
    }()
    
    private lazy var favouriteButton: UIButton = {
        let favouriteButton = UIButton()
        favouriteButton.layer.cornerRadius = 5
        favouriteButton.setBackgroundImage(UIImage(systemName: "heart"), for: .normal)
        favouriteButton.tintColor = .tripBlue
        favouriteButton.backgroundColor = .clear
        favouriteButton.translatesAutoresizingMaskIntoConstraints = false
        return favouriteButton
    }()
    
    private lazy var categoryLabel: UILabel = {
        let categoryLabel = UILabel()
        categoryLabel.adjustsFontSizeToFitWidth = true
        categoryLabel.font = UIFont.systemFont(ofSize: 17, weight: .heavy)
        categoryLabel.translatesAutoresizingMaskIntoConstraints = false
        return categoryLabel
    }()
    private lazy var cityLabel: UILabel = {
        let cityLabel = UILabel()
        cityLabel.adjustsFontSizeToFitWidth = true
        cityLabel.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        cityLabel.minimumScaleFactor = 0.5
        cityLabel.translatesAutoresizingMaskIntoConstraints = false
        return cityLabel
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let descriptionLabel = UILabel()
        descriptionLabel.adjustsFontSizeToFitWidth = true
        descriptionLabel.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        descriptionLabel.minimumScaleFactor = 0.5
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        return descriptionLabel
    }()
    
    private lazy var dateLabel: UILabel = {
        let dateLabel = UILabel()
        dateLabel.adjustsFontSizeToFitWidth = true
        dateLabel.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        dateLabel.minimumScaleFactor = 0.5
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLowerViewConstraints()
        setupCategoryImageViewConstraints()
        setupLabelStackViewConstraints()
        setupSumLabelConstraints()
        setupFavouteButtonConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var viewModel: NoteCellViewModelProtocol! {
        didSet {
            categoryLabel.text = viewModel.category
            descriptionLabel.text = viewModel.description
            cityLabel.text = viewModel.city
            dateLabel.text = viewModel.date
            sumLabel.text = viewModel.price
            lowerView.setupBackGroundColor(for: viewModel.backGroundCategory)
        }
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
            categoryImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
            categoryImageView.widthAnchor.constraint(equalTo: categoryImageView.heightAnchor),
            categoryImageView.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    private func setupFavouteButtonConstraints() {
        contentView.addSubview(favouriteButton)
        NSLayoutConstraint.activate([
            favouriteButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            favouriteButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5),
            favouriteButton.widthAnchor.constraint(equalTo: favouriteButton.heightAnchor),
            favouriteButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    private func setupLabelStackViewConstraints() {
        contentView.addSubview(labelStackView)
        NSLayoutConstraint.activate([
            labelStackView.topAnchor.constraint(equalTo: categoryImageView.bottomAnchor, constant: 5),
            labelStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
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
