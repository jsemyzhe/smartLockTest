//
//  HomeModel.swift
//  smartLockTest
//
//  Created by Julia Semyzhenko on 29.12.2022.
//

import Foundation

protocol IHomeModel: AnyObject {
    var doors: [Door] { get }
    
    func loadDoors(completion: ((Bool) -> Void)?)
    func openTheDoor(index: Int, completion: ((Bool) -> Void)?)
}

final class HomeModel {
    var doors: [Door] = []
}

// MARK: - IHomeModel

extension HomeModel: IHomeModel {
    
    func loadDoors(completion: ((Bool) -> Void)?) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) { [weak self] in
            let success = Bool.random()
            self?.doors = success ? hardcodedDoors : []
            completion?(success)
        }
    }
    
    func openTheDoor(index: Int, completion: ((Bool) -> Void)?) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) { [weak self] in
            guard let self = self else { return }
            let success = Bool.random()
            if success {
                let currentState = self.doors[index].state
                self.doors[index].state = currentState == .locked ? .unlocked : .locked
            }
            completion?(success)
        }
    }
}

private var hardcodedDoors: [Door] = [
    Door(
        doorName: "Front door",
        mainImageName: "shield_blue_img",
        doorLocation: "Home",
        lockedImgName: "status_blue_closed_img",
        unlockedImgName: "status_blue_open_img",
        state: .locked
    ),
    Door(
        doorName: "Front door",
        mainImageName: "shield_yellow_img",
        doorLocation: "Office",
        lockedImgName: "status_yellow_closed_img",
        unlockedImgName: "status_yellow_open_img",
        state: .unlocked
    ),
    Door(
        doorName: "Front door",
        mainImageName: "dots_img",
        doorLocation: "Home",
        lockedImgName: "status_gray_closed_img",
        unlockedImgName: "status_gray_open_img",
        state: .unlocked
    ),
    Door(
        doorName: "Front door",
        mainImageName: "shield_blue_nomark_img",
        doorLocation: "Home",
        lockedImgName: "status_blue_closed_img",
        unlockedImgName: "status_blue_open_img",
        state: .locked
    )
]


