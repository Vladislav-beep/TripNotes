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
        lowerView.translatesAutoresizingMaskIntoConstraints = false
        return lowerView
    }()
    
    private lazy var categoryImageView: UIImageView = {
        let categoryImageView = UIImageView()
        categoryImageView.translatesAutoresizingMaskIntoConstraints = false
        categoryImageView.backgroundColor = .tripBlue
        return categoryImageView
    }()
    
    private lazy var categoryTransportLabel: UILabel = {
        let categoryTransportLabel = UILabel()
        categoryTransportLabel.text = "Transport"
        categoryTransportLabel.font = UIFont.boldSystemFont(ofSize: 15)
        categoryTransportLabel.translatesAutoresizingMaskIntoConstraints = false
        return categoryTransportLabel
    }()
    private lazy var cityLabel: UILabel = {
        let cityLabel = UILabel()
        cityLabel.text = "Berlin"
        cityLabel.font = UIFont.systemFont(ofSize: 13, weight: .semibold)
        cityLabel.minimumScaleFactor = 0.5
        cityLabel.translatesAutoresizingMaskIntoConstraints = false
        return cityLabel
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let descriptionLabel = UILabel()
        descriptionLabel.text = "Bus ticket djjlejejkdnkeldfldfkfkfkfkfklf;s's;'ldfmmdf"
        descriptionLabel.font = UIFont.systemFont(ofSize: 13, weight: .medium)
        descriptionLabel.minimumScaleFactor = 0.5
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        return descriptionLabel
    }()
    
    private lazy var dateLabel: UILabel = {
        let dateLabel = UILabel()
        dateLabel.text = "11:34 12.02.2020"
        dateLabel.font = UIFont.systemFont(ofSize: 11, weight: .regular)
        dateLabel.minimumScaleFactor = 0.5
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        return dateLabel
    }()
    
    private lazy var labelStackView: UIStackView = {
        let labelStackView = UIStackView(arrangedSubviews: [categoryTransportLabel, cityLabel, descriptionLabel, dateLabel],
                                         axis: .vertical,
                                         spacing: 5,
                                         distribution: .fillProportionally)
        labelStackView.translatesAutoresizingMaskIntoConstraints = false
        return labelStackView
    }()
    
    private lazy var sumLabel: UILabel = {
        let sumLabel = UILabel()
        sumLabel.text = "21.65 $"
        sumLabel.font = UIFont.systemFont(ofSize: 23)
        sumLabel.minimumScaleFactor = 0.3
        sumLabel.textAlignment = .right
        sumLabel.translatesAutoresizingMaskIntoConstraints = false
        return sumLabel
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLowerViewConstraints()
        setupCategoryImageViewConstraints()
        setupLabelStackViewConstraints()
        setupSumLabelConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var viewModel: NoteCellViewModelProtocol! {
        didSet {
            categoryTransportLabel.text = viewModel.category
            descriptionLabel.text = viewModel.description
            cityLabel.text = viewModel.city
            dateLabel.text = viewModel.date
            sumLabel.text = viewModel.price
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
        lowerView.addSubview(categoryImageView)
        NSLayoutConstraint.activate([
            categoryImageView.topAnchor.constraint(equalTo: lowerView.topAnchor, constant: 5),
            categoryImageView.leadingAnchor.constraint(equalTo: lowerView.leadingAnchor, constant: 5),
            categoryImageView.trailingAnchor.constraint(equalTo: lowerView.trailingAnchor, constant: -5),
            categoryImageView.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    private func setupLabelStackViewConstraints() {
        lowerView.addSubview(labelStackView)
        NSLayoutConstraint.activate([
            labelStackView.topAnchor.constraint(equalTo: categoryImageView.bottomAnchor, constant: 5),
            labelStackView.leadingAnchor.constraint(equalTo: lowerView.leadingAnchor, constant: 5),
            labelStackView.trailingAnchor.constraint(equalTo: lowerView.trailingAnchor, constant: -5),
            labelStackView.bottomAnchor.constraint(equalTo: lowerView.bottomAnchor, constant: -30)
        ])
    }
    
    private func setupSumLabelConstraints() {
        contentView.addSubview(sumLabel)
        NSLayoutConstraint.activate([
            sumLabel.topAnchor.constraint(equalTo: labelStackView.bottomAnchor, constant: 5),
            sumLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5),
            sumLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 5),
            sumLabel.widthAnchor.constraint(equalToConstant: 100)
        ])
    }
}
