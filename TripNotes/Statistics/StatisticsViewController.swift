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
    
    private lazy var hotelsStack: UIStackView = {
        let text = viewModel.hotelText
        let stack = UIStackView.statisticsStackView(withImage: C.ImageNames.hotel.rawValue,
                                                    withText: text)
        return stack
    }()
    
    private lazy var transportStack: UIStackView = {
        let text = viewModel.trasportText
        let stack = UIStackView.statisticsStackView(withImage: C.ImageNames.transport.rawValue,
                                                    withText: text)
        return stack
    }()
    
    private lazy var foodStack: UIStackView = {
        let text = viewModel.foodText
        let stack = UIStackView.statisticsStackView(withImage: C.ImageNames.food.rawValue,
                                                    withText: text)
        return stack
    }()
    
    private lazy var activityStack: UIStackView = {
        let text = viewModel.activityText
        let stack = UIStackView.statisticsStackView(withImage: C.ImageNames.activity.rawValue,
                                                    withText: text)
        return stack
    }()
    
    private lazy var purchasesStack: UIStackView = {
        let text = viewModel.purchasesText
        let stack = UIStackView.statisticsStackView(withImage: C.ImageNames.purchases.rawValue,
                                                    withText: text)
        return stack
    }()
    
    private lazy var otherStack: UIStackView = {
        let text = viewModel.otherText
        let stack = UIStackView.statisticsStackView(withImage: C.ImageNames.other.rawValue,
                                                    withText: text)
        return stack
    }()
    
    private lazy var commonStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [hotelsStack, transportStack, foodStack, activityStack, purchasesStack, otherStack],
                                axis: .vertical,
                                spacing: 16,
                                distribution: .fillEqually)
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
        setupCommonStackConstraints()
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
    
    private func setupCommonStackConstraints() {
        yellowView.addSubview(commonStack)
        
        NSLayoutConstraint.activate([
            commonStack.topAnchor.constraint(equalTo: headerLabel.bottomAnchor, constant: 16),
            commonStack.leadingAnchor.constraint(equalTo: yellowView.leadingAnchor, constant: 16),
            commonStack.trailingAnchor.constraint(equalTo: yellowView.trailingAnchor, constant: -16),
            commonStack.heightAnchor.constraint(equalToConstant: 240)
        ])
    }
}
