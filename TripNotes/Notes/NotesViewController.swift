//
//  NotesViewController.swift
//  TripNotes
//
//  Created by Владислав Сизонов on 19.12.2021.
//

import UIKit

class NotesViewController: UIViewController, UICollectionViewDelegate {
    
    // MARK: Dependencies
    
    private var viewModel: NotesViewModelProtocol
    var coordinator: AppCoordinator?
    
    // MARK: UI
    
    private lazy var collectionView: NotesCollectionView = {
        let collectionView = NotesCollectionView()
        return collectionView
    }()
    
    // MARK: Life Time
    
    init(notesViewModel: NotesViewModelProtocol) {
        self.viewModel = notesViewModel
        super.init(nibName: nil, bundle: nil)
        
        view.backgroundColor = .white
        setupCollectionViewConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        collectionView.dataSource = self
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


