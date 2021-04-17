//
//  Chapter9ViewModel.swift
//  Practice_iOS_Concurrency
//
//  Created by Jinwoo Kim on 4/18/21.
//

import Foundation

class Chapter9ViewModel {
    let loadLastAction: Bool = true
    
    let actions: [ChapterAction] = [
        .init(title: "Test Action", action: { print("Hi") }),
        
        .init(title: "dependencies (sync (1))", action: {
            // dependency로 등록된 작업이 끝나야 실행된다.
            let queue = OperationQueue()
            
            let op1 = BlockOperation {
                Thread.sleep(forTimeInterval: 1)
                print("Hi! 1")
            }
            let op2 = BlockOperation {
                Thread.sleep(forTimeInterval: 2)
                print("Hi! 2")
            }
            let op3 = BlockOperation {
                Thread.sleep(forTimeInterval: 3)
                print("Hi! 3")
            }
            
            op2.addDependency(op1)
            op3.addDependency(op2)
            
            queue.addOperation(op1)
            queue.addOperation(op2)
            queue.addOperation(op3)
            
            op3.removeDependency(op2)
        }),
        
        .init(title: "sync (2)", action: {
            // 호기심... 책에는 없음
            let queue = OperationQueue()
            queue.maxConcurrentOperationCount = 1
            
            let op1 = BlockOperation {
                Thread.sleep(forTimeInterval: 1)
                print("Hi! 1")
            }
            let op2 = BlockOperation {
                Thread.sleep(forTimeInterval: 2)
                print("Hi! 2")
            }
            let op3 = BlockOperation {
                Thread.sleep(forTimeInterval: 3)
                print("Hi! 3")
            }
            
            queue.addOperation(op1)
            queue.addOperation(op2)
            queue.addOperation(op3)
        }),
        
        .init(title: "sync (3)", action: {
            // 호기심... 책에는 없음
            let queue = OperationQueue()
            
            queue.addBarrierBlock {
                Thread.sleep(forTimeInterval: 1)
                print("Hi! 1")
            }
            
            queue.addBarrierBlock {
                Thread.sleep(forTimeInterval: 2)
                print("Hi! 2")
            }
            
            queue.addBarrierBlock {
                Thread.sleep(forTimeInterval: 3)
                print("Hi! 3")
            }
        }),
        
        .init(title: "dependencies (sync (1)) (Obj-C)", action: {
            Chapter9Object.dependenciesSync1()
        }),
        
        .init(title: "sync (2) (Obj-C)", action: {
            Chapter9Object.sync2()
        }),
        
        .init(title: "sync (3) (Obj-C)", action: {
            Chapter9Object.sync3()
        })
    ]
    
    func getLastAction() -> (() -> ()) {
        guard let lastAction: ChapterAction = actions.last else {
            return {}
        }
        return lastAction.action
    }
}
