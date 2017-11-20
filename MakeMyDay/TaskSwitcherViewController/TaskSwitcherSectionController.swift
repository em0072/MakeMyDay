//
//  TaskSwitcherSectionController.swift
//  MakeMyDay
//
//  Created by Митько Евгений on 19.11.17.
//  Copyright © 2017 Evgeny Mitko. All rights reserved.
//

import UIKit
import IGListKit

class TaskSwitcherSectionController: ListSectionController {
    
    var taskList: TaskList!
    
    override func sizeForItem(at index: Int) -> CGSize {
        return CGSize(width: collectionContext!.containerSize.width, height: collectionContext!.containerSize.height)
    }
    
    
    override func cellForItem(at index: Int) -> UICollectionViewCell {
        let cell = collectionContext!.dequeueReusableCell(of: LabelCell.self, for: self, at: index) as! LabelCell
        cell.backgroundColor = .red
        cell.text = taskList.title
        return cell
    }
    
    override func didUpdate(to object: Any) {
        taskList = object as! TaskList
    }
}

