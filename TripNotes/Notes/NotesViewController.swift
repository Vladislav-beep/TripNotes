//
//  NotesViewController.swift
//  TripNotes
//
//  Created by Владислав Сизонов on 19.12.2021.
//

import UIKit

class NotesViewController: UIViewController {
    
    // MARK: - Dependencies
    
    private var viewModel: NotesViewModelProtocol
    var configurator: Configurator?
    
    // MARK: - UI
    
    private lazy var collectionView: NotesCollectionView = {
        let collectionView = NotesCollectionView()
        return collectionView
    }()
    
    private lazy var noLabel: NoLabel = {
        let noLabel = NoLabel(title: I.noNotesLabel)
        noLabel.isHidden = true
        return noLabel
    }()
    
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        return activityIndicator
    }()
    
    private lazy var countryButton: UIBarButtonItem = {
        let button = UIBarButtonItem.customButton(self,
                                                  action: #selector(setDefaultCountry),
                                                  imageName: C.ImageNames.countryButton.rawValue,
                                                  widthAndHeight: 40)
        return button
    }()
    
    private lazy var statisticsButton: UIBarButtonItem = {
        let button = UIBarButtonItem.customButton(self,
                                                  action: #selector(showStatistics),
                                                  imageName: C.ImageNames.statistics.rawValue,
                                                  widthAndHeight: 40)
        return button
    }()
    
    // MARK: - Life Time
    
    init(notesViewModel: NotesViewModelProtocol) {
        self.viewModel = notesViewModel
        super.init(nibName: nil, bundle: nil)
        setupCollectionViewConstraints()
        setupNoLabelConstraints()
        setupActivityIndicatorConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        setupUI()
        setupNavBar()
        setupViewModelBundings()
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(refresh),
                                               name: NSNotification.Name(rawValue: I.updateObserverName),
                                               object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.fetchNotes()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: I.updateObserverName), object: nil)
    }
    
    // MARK: - Actions
    
    @objc private func refresh() {
        viewModel.fetchNotes()
        collectionView.reloadData()
    }
    
    
    @objc private func setDefaultCountry() {
        showAlert()
    }
    
    @objc private func showStatistics() {
        let statisticsVC = configurator?.configureStatisticsVC() ?? UIViewController()
        present(statisticsVC, animated: true)
    }
    
    // MARK: - Private methods
    
    private func setupViewModelBundings() {
        viewModel.noteCompletion = { [weak self] in
            self?.collectionView.reloadData()
            self?.setupUI()
            self?.activityIndicator.stopAnimating()
            self?.activityIndicator.isHidden = true
        }
        
        viewModel.errorCompletion = { [weak self] error in
            self?.showAlert(title: I.errorAlertFetchingNotes, message: error.errorDescription)
        }
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        collectionView.dataSource = self
        collectionView.delegate = self
        activityIndicator.stopAnimating()
        title = viewModel.totalSum
        
        if viewModel.numberOfCells() == 0 {
            noLabel.isHidden = false
        } else {
            noLabel.isHidden = true
        }
    }
    
    private func setupNavBar() {
        navigationItem.rightBarButtonItems = [countryButton, statisticsButton]
        navigationController?.navigationBar.tintColor = .tripWhite
    }
    
    private func showAlert() {
        let alert = UIAlertController(title: "Default country or city", message: "Set or delete default country or city", preferredStyle: .alert)
        
        alert.addTextField { [weak self] textField in
            if self?.viewModel.getCountryOrCity().count == 0 {
            textField.placeholder = "Enter default country or city"
            } else {
                textField.text = self?.viewModel.getCountryOrCity()
            }
        }
        
        let setAction = UIAlertAction(title: "Set", style: .default) { [weak self] _ in
            guard let textField = alert.textFields?.first else { return }
            let savedText = textField.text ?? ""
            self?.viewModel.setCountryOrCity(savedText)
        }
        
        let deleteAction = UIAlertAction(title: "Delete", style: .destructive) { [weak self] _ in
            self?.viewModel.deleteCountryOrCity()
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        
        alert.addAction(setAction)
        alert.addAction(deleteAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true)
    }
    
    // MARK: - Layout
    
    private func setupCollectionViewConstraints() {
        view.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)
        ])
    }
    
    private func setupNoLabelConstraints() {
        view.addSubview(noLabel)
        NSLayoutConstraint.activate([
            noLabel.centerXAnchor.constraint(equalTo: collectionView.centerXAnchor, constant: 0),
            noLabel.centerYAnchor.constraint(equalTo: collectionView.centerYAnchor, constant: 0),
            noLabel.heightAnchor.constraint(equalToConstant: 60),
            noLabel.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width / 1.2)
        ])
    }
    
    private func setupActivityIndicatorConstraints() {
        view.addSubview(activityIndicator)
        NSLayoutConstraint.activate([
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 0),
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0)
        ])
    }
}

// MARK: - UICollectionViewDelegate
extension NotesViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let noteVM = viewModel.viewModelForSelectedRow(at: indexPath)
        let detailVC = configurator?.configureDetailVC(with: noteVM) ?? UIViewController()
        present(detailVC, animated: true)
    }
}

// MARK: - CollectionViewDataSource
extension NotesViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.numberOfCells()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: C.CellIdentifiers.noteCollectionView.rawValue,
                                                      for: indexPath) as? NoteCell
        
        cell?.viewModel = viewModel.noteCellViewModel(for: indexPath)
        return cell ?? UICollectionViewCell()
    }
}
