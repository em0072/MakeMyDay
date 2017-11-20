//
//  MainTaskViewController.swift
//  MakeMyDay
//
//  Created by Митько Евгений on 16.11.17.
//  Copyright © 2017 Evgeny Mitko. All rights reserved.
//

import UIKit
import IGListKit
import Firebase

class MainTaskViewController: ViewController, UICollectionViewDelegateFlowLayout, ListAdapterDataSource, DatabaseTaskListner {
 
    var collectionView: UICollectionView!
    lazy var adapter: ListAdapter = {
        return ListAdapter(updater: ListAdapterUpdater(), viewController: self)
    }()
    lazy var dbService: DatabaseService = {
       return DatabaseService.shared
    }()
    
    var tasks = [Task]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initHeader()
        initCollectionView()
        initAddButton()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        dbService.addListner(self)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
//        dbService.removeListner(listnerType: .taskListner(taskList: ))
    }
    
    
    private func initHeader() {
        
    }
    
    private func initCollectionView() {
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.backgroundColor = .clear
        view.addSubview(collectionView)

        adapter.collectionView = collectionView
        adapter.dataSource = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        view.safeAreaLayoutGuide.leadingAnchor.constraint(equalTo: collectionView.leadingAnchor).isActive = true
        view.safeAreaLayoutGuide.topAnchor.constraint(equalTo: collectionView.topAnchor).isActive = true
        view.safeAreaLayoutGuide.bottomAnchor.constraint(equalTo: collectionView.bottomAnchor).isActive = true
        view.safeAreaLayoutGuide.trailingAnchor.constraint(equalTo: collectionView.trailingAnchor).isActive = true
    }
    
    private func initAddButton() {
        let addButton = UIButton(type: .custom)
        addButton.titleLabel?.text = "Add"
        addButton.addTarget(self, action: #selector(self.buttonPressed), for: .touchUpInside)
        view.addSubview(withEdges: [.centerX, .bottom(-20), .height(50), .width(50)], view: addButton)
    }
    
    @objc func buttonPressed() {
        var textFieldRef: UITextField!
        let alert = UIAlertController(title: "add task", message: "enter task name", preferredStyle: .alert)
        alert.addTextField { (textField) in
            textFieldRef = textField
        }
        alert.addAction(UIAlertAction(title: "Add", style: .default, handler: { [weak self] (action) in
            guard let selfie = self else { return }
            let taskName = textFieldRef.text ?? ""
            Log.d(taskName)
            let task = Task.createNew(withTitle: taskName)
            selfie.dbService.add(task)
        }))
        present(alert, animated: true) {
            
        }
    }
    
    // ------------------------------------------------------------------------ //
    //                      MARK: - List Adapter Data Source                    //
    // ------------------------------------------------------------------------ //
    
    func objects(for listAdapter: ListAdapter) -> [ListDiffable] {
        return tasks
    }
    
    func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController {
        return SectionController()
    }
    
    func emptyView(for listAdapter: ListAdapter) -> UIView? {
        let view = UIView()
        view.height(50)
        view.width(50)
        view.backgroundColor = .blue
        return view
    }
    
    // ------------------------------------------------------------------------ //
    //                          MARK: - Database Listner                        //
    // ------------------------------------------------------------------------ //
    func tasksDidUpdate(_ tasks: [Task]) {
        self.tasks = tasks
        adapter.performUpdates(animated: true, completion: nil)
    }
    
}


