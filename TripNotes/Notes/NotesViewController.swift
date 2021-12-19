//
//  NotesViewController.swift
//  TripNotes
//
//  Created by Владислав Сизонов on 19.12.2021.
//

import UIKit

class NotesViewController: UIViewController {
    
    private var viewModel: NotesViewModelProtocol?
    
    private lazy var label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
        
    }()
    
//    private lazy var addNoteButton: UIButton = {
//        let button = UIButton()
//        button.setTitle("Add Note", for: .normal)
//        button.translatesAutoresizingMaskIntoConstraints = false
//        button.backgroundColor = .tripRed
//        return button
//    }()
    
    init(notesViewModel: NotesViewModelProtocol) {
        super.init(nibName: nil, bundle: nil)
        self.viewModel = notesViewModel
        label.text = viewModel?.text
        view.backgroundColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
      //  setupAddNoteButtonConstraints()
    }
    
//    func setupAddNoteButtonConstraints() {
//        navigationController?.view.addSubview(addNoteButton)
//        NSLayoutConstraint.activate([
//            addNoteButton.centerXAnchor.constraint(equalTo: navigationController?.view.centerXAnchor ?? NSLayoutXAxisAnchor(), constant: 0),
//            addNoteButton.bottomAnchor.constraint(equalTo: navigationController?.view.bottomAnchor ?? NSLayoutYAxisAnchor(), constant: -UIScreen.main.bounds.height / 7.5),
//            addNoteButton.widthAnchor.constraint(equalToConstant: 100),
//            addNoteButton.heightAnchor.constraint(equalToConstant: 50)
//        ])
//    }
}
