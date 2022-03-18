//
//  TripTableViewCell.swift
//  TripNotes
//
//  Created by Владислав Сизонов on 13.12.2021.
//

import UIKit

class TripTableViewCell: UITableViewCell {
    
    // MARK: - Dependencies
    
    var viewModel: TripTableViewCellViewModelProtocol? {
        didSet {
            countryLabel.text = viewModel?.country
            descriptionLabel.text = viewModel?.description
            dateLabel.text = viewModel?.date
            totalSumLabel.text = viewModel?.getTotalSum()

            setupAvatarImage()
        }
    }
 
    // MARK: - UI
    
    private lazy var tripImageView: UIImageView = {
        let tripImageView = UIImageView()
        tripImageView.layer.cornerRadius = 10
        tripImageView.clipsToBounds = true
        tripImageView.contentMode = .scaleAspectFill
        tripImageView.image = UIImage(named: Constants.ImageNames.tripPlaceHolderImage.rawValue)
        tripImageView.layer.opacity = 0.75
        tripImageView.backgroundColor = .tripRed
        tripImageView.translatesAutoresizingMaskIntoConstraints = false
        return tripImageView
    }()
    
    private lazy var countryLabel: TripCellLabel = {
        let countryLabel = TripCellLabel(lineNumber: 1, fontSize: 22)
        return countryLabel
    }()
    
    private lazy var descriptionLabel: TripCellLabel = {
        let descriptionLabel = TripCellLabel(lineNumber: 2, fontSize: 15)
        return descriptionLabel
    }()
    
    private lazy var descriptionView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var dateLabel: TripCellLabel = {
        let dateLabel = TripCellLabel(lineNumber: 1, fontSize: 17)
        return dateLabel
    }()
    
    private lazy var totalSumLabel: TotalSumLabel = {
        let totalSumLabel = TotalSumLabel(fontSize: 40)
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
    
    private lazy var textView: UIView = {
        let textView = UIView()
        textView.backgroundColor = .tripRed
        textView.layer.opacity = 0.45
        textView.layer.cornerRadius = 8
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    // MARK: - Life Time
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupAllConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private methods
    
    private func setupAvatarImage() {
        let imageData = viewModel?.retrieveImage()
        if imageData?.count != 0 {
            self.tripImageView.image = UIImage(data: imageData ?? Data())
        }
    }
    
    // MARK: - Layout
    
    private func setupAllConstraints() {
        setupTripImageConstraints()
        setupTextViewConstraints()
        setupTotalSumLabelConstraints()
        descriptionLabelConstraints()
        setupInfoStackViewConstraints()
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
    
    private func setupTextViewConstraints() {
        contentView.addSubview(textView)
        NSLayoutConstraint.activate([
            textView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            textView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: -10),
            textView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -30),
            textView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -44),
        ])
    }
    
    private func setupInfoStackViewConstraints() {
        descriptionLabelConstraints()
        contentView.addSubview(infoStackView)
        NSLayoutConstraint.activate([
            infoStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            infoStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 18),
            infoStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -30),
            infoStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -44),
        ])
    }
}
