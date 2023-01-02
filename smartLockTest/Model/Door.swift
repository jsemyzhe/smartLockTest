//
//  Doors.swift
//  smartLockTest
//
//  Created by Julia Semyzhenko on 01.01.2023.
//

import Foundation

struct Door {
    let doorName: String
    let mainImageName: String
    let doorLocation: String
    let lockedImgName: String
    let unlockedImgName: String
    
    var state: State
    
    enum State {
        case locked
        case unlocked
    }
}
