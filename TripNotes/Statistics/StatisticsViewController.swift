//
//  StatisticsViewController.swift
//  TripNotes
//
//  Created by Владислав Сизонов on 03.06.2022.
//

import UIKit

final class StatisticsViewController: UIViewController {
    
    // MARK: - Dependencies
    
    private var viewModel: StatisticsViewModelProtocol
    
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
    
    private lazy var headerLabel: UILabel = {
        let label = UILabel()
        label.text = I.headerLabel
        label.font = UIFont.systemFont(ofSize: 30, weight: .heavy)
        label.textAlignment = .center
        label.textColor = .tripBlue
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var transportImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: C.ImageNames.purchases.rawValue)
        imageView.tintColor = .tripBlue
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var transportLabel: UILabel = {
        let label = UILabel()
        label.text = "Transport: 100 000 $"
        label.font = UIFont.systemFont(ofSize: 25, weight: .bold)
        label.textColor = .tripBlue
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var transportStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [transportImageView, transportLabel],
                                axis: .horizontal,
                                spacing: 12,
                                distribution: .fill)
        return stack
    }()
    
    // MARK: - Lifecycle
    
    init(viewModel: StatisticsViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        setupAllConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Actions
    
    @objc private func closeScreen() {
        dismiss(animated: true)
    }
    
    // MARK: - Layout
    
    private func setupAllConstraints() {
        setupYellowViewConstraints()
        setupCloseButtonConstraints()
        setupHeaderLabelConstraints()
        setupTransportStackConstraints()
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
    
    private func setupHeaderLabelConstraints() {
        yellowView.addSubview(headerLabel)
        NSLayoutConstraint.activate([
            headerLabel.topAnchor.constraint(equalTo: closeButton.bottomAnchor, constant: -15),
            headerLabel.leadingAnchor.constraint(equalTo: yellowView.leadingAnchor, constant: 8),
            headerLabel.trailingAnchor.constraint(equalTo: yellowView.trailingAnchor, constant: -8),
            headerLabel.heightAnchor.constraint(equalToConstant: 25)
        ])
    }
    
    private func setupTransportStackConstraints() {
        yellowView.addSubview(transportStack)
        NSLayoutConstraint.activate([
            transportImageView.heightAnchor.constraint(equalToConstant: 30),
            transportImageView.widthAnchor.constraint(equalToConstant: 30),
            transportStack.topAnchor.constraint(equalTo: headerLabel.bottomAnchor, constant: 16),
            transportStack.leadingAnchor.constraint(equalTo: yellowView.leadingAnchor, constant: 16),
            transportStack.trailingAnchor.constraint(equalTo: yellowView.trailingAnchor, constant: -16),
            transportStack.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
}
