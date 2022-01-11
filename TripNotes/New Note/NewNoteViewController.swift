//
//  NewNoteViewController.swift
//  TripNotes
//
//  Created by Владислав Сизонов on 11.01.2022.
//

import UIKit

class NewNoteViewController: UIViewController {
    
    var viewModel: NewNoteViewModelProtocol?
    
    private lazy var addNoteTripButton: UIButton = {
        let addNoteTripButton = UIButton()
        addNoteTripButton.backgroundColor = .tripRed
        addNoteTripButton.layer.cornerRadius = 10
        addNoteTripButton.setTitle("+ Add Note", for: .normal)
        addNoteTripButton.titleLabel?.font = .systemFont(ofSize: 20, weight: .regular)
        addNoteTripButton.layer.shadowColor = UIColor.darkGray.cgColor
        addNoteTripButton.layer.shadowRadius = 4
        addNoteTripButton.layer.shadowOpacity = 0.4
        addNoteTripButton.layer.shadowOffset = CGSize(width: 0, height: 5)
        addNoteTripButton.translatesAutoresizingMaskIntoConstraints = false
        return addNoteTripButton
    }()
    
    init(viewModel: NewNoteViewModelProtocol) {
        super.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
    }
}


