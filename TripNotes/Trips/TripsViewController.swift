//
//  ViewController.swift
//  TripNotes
//
//  Created by Владислав Сизонов on 13.12.2021.
//

import UIKit

class TripsViewController: UIViewController {
    
    // MARK: - Dependencies
    
    private var viewModel: TripsViewModelProtocol
    private var newNoteViewModel: NewNoteViewModelProtocol?
    var configurator: Configurator?

    // MARK: - UI
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .white
        tableView.separatorStyle = .none
        tableView.register(TripTableViewCell.self,
                           forCellReuseIdentifier: C.CellIdentifiers.tripTableView.rawValue)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private lazy var addTripButton: AddButton = {
        let button = AddButton(imageName: C.ImageNames.addTripButton.rawValue,
                               title: nil,
                               cornerRadius: 25)
        button.addTarget(self, action: #selector(addTrip), for: .touchUpInside)
        return button
    }()
    
    private lazy var addNoteButton: AddButton = {
        let addNoteButton = AddButton(imageName: nil, title: I.addNoteButtonTitle, cornerRadius: 8)
        addNoteButton.addTarget(self, action: #selector(addNote), for: .touchUpInside)
        return addNoteButton
    }()
    
    private lazy var signOutButton: UIBarButtonItem = {
        let button = UIBarButtonItem.customButton(self,
                                                  action: #selector(signOutTapped),
                                                  imageName: C.ImageNames.signOutButton.rawValue,
                                                  widthAndHeight: 40)
        return button
    }()
    
    private lazy var weatherButton: UIBarButtonItem = {
        let button = UIBarButtonItem.customButton(self,
                                                  action: #selector(showWeather),
                                                  imageName: C.ImageNames.weatherButton.rawValue,
                                                  widthAndHeight: 40)
        return button
    }()
    
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        return activityIndicator
    }()
    
    private lazy var noLabel: NoLabel = {
        let noLabel = NoLabel(title: I.noTripsLabel)
        return noLabel
    }()
    
    // MARK: - Life Time
    
    init(viewModel: TripsViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupViewModelBindings()
        setupAllConstraints()
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        addTripButton.isHidden = false
        addNoteButton.isHidden = true
        activityIndicator.startAnimating()
        viewModel.fetchTrips()
        tableView.reloadData()
    }
    
    // MARK: - Actions
    
    @objc func signOutTapped() {
        showSignOutAlert(title: I.signOutAlertTitle,
                         message: I.signOutAlertMessage) { [weak self] in
            self?.signOut()
        }
    }
    
    @objc func addTrip() {
        let newTripVC = configurator?.configureNewTrip(with: "", userId: viewModel.userId, isEdited: false) ?? UIViewController()
        present(newTripVC, animated: true)
    }
    
    @objc func addNote() {
        let newNoteVC = configurator?.configureNewNote(with: self.newNoteViewModel, isEdited: false) ?? UIViewController()
        parent?.present(newNoteVC, animated: true)
    }
    
    @objc func showWeather() {
        let weatherVC = configurator?.configureWeatherVC() ?? UIViewController()
        present(weatherVC, animated: true)
    }
    
    // MARK: - Private methods
    
    private func setupViewModelBindings() {
        viewModel.firstCompletion = { [weak self] in
            self?.tableView.reloadData()
            self?.setupUI()
            self?.activityIndicator.stopAnimating()
            self?.activityIndicator.isHidden = true
        }
        
        viewModel.errorCompletion = { [weak self] error in
            self?.showAlert(title: I.errorAlertFetchingTrips, message: error.errorDescription)
        }
    }
    
    private func setupUI() {
        if viewModel.numberOfRows(section: 0) == 0 && viewModel.numberOfRows(section: 1) == 0 {
            noLabel.isHidden = false
        } else {
            noLabel.isHidden = true
        }
    }
    
    private func signOut() {
        viewModel.signOut { [weak self] in
            self?.dismiss(animated: true)
        } completionError: { [weak self] in
            self?.showAlert(title: I.signOutAlertErrorTitle, message: I.signOutAlertErrorMessage)
        }
    }
    
    private func setupNavigationBar() {
        title = I.tabBarTripItemTitle
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.leftBarButtonItems = [signOutButton]
        navigationItem.rightBarButtonItems = [weatherButton]
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
        let editAction = UIContextualAction(style: .normal, title: I.editTripButtonTitle) { [weak self] (action, view, complition) in
            
            let tripId = self?.viewModel.getTripId(for: indexPath) ?? ""
            let userId = self?.viewModel.userId ?? ""
            let newTripVC = self?.configurator?.configureNewTrip(with: tripId, userId: userId, isEdited: true) ?? UIViewController()
            self?.present(newTripVC, animated: true)
            complition(true)
        }
        editAction.backgroundColor = .tripBlue
        editAction.image = UIImage(systemName: C.ImageNames.editIcon.rawValue)
        return editAction
    }
    
    private func deleteAction(at indexPath: IndexPath) -> UIContextualAction {
        let action = UIContextualAction(style: .destructive, title: I.deleteTripButtonTitle) {
            [weak self] (action, view, complition) in
            self?.viewModel.deleteRow(at: indexPath, errorCompletion: {
                self?.showAlert(title: I.deleteTripAlertTitle,
                                message: I.deleteTripAlertMessage)
            })

            self?.tableView.beginUpdates()
            self?.tableView.deleteRows(at: [indexPath], with: .automatic)
            self?.tableView.endUpdates()
            complition(true)
        }
        action.backgroundColor = .tripRed
        action.image = UIImage(systemName: C.ImageNames.deleteIcon.rawValue)
        return action
    }
    
    // MARK: - Layout
    
    private func setupAllConstraints() {
        setupTableContraints()
        setupAddButtonConstraints()
        setupAddNoteButtonConstraints()
        setupNoLabelConstraints()
        setupActivityIndicatorConstraints()
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
            addNoteButton.widthAnchor.constraint(equalToConstant: 120),
            addNoteButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    private func setupNoLabelConstraints() {
        view.addSubview(noLabel)
        NSLayoutConstraint.activate([
            noLabel.centerXAnchor.constraint(equalTo: tableView.centerXAnchor, constant: 0),
            noLabel.centerYAnchor.constraint(equalTo: tableView.centerYAnchor, constant: 0),
            noLabel.heightAnchor.constraint(equalToConstant: 60),
            noLabel.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width / 1.2)
        ])
    }
    
    private func setupActivityIndicatorConstraints() {
        view.addSubview(activityIndicator)
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: tableView.centerXAnchor, constant: 0),
            activityIndicator.centerYAnchor.constraint(equalTo: tableView.centerYAnchor, constant: 0)
        ])
    }
}

// MARK: - TableViewDataSource
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
        
        let yellowView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width / 2 - 20, height: 25))
        yellowView.layer.cornerRadius = 2
        yellowView.layer.opacity = 0.6
        yellowView.backgroundColor = .tripYellow
        
        let sectionNameLabel = UILabel(frame: CGRect(x: 10, y: 0, width: view.frame.size.width, height: 25))
        sectionNameLabel.font = UIFont.boldSystemFont(ofSize: 22)
        sectionNameLabel.text = viewModel.titleForHeaderInSection(section: section)
        sectionNameLabel.textColor = .tripBlue
        returnedView.addSubview(yellowView)
        returnedView.addSubview(sectionNameLabel)
        return returnedView
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: C.CellIdentifiers.tripTableView.rawValue) as? TripTableViewCell
   
        cell?.viewModel = viewModel.tripCellViewModel(for: indexPath)
        return cell ?? UITableViewCell()
    }
}

// MARK: - TableViewDelegate
extension TripsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        160
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let notesViewModel = viewModel.viewModelForSelectedRow(at: indexPath)
        let newNoteViewModel = viewModel.newNoteViewModel(at: indexPath)
        self.newNoteViewModel = newNoteViewModel
     
        addTripButton.isHidden = true
        addNoteButton.isHidden = false
        let notesVC = configurator?.configureNotesVC(with: notesViewModel) ?? UIViewController()
        navigationController?.pushViewController(notesVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
         return true
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            viewModel.deleteRow(at: indexPath, errorCompletion: { [weak self] in
                self?.showAlert(title: I.deleteTripAlertTitle,
                                message: I.deleteTripAlertMessage)
            })
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = deleteAction(at: indexPath)
        return UISwipeActionsConfiguration(actions: [delete])
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let edit = editAction(at: indexPath)
        return UISwipeActionsConfiguration(actions: [edit])
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.backgroundColor = .clear
    }
}
