//
//  NotesViewController.swift
//  TripNotes
//
//  Created by Владислав Сизонов on 19.12.2021.
//

import UIKit

class NotesViewController: UIViewController {
    
    private var viewModel: NotesViewModelProtocol?
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.estimatedItemSize = CGSize(width: 100, height: 100)
        layout.itemSize = CGSize(width: 100, height: 100)
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 12
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .white
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        return collectionView
    }()
    
    init(notesViewModel: NotesViewModelProtocol) {
        super.init(nibName: nil, bundle: nil)
        self.viewModel = notesViewModel
        view.backgroundColor = .white
        
        setupCollectionViewConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = .tripYellow
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
}

extension NotesViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        150
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        cell.backgroundColor = .tripRed
        return cell
    }
}

extension NotesViewController: UICollectionViewDelegate {
    
}
