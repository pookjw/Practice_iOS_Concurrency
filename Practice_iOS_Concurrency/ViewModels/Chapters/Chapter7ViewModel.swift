//
//  Chapter7ViewModel.swift
//  Practice_iOS_Concurrency
//
//  Created by Jinwoo Kim on 4/18/21.
//

import Foundation

class Chapter7ViewModel {
    let loadLastAction: Bool = true
    
    let actions: [ChapterAction] = [
        .init(title: "Test Action", action: { print("Hi") }),
        
        .init(title: "OperationQueue management", action: {
            let queue1 = OperationQueue()
            let queue2 = OperationQueue()
            let op = Operation()
            queue1.addOperation(op)
            
            // 에러! Operation은 중복으로 추가할 수 없고, 다른 OperaionQueue에도 추가할 수 없다.
//            queue1.addOperation(op)
//            queue2.addOperation(op)
            
            // 반대로 DispatchQueue는 상관없음 - 재활용 가능 여부가 차이점
            
            let workItem = DispatchWorkItem(block: {})
            let dqueue1 = DispatchQueue(label: "...1")
            let dqueue2 = DispatchQueue(label: "...2")
            dqueue1.async(execute: workItem)
            dqueue1.async(execute: workItem)
            dqueue2.async(execute: workItem)
        }),
        
        .init(title: "Waiting for completion", action: {
            let queue = OperationQueue()
            let op = BlockOperation(block: {
                print("Hi! 1")
            })
            op.addExecutionBlock {
                print("Hi! 2")
            }
            op.completionBlock = {
                print("Completed!")
            }
            queue.addOperation(op) // 자동으로 start 됨
            op.waitUntilFinished()
            print("Waiting was done!")
        }),
        
        .init(title: "QOS", action: {
            let queue = OperationQueue()
            // DispatchQueue의 QOS랑 같음
            queue.qualityOfService = .userInitiated
        }),
        
        .init(title: "Pause", action: {
            let queue = OperationQueue()
            let op = BlockOperation(block: {
                Thread.sleep(forTimeInterval: 3)
                // 안 불림
                print("Huh?")
            })
            op.completionBlock = {
                // 불림
                print("Completed!")
            }
            queue.addOperation(op)
            
            op.cancel()
        }),
        
        .init(title: "Maximun number of operations", action: {
            let queue = OperationQueue()
            
            // 기본
            queue.maxConcurrentOperationCount = OperationQueue.defaultMaxConcurrentOperationCount
            
            // 최대 1개로 설정
            queue.maxConcurrentOperationCount = 1
            
            queue.addOperation {
                Thread.sleep(forTimeInterval: 3)
                print("Hi! 1")
            }
            queue.addOperation {
                Thread.sleep(forTimeInterval: 5)
                print("Hi! 2")
            }
            
            /*
             3초 후에 1이 불리고, 5초 후에 2가 불린다. 후순위로 밀리는 셈. 최대 개수를 초과해도 다 돌아간다.
             */
        }),
        
        .init(title: "Underlying DispatchQueue", action: {
            /*
             OperationQueue에 사용될 Queue를 DispatchQueue로 지정
             main 쓰레드는 쓰지 않는걸 권장 (해도 문제는 없는데, OperationQueue.main을 쓰면 되잖아)
             */
            
            let queue = OperationQueue()
            print(queue.underlyingQueue) // nil
            queue.underlyingQueue = DispatchQueue(label: "com.pookjw.test")
//            queue.underlyingQueue = DispatchQueue.main
            queue.addOperation {
                // com.pookjw.test
                print(OperationQueue.current?.underlyingQueue?.label)
            }
        }),
        
        //
        
        .init(title: "OperationQueue management (Obj-C)", action: {
            Chapter7Object.operationQueueManagement()
        }),
        
        .init(title: "Waiting for completion (Obj-C)", action: {
            Chapter7Object.waitingForCompletion()
        }),
        
        .init(title: "QOS (Obj-C)", action: {
            Chapter7Object.qos()
        }),
        
        .init(title: "Pause (Obj-C)", action: {
            Chapter7Object.pause()
        }),
        
        .init(title: "Maximun number of operations (Obj-C)", action: {
            Chapter7Object.maximum()
        }),
        
        .init(title: "Underlying DispatchQueue (Obj-C)", action: {
            Chapter7Object.underlyingQueue()
        })
    ]
    
    func getLastAction() -> (() -> ()) {
        guard let lastAction: ChapterAction = actions.last else {
            return {}
        }
        return lastAction.action
    }
}
