//
//  Chapter10ViewModel.swift
//  Practice_iOS_Concurrency
//
//  Created by Jinwoo Kim on 4/18/21.
//

import Foundation
import UIKit

class Chapter10ViewModel {
    let loadLastAction: Bool = true
    
    let actions: [ChapterAction] = [
        .init(title: "Test Action", action: { print("Hi") }),
        
        .init(title: "cancel", action: {
            let queue = OperationQueue()
            
            let op1 = BlockOperation {
                Thread.sleep(forTimeInterval: 5)
                print("Hi! 1")
            }
            
            let op2 = BlockOperation {
                Thread.sleep(forTimeInterval: 5)
                print("Hi! 2")
            }
            
            op1.completionBlock = {
                print("Completed 1!") // cancel 하자마자 나옴
            }
            
            queue.addOperation(op1)
            queue.addOperation(op2)
            
            op1.cancel() // Hi! 1는 안 나옴!
            
            print(op1.isCancelled) // true
            print(op1.isFinished) // true
        }),
        
        .init(title: "cancelAllOperations", action: {
            let queue = OperationQueue()
            
            let op1 = BlockOperation {
                Thread.sleep(forTimeInterval: 5)
                print("Hi! 1")
            }
            
            let op2 = BlockOperation {
                Thread.sleep(forTimeInterval: 5)
                print("Hi! 2")
            }
            
            queue.addOperation(op1)
            queue.addOperation(op2)
            
            op1.completionBlock = {
                print("Completed 1!") // cancel 하자마자 나옴
            }
            op2.completionBlock = {
                print("Completed 2!") // cancel 하자마자 나옴
            }
            
            queue.cancelAllOperations() // 다 안 나옴!
            
            print(op1.isCancelled) // true
            print(op1.isFinished) // true
        }),
        
        .init(title: "cancel (Obj-C)", action: {
            Chapter10Object.cancel()
        }),
        
        .init(title: "cancelAllOperations", action: {
            Chapter10Object.cancelAllOperations()
        })
    ]
    
    func getLastAction() -> (() -> ()) {
        guard let lastAction: ChapterAction = actions.last else {
            return {}
        }
        return lastAction.action
    }
}
