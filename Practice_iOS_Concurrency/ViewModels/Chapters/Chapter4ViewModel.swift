//
//  Chapter4ViewModel.swift
//  Practice_iOS_Concurrency
//
//  Created by Jinwoo Kim on 4/16/21.
//

import Foundation

class Chapter4ViewModel {
    let loadLastAction: Bool = true
    
    let actions: [ChapterAction] = [
        .init(title: "Test Action", action: { print("Hi") }),
        
        .init(title: "DispatchGroup (1)", action: {
            let group = DispatchGroup()
            
            let queue1 = DispatchQueue(label: "com.pookjw.test1")
            let queue2 = DispatchQueue(label: "com.pookjw.test2")
            
            queue1.async(group: group) {
                print("Hi! 1")
            }
            
            queue1.async(group: group) {
                Thread.sleep(forTimeInterval: 10)
                print("Hi! 2")
            }
            
            queue2.async(group: group) {
                Thread.sleep(forTimeInterval: 10)
                print("Hi! 3")
            }
            
            group.notify(queue: DispatchQueue.main) {
                print("Main Thread!")
            }
        }),
        
        .init(title: "DispatchGroup (2)", action: {
            let group = DispatchGroup()
            let queue = DispatchQueue.global(qos: .userInitiated)
            
            queue.async(group: group) {
                print("Start a job (1)")
                Thread.sleep(forTimeInterval: 3)
                print("Finished (1)")
            }
            
            queue.async(group: group) {
                print("Started a job (2)")
                Thread.sleep(until: Date().addingTimeInterval(2))
                print("Finished (2)")
            }
            
            if group.wait(timeout: .now() + 5) == .timedOut {
                print("I got tired of waiting")
            } else {
                print("All the jobs have completed")
            }
        }),
        
        .init(title: "DispatchGroup (3)", action: {
            /*
             DispatchGroup은 Object Reference Count 처럼 Count를 기준으로 completed를 받아온다.
             queue가 실행되거나 enter()가 불리면 Count가 증가하며, leave()를 통해 Count를 줄인다.
             */
            let group = DispatchGroup()
            let queue = DispatchQueue.global(qos: .userInitiated)
            
            queue.async(group: group) {
                print("Start a job (1)")
                Thread.sleep(forTimeInterval: 3)
                print("Finished (1)")
            }
            
            queue.async(group: group) {
                print("Started a job (2)")
                Thread.sleep(until: Date().addingTimeInterval(2))
                print("Finished (2)")
                
                // Count += 1
                group.enter()
            }
            
            if group.wait(timeout: .now() + 5) == .timedOut {
                print("I got tired of waiting")
            } else {
                print("All the jobs have completed")
            }
        }),
        
        .init(title: "DispatchGroup (4)", action: {
            func myAsyncAdd(lhs: Int, rhs: Int, completion: @escaping (Int) -> Void) {
                completion(lhs + rhs)
            }
            
            func myAsyncAddForGroup(group: DispatchGroup,
                                    lhs: Int,
                                    rhs: Int,
                                    completion: @escaping (Int) -> Void) {
                group.enter()
                
                myAsyncAdd(lhs: lhs, rhs: rhs, completion: { result in
                    defer {
                        group.leave()
                    }
                    completion(result)
                })
            }
        }),
        
        .init(title: "Semaphore", action: {
            /*
             wait()는 value를 증가시키고
             signal()는 value를 감소시킨다.
             value가 0이 되면 wait()는 통과된다.
             */
            let semaphore1 = DispatchSemaphore(value: 0)
            let queue = DispatchQueue.global()
            let group = DispatchGroup()
            
            queue.async {
                semaphore1.wait()
            }
            queue.async {
                semaphore1.wait()
            }
            
            queue.async(group: group) {
                Thread.sleep(forTimeInterval: 3)
                semaphore1.signal()
            }
            
            queue.async(group: group) {
                Thread.sleep(forTimeInterval: 3)
                semaphore1.signal()
            }
            
            queue.async(group: group) {
                Thread.sleep(forTimeInterval: 3)
                semaphore1.signal()
            }
            
            semaphore1.wait()
            print("Hi!!!")
        }),
        
        .init(title: "DispatchGroup (1) (Obj-C)", action: {
            Chapter4Object.dispatchGroup1()
        }),
        
        .init(title: "DispatchGroup (2) (Obj-C)", action: {
            Chapter4Object.dispatchGroup2()
        }),
        
        .init(title: "DispatchGroup (3) (Obj-C)", action: {
            Chapter4Object.dispatchGroup3()
        }),
        
        .init(title: "DispatchGroup (4) (Obj-C)", action: {
            Chapter4Object.dispatchGroup4()
        }),
        
        .init(title: "Semaphore (Obj-C)", action: {
            Chapter4Object.semaphore()
        })
    ]
    
    func getLastAction() -> (() -> ()) {
        guard let lastAction: ChapterAction = actions.last else {
            return {}
        }
        return lastAction.action
    }
}
