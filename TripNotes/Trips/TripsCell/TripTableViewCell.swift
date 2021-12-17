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
        tripImageView.layer.cornerRadius = 20
        tripImageView.clipsToBounds = true
        tripImageView.contentMode = .scaleAspectFit
        tripImageView.backgroundColor = .tripRed
        tripImageView.translatesAutoresizingMaskIntoConstraints = false
        return tripImageView
    }()
    
    private lazy var countryLabel: UILabel = {
        let countryLabel = UILabel()
        countryLabel.textColor = .tripYellow
        countryLabel.numberOfLines = 0
        countryLabel.translatesAutoresizingMaskIntoConstraints = false
        return countryLabel
    }()
    
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupTripImageConstraints()
        setupCountryLabelConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var viewModel: TripTableViewCellViewModelProtocol! {
        didSet {
            countryLabel.text = viewModel.country
        }
    }
    
//    func configureCell(trip: Trip) {
//        countryLabel.text = trip.country
//    }
    

    private func setupTripImageConstraints() {
        contentView.addSubview(tripImageView)
        NSLayoutConstraint.activate([
            tripImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            tripImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20),
            tripImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            tripImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20)
        ])
    }
    
    private func setupCountryLabelConstraints() {
        tripImageView.addSubview(countryLabel)
        NSLayoutConstraint.activate([
            countryLabel.topAnchor.constraint(equalTo: tripImageView.topAnchor, constant: 20),
            countryLabel.leadingAnchor.constraint(equalTo: tripImageView.leadingAnchor, constant: 20),
            countryLabel.trailingAnchor.constraint(equalTo: tripImageView.trailingAnchor, constant: 20)
        ])
    } 
}
