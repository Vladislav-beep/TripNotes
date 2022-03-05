//
//  ViewController.swift
//  TripNotes
//
//  Created by Владислав Сизонов on 13.12.2021.
//

import UIKit
import Firebase

class TripsViewController: UIViewController {
    
    // MARK: Dependencies
    
    private var viewModel: TripsViewModelProtocol
    
    private var newNoteViewModel: NewNoteViewModelProtocol?
    var coordinator: AppCoordinator?

    // MARK: UI
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .white
        tableView.separatorStyle = .none
        tableView.register(TripTableViewCell.self,
                           forCellReuseIdentifier: Constants.CellIdentifiers.tripTableViewCellId.rawValue)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private lazy var addTripButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .tripRed
        let image = UIImage(systemName: "plus")
        button.setImage(image, for: .normal)
        button.layer.cornerRadius = 25
        button.layer.shadowColor = UIColor.darkGray.cgColor
        button.layer.shadowRadius = 5
        button.layer.shadowOffset = CGSize(width: 0, height: 5)
        button.layer.shadowOpacity = 0.5
        button.layer.shouldRasterize = true
        button.addTarget(self, action: #selector(addTrip), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var addNoteButton: UIButton = {
        let addNoteButton = UIButton()
        addNoteButton.setTitle("Add Note", for: .normal)
        addNoteButton.layer.cornerRadius = 8
        addNoteButton.layer.shadowColor = UIColor.darkGray.cgColor
        addNoteButton.layer.shadowRadius = 5
        addNoteButton.layer.shadowOffset = CGSize(width: 0, height: 5)
        addNoteButton.layer.shadowOpacity = 0.5
        addNoteButton.layer.shouldRasterize = true
        addNoteButton.addTarget(self, action: #selector(addNote), for: .touchUpInside)
        addNoteButton.translatesAutoresizingMaskIntoConstraints = false
        addNoteButton.backgroundColor = .tripRed
        return addNoteButton
    }()
    
    private lazy var signOutButton: UIBarButtonItem = {
        let button = UIBarButtonItem.customButton(self,
                                                  action: #selector(signOutTapped),
                                                  imageName: "arrowshape.turn.up.left.2.fill",
                                                  widthAndHeight: 40)
        return button
    }()
    
    // MARK: Life Time
    
    init(viewModel: TripsViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
         
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Trips"
        
        setupNavigationBar()
        
        setupViewModelBindings()
      //  viewModel.getTrips()
        
        setupTableContraints()
        setupAddButtonConstraints()
        setupAddNoteButtonConstraints()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func setupViewModelBindings() {
        viewModel.firstCompletion = { [weak self] in
            self?.tableView.reloadData()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        addTripButton.isHidden = false
        addNoteButton.isHidden = true
        viewModel.getTrips()
    }
    
    // MARK: Actions
    
    @objc func signOutTapped() {
        do {
            try Auth.auth().signOut()
        } catch {
            print("\(error.localizedDescription) - error")
        }
        dismiss(animated: true)
    }
    
    deinit {
         print("deinit")
    }
    
    @objc func addTrip() {
        let newTripViewModel = viewModel.newTripViewModel()
        let newTripVC = NewTripViewController(viewModel: newTripViewModel, isEdited: false)
        newTripVC.modalPresentationStyle = .fullScreen
        present(newTripVC, animated: true)
    }
    
    @objc func addNote() {
        
        let newNoteVC = NewNoteViewController(viewModel: self.newNoteViewModel!)
        newNoteViewModel?.printAA()
        newNoteVC.modalPresentationStyle = .fullScreen
        parent?.present(newNoteVC, animated: true)
      //  present(newNoteVC, animated: true)
    }
    
    // MARK: Private methods
    
    private func setupNavigationBar() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.leftBarButtonItems = [signOutButton]
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

            //
            let newTripViewModel = self.viewModel.newTripViewModelEdited(for: indexPath)
            let newTripVC = NewTripViewController(viewModel: newTripViewModel, isEdited: true)
            newTripVC.isEdited = true
            newTripVC.modalPresentationStyle = .fullScreen
            self.present(newTripVC, animated: true)
            
            //
           //: TODO переход на экран добавления трипа
            complition(true)
        }
        editAction.backgroundColor = .tripBlue
        editAction.image = UIImage(systemName: Constants.ImageNames.tripEditRowImage.rawValue)
        return editAction
    }
    
    private func deleteAction(at indexPath: IndexPath) -> UIContextualAction {
        let action = UIContextualAction(style: .destructive, title: "Delete") { [weak self] (action, view, complition) in
            self?.viewModel.deleteRow(at: indexPath)
            self?.tableView.deleteRows(at: [indexPath], with: .automatic)
            print("1")
           // self.tableView.deleteRows(at: [indexPath], with: .automatic)
            complition(true)
        }
        action.backgroundColor = .tripRed
        action.image = UIImage(systemName: Constants.ImageNames.tripDeleteRowImage.rawValue)
        return action
    }
    
    // MARK: Layout
    
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

// MARK: TableViewDataSource

extension TripsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfRows(section: section)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int { 2 }
    
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
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.CellIdentifiers.tripTableViewCellId.rawValue) as? TripTableViewCell
   
        cell?.viewModel = viewModel.tripCellViewModel(for: indexPath)
        return cell ?? UITableViewCell()
    }
}

// MARK: TableViewDelegate

extension TripsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        150
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let notesViewModel = viewModel.viewModelForSelectedRow(at: indexPath)
        
        //
        let newNoteViewModel = viewModel.newNoteViewModel(at: indexPath)
        self.newNoteViewModel = newNoteViewModel
        
        //
        addTripButton.isHidden = true
        addNoteButton.isHidden = false
        navigationController?.pushViewController(NotesViewController(notesViewModel: notesViewModel), animated: true)
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
         return true
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            viewModel.deleteRow(at: indexPath)
            tableView.deleteRows(at: [indexPath], with: .automatic)
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



