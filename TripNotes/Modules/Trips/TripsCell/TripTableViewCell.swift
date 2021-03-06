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
            currencyLabel.text = viewModel?.currency

            setupAvatarImage()
        }
    }
 
    // MARK: - UI
    
    private lazy var tripImageView: UIImageView = {
        let tripImageView = UIImageView()
        tripImageView.layer.cornerRadius = 22
        tripImageView.clipsToBounds = true
        tripImageView.contentMode = .scaleAspectFill
        tripImageView.image = UIImage(named: C.ImageNames.tripPlaceHolder.rawValue)
        tripImageView.backgroundColor = .tripRed
        tripImageView.layer.opacity = 0.75
        tripImageView.translatesAutoresizingMaskIntoConstraints = false
        return tripImageView
    }()
    
    private lazy var countryLabel: TripCellLabel = {
        let countryLabel = TripCellLabel(lineNumber: 1, fontSize: 18)
        return countryLabel
    }()
    
    private lazy var descriptionLabel: TripCellLabel = {
        let descriptionLabel = TripCellLabel(lineNumber: 1, fontSize: 14)
        return descriptionLabel
    }()
    
    private lazy var descriptionView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var dateLabel: TripCellLabel = {
        let dateLabel = TripCellLabel(lineNumber: 1, fontSize: 15)
        return dateLabel
    }()
    
    private lazy var currencyLabel: TotalSumLabel = {
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
        } else {
            tripImageView.image = nil
        }
    }
    
    // MARK: - Layout
    
    private func setupAllConstraints() {
        setupTripImageConstraints()
        setupTotalSumLabelConstraints()
        descriptionLabelConstraints()
        setupInfoStackViewConstraints()
    }
    
    private func setupTripImageConstraints() {
        contentView.addSubview(tripImageView)
        NSLayoutConstraint.activate([
            tripImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            tripImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
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
        contentView.addSubview(currencyLabel)
        NSLayoutConstraint.activate([
            currencyLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
            currencyLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            currencyLabel.widthAnchor.constraint(equalToConstant: 150),
            currencyLabel.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    private func setupInfoStackViewConstraints() {
        descriptionLabelConstraints()
        contentView.addSubview(infoStackView)
        NSLayoutConstraint.activate([
            infoStackView.topAnchor.constraint(equalTo: tripImageView.topAnchor, constant: 55),
            infoStackView.leadingAnchor.constraint(equalTo: tripImageView.leadingAnchor, constant: 10),
            infoStackView.trailingAnchor.constraint(equalTo: tripImageView.trailingAnchor, constant: -30),
            infoStackView.bottomAnchor.constraint(equalTo: tripImageView.bottomAnchor, constant: -10),
        ])
    }
}
