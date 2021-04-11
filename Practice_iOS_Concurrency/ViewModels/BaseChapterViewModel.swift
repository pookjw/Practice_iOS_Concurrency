//
//  BaseChapterViewModel.swift
//  Practice_iOS_Concurrency
//
//  Created by Jinwoo Kim on 4/11/21.
//

import Foundation

class BaseChapterViewModel {
    let loadLastAction: Bool = true
    
    let actions: [ChapterAction] = [
        .init(title: "Test Action", action: { print("Hi") })
    ]
    
    func getLastAction() -> (() -> ()) {
        guard let lastAction: ChapterAction = actions.last else {
            return {}
        }
        return lastAction.action
    }
}
