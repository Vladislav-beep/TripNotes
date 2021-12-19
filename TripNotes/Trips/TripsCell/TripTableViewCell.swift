//
//  TripTableViewCell.swift
//  TripNotes
//
//  Created by Владислав Сизонов on 13.12.2021.
//

import UIKit

 class TripTableViewCell: UITableViewCell {
    
    private lazy var tripImageView: UIImageView = {
        let tripImageView = UIImageView()
        tripImageView.layer.cornerRadius = 10
        tripImageView.clipsToBounds = true
        tripImageView.contentMode = .scaleAspectFill
        tripImageView.image = UIImage(named: "placeHolder2")
        tripImageView.layer.opacity = 0.65
        tripImageView.backgroundColor = .tripRed
        tripImageView.translatesAutoresizingMaskIntoConstraints = false
        return tripImageView
    }()
    
    private lazy var countryLabel: UILabel = {
        let countryLabel = UILabel()
        countryLabel.textColor = .tripWhite
        countryLabel.numberOfLines = 1
        countryLabel.font = UIFont.boldSystemFont(ofSize: 22)
        countryLabel.translatesAutoresizingMaskIntoConstraints = false
        return countryLabel
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let descriptionLabel = UILabel()
        descriptionLabel.textColor = .tripWhite
        descriptionLabel.numberOfLines = 2
        descriptionLabel.font = UIFont.systemFont(ofSize: 15)
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        return descriptionLabel
    }()
    
    private lazy var descriptionView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var dateLabel: UILabel = {
        let dateLabel = UILabel()
        dateLabel.textColor = .tripWhite
        dateLabel.numberOfLines = 1
        dateLabel.font = UIFont.boldSystemFont(ofSize: 17)
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        return dateLabel
    }()
    
    private lazy var totalSumLabel: UILabel = {
        let totalSumLabel = UILabel()
        totalSumLabel.textColor = .tripBlue
        totalSumLabel.numberOfLines = 1
        totalSumLabel.font = UIFont.boldSystemFont(ofSize: 40)
        totalSumLabel.textAlignment = .right
        totalSumLabel.adjustsFontSizeToFitWidth = true
        totalSumLabel.minimumScaleFactor = 0.2
        totalSumLabel.translatesAutoresizingMaskIntoConstraints = false
        return totalSumLabel
    }()
    
    private lazy var infoStackView: UIStackView = {
        let infoStackView = UIStackView(arrangedSubviews: [countryLabel, descriptionView, dateLabel],
                                        axis: .vertical,
                                        spacing: 4,
                                        distribution: .fill)
        infoStackView.translatesAutoresizingMaskIntoConstraints = false
        return infoStackView
    }()
    

    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupTripImageConstraints()
        setupTotalSumLabelConstraints()
        descriptionLabelConstraints()
        setupInfoStackViewConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var viewModel: TripTableViewCellViewModelProtocol! {
        didSet {
            countryLabel.text = viewModel.country
            descriptionLabel.text = viewModel.description
            dateLabel.text = viewModel.date
            totalSumLabel.text = viewModel.getTotalSum()
        }
    }
    
    private func setupTripImageConstraints() {
        contentView.addSubview(tripImageView)
        NSLayoutConstraint.activate([
            tripImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            tripImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20),
            tripImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            tripImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10)
        ])
    }
    
    private func descriptionLabelConstraints() {
        descriptionView.addSubview(descriptionLabel)
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: descriptionView.topAnchor, constant: 0),
            descriptionLabel.leadingAnchor.constraint(equalTo: descriptionView.leadingAnchor, constant: 0),
            descriptionLabel.trailingAnchor.constraint(equalTo: descriptionView.trailingAnchor, constant: 0),
            descriptionLabel.bottomAnchor.constraint(equalTo: descriptionView.bottomAnchor, constant: 0)
        ])
    }
    
    private func setupTotalSumLabelConstraints() {
        contentView.addSubview(totalSumLabel)
        NSLayoutConstraint.activate([
            totalSumLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5),
            totalSumLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),
            totalSumLabel.widthAnchor.constraint(equalToConstant: 150),
            totalSumLabel.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    private func setupInfoStackViewConstraints() {
        descriptionLabelConstraints()
        tripImageView.addSubview(infoStackView)
        NSLayoutConstraint.activate([
            infoStackView.topAnchor.constraint(equalTo: tripImageView.topAnchor, constant: 10),
            infoStackView.leadingAnchor.constraint(equalTo: tripImageView.leadingAnchor, constant: 15),
            infoStackView.trailingAnchor.constraint(equalTo: tripImageView.trailingAnchor, constant: -20),
            infoStackView.bottomAnchor.constraint(equalTo: tripImageView.bottomAnchor, constant: -30),
        
        ])
    }
}
