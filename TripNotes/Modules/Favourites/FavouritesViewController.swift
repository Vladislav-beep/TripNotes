//
//  FavouritesViewController.swift
//  TripNotes
//
//  Created by Владислав Сизонов on 13.12.2021.
//

import UIKit

class FavouritesViewController: UIViewController {
    
    // MARK: - Dependencies
    
    private var viewModel: FavouritesViewModelProtocol
    var configurator: Configurator?
    
    // MARK: - Private properties
    
    private var searchBarIsEmpty: Bool {
        guard let text = searchController.searchBar.text else { return false }
        return text.isEmpty
    }
    
    private var isFiltering: Bool {
        let searchBarScopeIsFiltering = searchController.searchBar.selectedScopeButtonIndex != 0
        return searchController.isActive && (!searchBarIsEmpty || searchBarScopeIsFiltering)
    }
    
    // MARK: - UI
    
    private lazy var collectionView: NotesCollectionView = {
        let collectionView = NotesCollectionView()
        return collectionView
    }()
    
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        return activityIndicator
    }()
    
    private lazy var noLabel: NoLabel = {
        let noLabel = NoLabel(title: I.noFavNotesLabel)
        noLabel.isHidden = false
        return noLabel
    }()
    
    private lazy var searchController: SearchController = {
        let searchController = SearchController()
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        return searchController
    }()
    
    // MARK: - Life Time
    
    init(viewModel: FavouritesViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        setupAllConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupDelegates()
        setupViewModelBindings()
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(refresh),
                                               name: NSNotification.Name(rawValue: I.updateObserverName),
                                               object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavigationBar()
        activityIndicator.startAnimating()
        viewModel.fetchNotes()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: I.updateObserverName), object: nil)
    }
    
    // MARK: - Actions
    
    @objc func refresh() {
        viewModel.fetchNotes()
        collectionView.reloadData()
    }
    
    // MARK: - Private methods
    
    private func setupUI() {
        if viewModel.numberOfCells(isFiltering: isFiltering) != 0 {
            noLabel.isHidden = true
        }
    }
    
    private func setupViewModelBindings() {
        viewModel.completion = { [weak self] in
            self?.setupUI()
            self?.activityIndicator.stopAnimating()
            self?.activityIndicator.isHidden = true
            self?.collectionView.reloadData()
        }
        
        viewModel.errorCompletion = { [weak self] error in
            self?.showAlert(title: I.errorAlertFetchingNotes, message: error.errorDescription)
        }
    }
    
    private func setupDelegates() {
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    private func setupNavigationBar() {
        title = I.tabBarFavItemTitle
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.tintColor = .tripWhite
        navigationItem.searchController = searchController
        
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.configureWithOpaqueBackground()
        navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.tripWhite]
        navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.tripWhite]
        navBarAppearance.backgroundColor = .tripRed
        navigationController?.navigationBar.standardAppearance = navBarAppearance
        navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
    }
    
    // MARK: - Layout
    
    private func setupAllConstraints() {
        setupCollectionViewConstraints()
        setupNoLabelConstraints()
        setupActivityIndicatorConstraints()
    }
    
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
            activityIndicator.centerXAnchor.constraint(equalTo: collectionView.centerXAnchor,
                                                       constant: 0),
            activityIndicator.centerYAnchor.constraint(equalTo: collectionView.centerYAnchor,
                                                       constant: 0)
        ])
    }
}

// MARK: - UICollectionViewDataSource
extension FavouritesViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.numberOfCells(isFiltering: isFiltering)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: C.CellIdentifiers.noteCollectionView.rawValue,
                                                      for: indexPath) as? NoteCell
        
        cell?.viewModel = viewModel.noteCellViewModel(for: indexPath, isFiltering: isFiltering)
        return cell ?? UICollectionViewCell()
    }
}

// MARK: - UICollectionViewDelegate
extension FavouritesViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let noteVM = viewModel.viewModelForSelectedRow(at: indexPath, isFiltering: isFiltering)
        let detailVC = configurator?.configureDetailVC(with: noteVM) ?? UIViewController()
        present(detailVC, animated: true)
    }
}

// MARK: - UISearchResultsUpdating
extension FavouritesViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        let scope = searchBar.scopeButtonTitles?[searchBar.selectedScopeButtonIndex] ?? I.allScope
        viewModel.filterContentForSearchText(searchController.searchBar.text ?? "",
                                             scope: scope,
                                             searchBarIsEmpty: searchBarIsEmpty)
        collectionView.reloadData()
    }
}

// MARK: - UISearchBarDelegate
extension FavouritesViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        viewModel.filterContentForSearchText(searchBar.text ?? "",
                                             scope: searchBar.scopeButtonTitles?[selectedScope] ?? I.allScope,
                                             searchBarIsEmpty: searchBarIsEmpty)
        collectionView.reloadData()
    }
}
