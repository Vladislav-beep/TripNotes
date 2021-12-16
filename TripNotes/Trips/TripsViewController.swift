//
//  ViewController.swift
//  TripNotes
//
//  Created by Владислав Сизонов on 13.12.2021.
//

import UIKit

class TripsViewController: UIViewController {
    
    
    let trips = Trip.getData()

    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .white
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    lazy var addButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .tripRed
        let image = UIImage(systemName: "plus")
        button.setImage(image, for: .normal)
        button.layer.cornerRadius = 25
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var navigationImage: UIButton = {
       let button = UIButton()
       button.setImage(UIImage(named: "my profile"), for: .normal)
     //  button.addTarget(self, action: #selector(imageTapped), for: .touchUpInside)
       return button
   }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Trips"
        
        
        setupTableContraints()
        setupAddButtonConstraints()
        tableView.delegate = self
        tableView.dataSource = self
        
//        let add = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTapped))
//        let play = UIBarButtonItem(title: "Play", style: .plain, target: self, action: #selector(addTapped))
//        navigationItem.rightBarButtonItems = [add, play]
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
    
    func setupAddButtonConstraints() {
        navigationController?.view.addSubview(addButton)
        NSLayoutConstraint.activate([
            addButton.centerXAnchor.constraint(equalTo: (navigationController?.view.centerXAnchor)!, constant: 0),
            addButton.bottomAnchor.constraint(equalTo: navigationController!.view.bottomAnchor, constant: -UIScreen.main.bounds.height / 7),
            addButton.widthAnchor.constraint(equalToConstant: 60),
            addButton.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
    
   
}

extension TripsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(trips.count)
        return trips.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        
        let trip = trips[indexPath.row]
        cell?.textLabel?.text = trip.country
        print(trip.country)
        return cell!
    }
}

extension TripsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        120
    }
}

