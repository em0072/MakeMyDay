//
//  View.swift
//  MakeMyDay
//
//  Created by Митько Евгений on 19.11.17.
//  Copyright © 2017 Evgeny Mitko. All rights reserved.
//

import UIKit

class BaseView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        loadView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        loadView()
    }
    
    open func loadView() {
        fatalError("\(String(describing: self)) should override loadView method")
    }

}
