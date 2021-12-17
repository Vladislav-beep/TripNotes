//
//  ViewController.swift
//  TripNotes
//
//  Created by Владислав Сизонов on 13.12.2021.
//

import UIKit

class TripsViewController: UIViewController {
    
   // let trips = Trip.getData()
    private var viewModel: TripsViewModelProtocol! {
        didSet {
            viewModel.getTrips { [weak self] in
                self?.tableView.reloadData()
            }
        }
    }

    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .white
        tableView.register(TripTableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private lazy var addButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .tripRed
        let image = UIImage(systemName: "plus")
        button.setImage(image, for: .normal)
        button.layer.cornerRadius = 25
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var settingsButton: UIBarButtonItem = {
        let button = UIBarButtonItem.customButton(self,
                                                  action: #selector(addTapped),
                                                  imageName: "gear",
                                                  widthAndHeight: 40)
        return button
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Trips"
        setupNavigationBar()
        viewModel = TripsViewModel()
        
        setupTableContraints()
        setupAddButtonConstraints()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    @objc func addTapped() {
        print("sc")
    }
    
    private func setupNavigationBar() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.leftBarButtonItems = [settingsButton]
        navigationController?.navigationBar.tintColor = .tripWhite
        
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.configureWithOpaqueBackground()
        navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.tripWhite]
        navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.tripWhite]
        navBarAppearance.backgroundColor = .tripRed
        navigationController?.navigationBar.standardAppearance = navBarAppearance
        navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
    }
    
    private func setupTableContraints() {
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0)
        ])
    }
    
    private func setupAddButtonConstraints() {
        navigationController?.view.addSubview(addButton)
        NSLayoutConstraint.activate([
            addButton.centerXAnchor.constraint(equalTo: navigationController?.view.centerXAnchor ?? NSLayoutXAxisAnchor(), constant: 0),
            addButton.bottomAnchor.constraint(equalTo: navigationController?.view.bottomAnchor ?? NSLayoutYAxisAnchor(), constant: -UIScreen.main.bounds.height / 7.5),
            addButton.widthAnchor.constraint(equalToConstant: 60),
            addButton.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
}

extension TripsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? TripTableViewCell
   
        cell?.viewModel = viewModel.tripCellViewModel(for: indexPath)
        return cell ?? UITableViewCell()
    }
}

extension TripsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        120
    }
}



