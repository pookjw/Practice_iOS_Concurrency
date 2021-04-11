//
//  Chapter2ViewModel.swift
//  Practice_iOS_Concurrency
//
//  Created by Jinwoo Kim on 4/11/21.
//

import Foundation

class Chapter2ViewModel {
    let loadLastAction: Bool = true
    
    let actions: [ChapterAction] = [
        .init(title: "Test Action", action: { print("Hi") }),
        
        .init(title: "GCD", action: {
            let queue = DispatchQueue(label: "com.raywenderlich.worker")
            
            queue.async {
                // Call slow non-UI methods here
                
                DispatchQueue.main.async {
                    // Update the UI here
                }
            }
        }),
        
        .init(title: "Operation", action: {
            let operation: Operation = .init()
            
            func printStatus(for operation: Operation) {
                print("isReady: \(operation.isReady)")
                print("isExecuting: \(operation.isExecuting)")
                print("isCancelled: \(operation.isCancelled)")
                print("isFinished: \(operation.isFinished)")
            }
            
            printStatus(for: operation)
            operation.start()
            printStatus(for: operation)
        }),
        
        .init(title: "BlockOperation", action: {
            // subclass of Operation
            let blockOperation = BlockOperation {
                print("Hi!")
                print(Thread.current)
                OperationQueue.main.addOperation {
                    print("Hi! 2")
                    print(Thread.current)
                    print(OperationQueue.current)
                }
            }
            blockOperation.start()
        }),
        
        .init(title: "GCD (Obj-C)", action: {
            Chapter2Object.gcd()
        }),
        
        .init(title: "Operation (Obj-C)", action: {
            Chapter2Object.operation()
        }),
        
        .init(title: "BlockOperation (Obj-C)", action: {
            Chapter2Object.blockOperation()
        })
    ]
    
    func getLastAction() -> (() -> ()) {
        guard let lastAction: ChapterAction = actions.last else {
            return {}
        }
        return lastAction.action
    }
}
