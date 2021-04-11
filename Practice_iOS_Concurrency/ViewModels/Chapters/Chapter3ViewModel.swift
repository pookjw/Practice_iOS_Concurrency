//
//  Chapter3ViewModel.swift
//  Practice_iOS_Concurrency
//
//  Created by Jinwoo Kim on 4/11/21.
//

import Foundation

class Chapter3ViewModel {
    let loadLastAction: Bool = true
    
    let actions: [ChapterAction] = [
        .init(title: "Test Action", action: { print("Hi") }),
        
        .init(title: "concurrent", action: {
            let label = "com.raywenderlich.mycoolapp.networking"
            
            // 기본은 .concurrent
            let queue = DispatchQueue(label: label)
            
            let correntQueue = DispatchQueue(label: label, attributes: .concurrent)
            
            let inactiveQueue = DispatchQueue(label: label, attributes: .initiallyInactive)
            inactiveQueue.async {
                print("Hi!!!")
            }
            inactiveQueue.activate()
            
        }),
        
        .init(title: "qos", action: {
            let queue = DispatchQueue.global(qos: .userInteractive)
            
            /*
             
             .userInteractive : UI 업데이트 계산, 애니메이션 계산 등 앱을 멈추게 하지 않는 것이 목적인 QOS
             .userInitiated : 문서를 열거나 로컬 DB를 접근할 때 같이 빠른 작업에 최적화된 QOS
             .utility : 장시간 작업에 최적화된 QOS. 계산이 오래 걸리는 작업이나 네트워킹 용도이다. 시스템은 성능과 에너지 효율을 조절한다.
             .background : DB 보수, 서버 remote 동기화 등 시간이 크게 중요하지 않는 작업에 적합한 QOS이다. 시스템은 속도보다 에너지 효율에 집중을 한다.
             .default : .userInitiated나 .userInitiated가 기본이다.
             .unspecified : 쓰지 말자.
             
             */
        }),
        
        .init(title: "Adding task to queue", action: {
            let queue = DispatchQueue.global(qos: .utility)
            
            queue.async {
                DispatchQueue.main.async {
                    print("Hi!")
                }
            }
            
            queue.async {
                print("Hi! 2")
            }
        }),
        
        .init(title: "DispatchWorkItem", action: {
            let queue = DispatchQueue(label: "xyz")
            
//            queue.async {
//                print("The block of code ran!")
//            }
            
            // ... 대신에
            
            // https://developer.apple.com/documentation/dispatch/dispatchworkitem/2300102-init
            let workITem = DispatchWorkItem(qos: .unspecified, flags: []) {
                print("The block of code ran!")
            }
            queue.async(execute: workITem)
            print(workITem.isCancelled)
            workITem.cancel()
            print(workITem.isCancelled)
        }),
        
        .init(title: "dependencies", action: {
            let queue = DispatchQueue(label: "xyz")
            let backgroundWorkItem = DispatchWorkItem {
                print("Background!")
            }
            let updateUIWorkItem = DispatchWorkItem {
                print("Main!")
            }
            
            backgroundWorkItem.notify(queue: DispatchQueue.main,
                                      execute: updateUIWorkItem)
            queue.async(execute: backgroundWorkItem)
        }),
        
        .init(title: "concurrent (Obj-C)", action: {
            Chapter3Object.concurrent()
        }),
        
        .init(title: "qos", action: {
            Chapter3Object.qos()
        }),
        
        .init(title: "Adding task to queue (Obj-C)", action: {
            Chapter3Object.addingTaskToQueue()
        }),
        
        .init(title: "dispatchWorkItem (Obj-C)", action: {
            Chapter3Object.dispatchWorkItem()
        }),
        
        .init(title: "dependencies", action: {
            Chapter3Object.dependencies()
        })
    ]
    
    func getLastAction() -> (() -> ()) {
        guard let lastAction: ChapterAction = actions.last else {
            return {}
        }
        return lastAction.action
    }
}
