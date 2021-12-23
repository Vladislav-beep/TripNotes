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
        tableView.separatorStyle = .none
        tableView.register(TripTableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private lazy var addTripButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .tripRed
        let image = UIImage(systemName: "plus")
        button.setImage(image, for: .normal)
        button.layer.cornerRadius = 25
        button.addTarget(self, action: #selector(addTrip), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var addNoteButton: UIButton = {
        let addNoteButton = UIButton()
        addNoteButton.setTitle("Add Note", for: .normal)
        addNoteButton.layer.cornerRadius = 8
        addNoteButton.translatesAutoresizingMaskIntoConstraints = false
        addNoteButton.backgroundColor = .tripRed
        return addNoteButton
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
        setupAddNoteButtonConstraints()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        addTripButton.isHidden = false
        addNoteButton.isHidden = true
    }
    
    @objc func addTapped() {
        print("sc")
    }
    
    @objc func addTrip() {
        let newTripViewModel = viewModel.newTripViewModel
        let newTripVC = NewTripViewController(viewModel: newTripViewModel())
        present(newTripVC, animated: true)
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
    
    private func editAction(at indexPath: IndexPath) -> UIContextualAction {
        let editAction = UIContextualAction(style: .normal, title: "Edit Trip") { (action, view, complition) in
            
           //: TODO переход на экран добаления трипа
            complition(true)
        }
        editAction.backgroundColor = .tripBlue
        editAction.image = UIImage(systemName: Constants.ImageNames.tripEditRowImage.rawValue)
        return editAction
    }
    
    private func deleteAction(at indexPath: IndexPath) -> UIContextualAction {
        let action = UIContextualAction(style: .destructive, title: "Delete") { (action, view, complition) in
            
           // self.tableView.deleteRows(at: [indexPath], with: .automatic)
            complition(true)
        }
        action.backgroundColor = .tripRed
        action.image = UIImage(systemName: Constants.ImageNames.tripDeleteRowImage.rawValue)
        return action
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
        navigationController?.view.addSubview(addTripButton)
        NSLayoutConstraint.activate([
            addTripButton.centerXAnchor.constraint(equalTo: navigationController?.view.centerXAnchor ?? NSLayoutXAxisAnchor(), constant: 0),
            addTripButton.bottomAnchor.constraint(equalTo: navigationController?.view.bottomAnchor ?? NSLayoutYAxisAnchor(), constant: -UIScreen.main.bounds.height / 7.5),
            addTripButton.widthAnchor.constraint(equalToConstant: 60),
            addTripButton.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
    
    func setupAddNoteButtonConstraints() {
        navigationController?.view.addSubview(addNoteButton)
        NSLayoutConstraint.activate([
            addNoteButton.centerXAnchor.constraint(equalTo: navigationController?.view.centerXAnchor ?? NSLayoutXAxisAnchor(), constant: 0),
            addNoteButton.bottomAnchor.constraint(equalTo: navigationController?.view.bottomAnchor ?? NSLayoutYAxisAnchor(), constant: -UIScreen.main.bounds.height / 7.5),
            addNoteButton.widthAnchor.constraint(equalToConstant: 100),
            addNoteButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}

extension TripsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfRows(section: section)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        2
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        viewModel.titleForHeaderInSection(section: section)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let returnedView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 35))
           returnedView.backgroundColor = .clear
        
        let kview = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width / 2 - 20, height: 25))
        kview.layer.cornerRadius = 2
        kview.layer.opacity = 0.6
        kview.backgroundColor = .tripYellow
        
        let label = UILabel(frame: CGRect(x: 10, y: 0, width: view.frame.size.width, height: 25))
        label.font = UIFont.boldSystemFont(ofSize: 22)
        label.text = viewModel.titleForHeaderInSection(section: section)
        label.textColor = .tripBlue
            returnedView.addSubview(kview)
        returnedView.addSubview(label)
        return returnedView
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? TripTableViewCell
   
        cell?.viewModel = viewModel.tripCellViewModel(for: indexPath)
        return cell ?? UITableViewCell()
    }
}

extension TripsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        150
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let notesViewModel = viewModel.viewModelForSelectedRow(at: indexPath)
        addTripButton.isHidden = true
        addNoteButton.isHidden = false
        navigationController?.pushViewController(NotesViewController(notesViewModel: notesViewModel), animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
         
        }
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let done = deleteAction(at: indexPath)
        // TODO - delete row
        return UISwipeActionsConfiguration(actions: [done])
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let edit = editAction(at: indexPath)
        
        return UISwipeActionsConfiguration(actions: [edit])
    }
}



