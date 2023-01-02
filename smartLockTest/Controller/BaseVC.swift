//
//  BaseVC.swift
//  smartLockTest
//
//  Created by Julia Semyzhenko on 29.12.2022.
//

import UIKit

class BaseVC: UIViewController {

    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
