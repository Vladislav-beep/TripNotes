//
//  NotesViewController.swift
//  TripNotes
//
//  Created by Владислав Сизонов on 19.12.2021.
//

import UIKit

class NotesViewController: UIViewController {
    
    // MARK: Dependencies
    
    private var viewModel: NotesViewModelProtocol
    lazy var slideInTransitioningDelegate = SlideInPresentationManager()
    var coordinator: AppCoordinator?
    
    // MARK: UI
    
    private lazy var collectionView: NotesCollectionView = {
        let collectionView = NotesCollectionView()
        return collectionView
    }()
    
    private lazy var noLabel: NoLabel = {
        let noLabel = NoLabel(title: "No Notes yet")
        return noLabel
    }()
    
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        return activityIndicator
    }()
    
    // MARK: Life Time
    
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
        view.backgroundColor = .white
        collectionView.dataSource = self
        collectionView.delegate = self
        activityIndicator.stopAnimating()
        setupViewModelBundings()
        NotificationCenter.default.addObserver(self, selector: #selector(refresh), name: NSNotification.Name(rawValue: "updateNotes"), object: nil)
    }
    
    @objc func refresh() {
        viewModel.fetchNotes()
        collectionView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.fetchNotes()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: "updateNotes"), object: nil)
    }
    
    // MARK: Private methods

    private func setupViewModelBundings() {
        viewModel.noteCompletion = { [weak self] in
            self?.collectionView.reloadData()
            self?.setupUI()
            self?.activityIndicator.stopAnimating()
            self?.activityIndicator.isHidden = true
        }
    }
    
    private func setupUI() {
        if viewModel.numberOfCells() == 0 {
            noLabel.isHidden = false
        } else {
            noLabel.isHidden = true
        }
    }
    
    // MARK: Layout
    
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
    
extension NotesViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let noteVM = viewModel.viewModelForSelectedRow(at: indexPath)
        let noteVC = DetailNoteViewController(viewModel: noteVM)
        slideInTransitioningDelegate.direction = .bottom
        noteVC.transitioningDelegate = slideInTransitioningDelegate
        noteVC.modalPresentationStyle = .custom
        present(noteVC, animated: true)
    }
}

// MARK: CollectionViewDataSource

extension NotesViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.numberOfCells()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.CellIdentifiers.noteCollectionViewCellId.rawValue,
                                                      for: indexPath) as? NoteCell
        
        cell?.viewModel = viewModel.noteCellViewModel(for: indexPath)
        return cell ?? UICollectionViewCell()
    }
}


