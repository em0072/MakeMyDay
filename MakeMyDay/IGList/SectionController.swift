//
//  SectionController.swift
//  MakeMyDay
//
//  Created by Митько Евгений on 16.11.17.
//  Copyright © 2017 Evgeny Mitko. All rights reserved.
//

import UIKit
import IGListKit

class SectionController: ListSectionController {
    
    var task: Task!
        
    override func sizeForItem(at index: Int) -> CGSize {
        return CGSize(width: collectionContext!.containerSize.width, height: 55)
    }
    
    
    override func cellForItem(at index: Int) -> UICollectionViewCell {
        let cell = collectionContext!.dequeueReusableCell(of: LabelCell.self, for: self, at: index) as! LabelCell
        cell.backgroundColor = .red
        cell.text = task.title
        return cell
    }

    override func didUpdate(to object: Any) {
        task = object as! Task
    }
}
