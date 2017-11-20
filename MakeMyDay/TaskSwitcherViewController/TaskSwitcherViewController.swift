//
//  TaskSwitcherViewController.swift
//  MakeMyDay
//
//  Created by Митько Евгений on 19.11.17.
//  Copyright © 2017 Evgeny Mitko. All rights reserved.
//

import UIKit
import IGListKit

class TaskSwitcherViewController: ViewController, UICollectionViewDelegateFlowLayout, ListAdapterDataSource {

    private var headerView: HeaderView!
    
    private var collectionView: UICollectionView!
    lazy private var adapter: ListAdapter = {
        return ListAdapter(updater: ListAdapterUpdater(), viewController: self)
    }()

    var taskLists = [TaskList.createNew(withTitle: "first"), TaskList.createNew(withTitle: "second")]

    override func viewDidLoad() {
        super.viewDidLoad()
        initCollectionView()
        initHeader()
    }

    private func initCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.isPagingEnabled = true
        view.addSubview(collectionView)
        adapter.collectionView = collectionView
        adapter.dataSource = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        view.safeAreaLayoutGuide.leadingAnchor.constraint(equalTo: collectionView.leadingAnchor).isActive = true
        view.safeAreaLayoutGuide.bottomAnchor.constraint(equalTo: collectionView.bottomAnchor).isActive = true
        view.safeAreaLayoutGuide.trailingAnchor.constraint(equalTo: collectionView.trailingAnchor).isActive = true
    }
    
    private func initHeader() {
        headerView = HeaderView()
        headerView.height(headerView.barHeight)
        view.addSubview(headerView)
        view.safeAreaLayoutGuide.leadingAnchor.constraint(equalTo: headerView.leadingAnchor).isActive = true
        view.safeAreaLayoutGuide.topAnchor.constraint(equalTo: headerView.topAnchor).isActive = true
        view.safeAreaLayoutGuide.trailingAnchor.constraint(equalTo: headerView.trailingAnchor).isActive = true
        collectionView.topToBottom(of: headerView)
    }

    // ------------------------------------------------------------------------ //
    //                      MARK: - List Adapter Data Source                    //
    // ------------------------------------------------------------------------ //
    
    func objects(for listAdapter: ListAdapter) -> [ListDiffable] {
        return taskLists
    }
    
    func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController {
        return TaskSwitcherSectionController()
    }
    
    func emptyView(for listAdapter: ListAdapter) -> UIView? {
        let view = UIView()
        view.height(50)
        view.width(50)
        view.backgroundColor = .blue
        return view
    }
}
