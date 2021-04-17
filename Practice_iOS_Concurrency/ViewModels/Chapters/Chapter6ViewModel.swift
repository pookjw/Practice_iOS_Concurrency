//
//  Chapter6ViewModel.swift
//  Practice_iOS_Concurrency
//
//  Created by Jinwoo Kim on 4/17/21.
//

import Foundation

class Chapter6ViewModel {
    let loadLastAction: Bool = true
    
    let actions: [ChapterAction] = [
        .init(title: "Test Action", action: { print("Hi") }),
        
        .init(title: "Operation", action: {
            let operation = Operation()
            print(operation.isReady)
            print(operation.isExecuting)
            print(operation.isCancelled)
            print(operation.isFinished)
        }),
        
        .init(title: "BlockOperation", action: {
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
        
        .init(title: "Multiple block operations (1)", action: {
            let sentence = "Ray's courses are the best!"
            let wordOperation = BlockOperation()
            
            for word in sentence.split(separator: " ") {
                wordOperation.addExecutionBlock {
                    print(word)
                }
            }
            
            // start() 이전에 불려야 한다.
            wordOperation.completionBlock = {
                print("Thank you for your patronage!")
            }
            
            wordOperation.start()
        }),
        
        .init(title: "Multiple block operations (2)", action: {
            let sentence = "Ray's courses are the best!"
            let workOperation = BlockOperation()
            
            for word in sentence.split(separator: " ") {
                workOperation.addExecutionBlock {
                    print(word)
                    sleep(2);
                }
            }
            
            // start() 이전에 불려야 한다.
            workOperation.completionBlock = {
                print("Thank you for your patronage!")
            }
            
            // 2.001136064529419로 찍히는걸 보아 concurrent하게 돌아가는걸 확인할 수 있다.
            print(duration {
                workOperation.start()
            })
        }),
        
        .init(title: "Subclassing Operation", action: {
            let op = Chapter2Operation()
            op.start()
        }),
        
        .init(title: "Operation (Obj-C)", action: {
            Chapter6Object.operation()
        }),
        
        .init(title: "BlockOperation (Obj-C)", action: {
            Chapter6Object.blockOperation()
        }),
        
        .init(title: "Multiple block operations (1) (Obj-C)", action: {
            Chapter6Object.multipleBlockOperations1()
        }),
        
        .init(title: "Multiple block operations (2) (Obj-C)", action: {
            Chapter6Object.multipleBlockOperations2()
        }),
        
        .init(title: "Subclassing Operation (Obj-C)", action: {
            Chapter6Object.subclassingOperation()
        })
    ]
    
    func getLastAction() -> (() -> ()) {
        guard let lastAction: ChapterAction = actions.last else {
            return {}
        }
        return lastAction.action
    }
}
