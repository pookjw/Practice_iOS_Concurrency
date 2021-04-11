//
//  ChapterAction.swift
//  Practice_iOS_Concurrency
//
//  Created by Jinwoo Kim on 4/11/21.
//

import Foundation

final class ChapterAction {
    let title: String
    let action: () -> ()
    
    init(title: String, action: @escaping () -> ()) {
        self.title = title
        self.action = {
            print("===== \(title) =====")
            action()
            print("===== Called Action =====")
        }
    }
    
    init(title: String, waitAction: @escaping (DispatchSemaphore) -> ()) {
        self.title = title
        self.action = {
            let semaphore = DispatchSemaphore(value: 0)
            print("===== \(title) =====")
            waitAction(semaphore)
            print("===== Called Action =====")
        }
    }
}
