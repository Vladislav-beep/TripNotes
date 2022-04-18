//
//  NotesCollectionView.swift
//  TripNotes
//
//  Created by Владислав Сизонов on 04.02.2022.
//

import UIKit

class NotesCollectionView: UICollectionView {
    
    // MARK: Life Time
    
    init() {
        super.init(frame: .zero, collectionViewLayout: UICollectionViewLayout())
        backgroundColor = .white
        register(NoteCell.self,
                 forCellWithReuseIdentifier: C.CellIdentifiers.noteCollectionView.rawValue)
        collectionViewLayout = createLayout()
        showsHorizontalScrollIndicator = false
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Private methods
    
    private func createLayout() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                              heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 6, leading: 6, bottom: 6, trailing: 6)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                               heightDimension: .fractionalWidth(0.55))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 2)
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 0, trailing: 5)
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }
}
