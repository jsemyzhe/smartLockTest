//
//  HomeVC.swift
//  smartLockTest
//
//  Created by Julia Semyzhenko on 29.12.2022.
//

import UIKit
import SnapKit

protocol IHomeVC: AnyObject {
    func didPullToRefresh()
    func didTapOpenDoor(index: Int)
}

final class HomeVC: BaseVC {
    
    // MARK: - Typealiases
    
    typealias IView = IHomeView
    typealias View = HomeView
    typealias Model = IHomeModel
    
    // MARK: - Properties
    private let rootView: IView
    private let model: IHomeModel
    
    // MARK: - Lifecycle
    
    init(
        rootView: IView = View(),
        model: IHomeModel = HomeModel()
    ) {
        self.rootView = rootView
        self.model = model
        
        super.init()
        
        rootView.set(controller: self)
    }
    
    override func loadView() {
        view = rootView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getDoors()
    }
    
    private func getDoors() {
        model.loadDoors { [weak self] isSuccess in
            guard let self = self else { return }
            if isSuccess {
                let config = View.Config(doors: self.model.doors)
                self.rootView.configureView(with: config)
            } else {
                self.showAlert()
            }
        }
    }
    
    private func showAlert() {
        let alertVC = UIAlertController(title: "Server error", message: "Please try again", preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "Ok", style: .default))
        self.present(alertVC, animated: true)
    }
}

// MARK: - IHomeVC extension

extension HomeVC: IHomeVC {
    
    func didPullToRefresh() {
        getDoors()
    }
    
    func didTapOpenDoor(index: Int) {
        model.openTheDoor(index: index, completion: { [weak self] isSuccess in
            guard let self = self else { return }
            let config = View.Config(doors: self.model.doors)
            self.rootView.configureView(with: config)
            if !isSuccess {
                self.showAlert()
            }
        })
    }
}


