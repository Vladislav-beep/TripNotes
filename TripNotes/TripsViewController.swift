//
//  ViewController.swift
//  TripNotes
//
//  Created by Владислав Сизонов on 13.12.2021.
//

import UIKit

class TripsViewController: UIViewController {

    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .white
        tableView.register(TripTableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    lazy var navigationImage: UIButton = {
       let button = UIButton()
       button.setImage(UIImage(named: "my profile"), for: .normal)
     //  button.addTarget(self, action: #selector(imageTapped), for: .touchUpInside)
       return button
   }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .green
        title = "Trips"
        
        setupTableContraints()
        
        let add = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTapped))
        let play = UIBarButtonItem(title: "Play", style: .plain, target: self, action: #selector(addTapped))
        navigationItem.rightBarButtonItems = [add, play]
    }
    
    @objc func addTapped() {
        
    }
    
    func setupTableContraints() {
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0)
        ])
    }
    
   
}

extension TripsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? TripTableViewCell
        guard let tableCell = cell else { return UITableViewCell() }
        
        return tableCell
    }
    
    
}

