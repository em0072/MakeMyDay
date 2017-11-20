//
//  HeaderView.swift
//  MakeMyDay
//
//  Created by Митько Евгений on 19.11.17.
//  Copyright © 2017 Evgeny Mitko. All rights reserved.
//

import UIKit

class HeaderView: BaseView {
    
    lazy var barHeight: CGFloat = {
        return self.navigationBarHeight + self.titleBarHeight
    }()
    let navigationBarHeight: CGFloat = 44
    let titleBarHeight: CGFloat = 57
    
    var topBar: UIView!
    var bottomBar: UIView!
    
    override func loadView() {
        initTopBar()
        initBottomBar()
    }
    
    private func initTopBar() {
        topBar = UIView()
        topBar.backgroundColor = .mainBG
        addSubview(withEdges: [.leading, .trailing, .top, .height(navigationBarHeight)], view: topBar)
    }
    
    private func initBottomBar() {
        bottomBar = UIView()
        bottomBar.backgroundColor = .mainBG
        addSubview(withEdges: [.leading, .trailing, .bottom, .height(titleBarHeight)], view: bottomBar)
        topBar.bottomToTop(of: bottomBar)
    }

}
