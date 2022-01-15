//
//  NewNoteViewController.swift
//  TripNotes
//
//  Created by Владислав Сизонов on 11.01.2022.
//

import UIKit

class NewNoteViewController: UIViewController {
    
    var viewModel: NewNoteViewModelProtocol?
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private lazy var lowerView: UIView = {
        let lowerView = UIView()
        lowerView.backgroundColor = .white
        lowerView.translatesAutoresizingMaskIntoConstraints = false
        return lowerView
    }()
    
    private lazy var transportLabel: UILabel = {
        let lb = UILabel()
        lb.text = "Transport"
        lb.adjustsFontSizeToFitWidth = true
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.heightAnchor.constraint(equalToConstant: 20).isActive = true
        return lb
    }()
    
    private lazy var transportButton: CurrencyButton = {
        let transportButton = CurrencyButton()
        transportButton.setImage(imageName: "car")
        transportButton.setup()
        transportButton.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
        transportButton.translatesAutoresizingMaskIntoConstraints = false
        return transportButton
    }()
    
    private lazy var transportStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [transportLabel, transportButton], axis: .vertical, spacing: 5, distribution: .fillProportionally)
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private lazy var addNoteTripButton: UIButton = {
        let addNoteTripButton = UIButton()
        addNoteTripButton.backgroundColor = .tripRed
        addNoteTripButton.layer.cornerRadius = 10
        addNoteTripButton.setTitle("+ Add Note", for: .normal)
        addNoteTripButton.titleLabel?.font = .systemFont(ofSize: 20, weight: .regular)
        addNoteTripButton.layer.shadowColor = UIColor.darkGray.cgColor
        addNoteTripButton.layer.shadowRadius = 4
        addNoteTripButton.layer.shadowOpacity = 0.4
        addNoteTripButton.layer.shadowOffset = CGSize(width: 0, height: 5)
        addNoteTripButton.translatesAutoresizingMaskIntoConstraints = false
        return addNoteTripButton
    }()
    
    init(viewModel: NewNoteViewModelProtocol) {
        super.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
    }
    
    @objc func buttonTapped(_ sender: CurrencyButton) {
        transportButton.isSelected = true
        transportButton.pulsate()
    }
    
//    @objc func selectCurrency(_ sender: CurrencyButton) {
//        buttonArray.forEach {
//            $0.isSelected = false
//            $0.stopAnimation()
//        }
//        sender.isSelected = true
//        sender.pulsate()
//    }
    
    private func setupConstraints() {
        setupScrollViewConstraints()
        setupLowerViewConstraints()
        setupAddNewTripButtonConstraints()
        setup()
    }
    
    private func setupScrollViewConstraints() {
        view.addSubview(scrollView)
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
        ])
    }
    
    private func setupLowerViewConstraints() {
        scrollView.addSubview(lowerView)
        NSLayoutConstraint.activate([
            lowerView.centerYAnchor.constraint(equalTo: scrollView.centerYAnchor),
            lowerView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            lowerView.heightAnchor.constraint(equalTo: view.heightAnchor),
            lowerView.widthAnchor.constraint(equalTo: view.widthAnchor)
        ])
    }
    
    private func setupAddNewTripButtonConstraints() {
        lowerView.addSubview(addNoteTripButton)
        NSLayoutConstraint.activate([
            addNoteTripButton.bottomAnchor.constraint(equalTo: lowerView.bottomAnchor, constant: -35),
            addNoteTripButton.leadingAnchor.constraint(equalTo: lowerView.leadingAnchor, constant: 20),
            addNoteTripButton.trailingAnchor.constraint(equalTo: lowerView.trailingAnchor, constant: -20),
            addNoteTripButton.heightAnchor.constraint(equalToConstant: 58)
        ])
    }
    
    private func setup() {
        lowerView.addSubview(transportStackView)
        NSLayoutConstraint.activate([
            transportStackView.topAnchor.constraint(equalTo: lowerView.topAnchor, constant: 35),
            transportStackView.leadingAnchor.constraint(equalTo: lowerView.leadingAnchor, constant: 20),
          //  transportStackView.trailingAnchor.constraint(equalTo: lowerView.trailingAnchor, constant: -20),
            transportStackView.heightAnchor.constraint(equalToConstant: 100),
            transportStackView.widthAnchor.constraint(equalToConstant: 58)
        ])
    }
}





