//
//  Chapter5ViewModel.swift
//  Practice_iOS_Concurrency
//
//  Created by Jinwoo Kim on 4/18/21.
//

import Foundation

class Chapter5ViewModel {
    let loadLastAction: Bool = true
    
    let actions: [ChapterAction] = [
        .init(title: "Test Action", action: { print("Hi") }),
        
        .init(title: "Thread Safe", action: {
            let threadSafeCountQueue = DispatchQueue(label: "...") // private
            var _count = 0 // private
            
            // public
            // 여러 Thread에서 _count에 접근해서 Race Condition이 일어나는 문제를 방지하기 위해, 별도의 Thread를 만들어준다.
            var count: Int {
                get {
                    // sync의 return 값은 <T>인데 Int로 됨
                    return threadSafeCountQueue.sync {
                        return _count
                    }
                }
                set {
                    threadSafeCountQueue.sync {
                        _count = newValue
                    }
                }
            }
        }),
        
        .init(title: "Priority", action: {
            // semaphore로 Priority를 정해준다.
            
            let high = DispatchQueue.global(qos: .userInteractive)
            let medium = DispatchQueue.global(qos: .userInitiated)
            let low = DispatchQueue.global(qos: .background)
            let semaphore = DispatchSemaphore(value: 1)
            
            high.async {
                Thread.sleep(forTimeInterval: 2)
                semaphore.wait()
                defer { semaphore.signal() }
                
                print("High priority task is now running")
            }
            
            for i in 1 ... 10 {
                medium.async {
                    let waitTime = Double(exactly: arc4random_uniform(7))!
                    print("Running medium task \(i)")
                    Thread.sleep(forTimeInterval: waitTime)
                }
            }
            
            low.async {
                semaphore.wait()
                defer { semaphore.signal() }
                
                print("Running long, lowest priority task")
                Thread.sleep(forTimeInterval: 5)
            }
        }),
        
        .init(title: "Priority (Obj-C)", action: {
            Chapter5Object.priority()
        })
    ]
    
    func getLastAction() -> (() -> ()) {
        guard let lastAction: ChapterAction = actions.last else {
            return {}
        }
        return lastAction.action
    }
}
