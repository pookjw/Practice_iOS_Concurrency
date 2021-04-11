//
//  Chapter3Object.m
//  Practice_iOS_Concurrency
//
//  Created by Jinwoo Kim on 4/12/21.
//

#import "Chapter3Object.h"

@implementation Chapter3Object

+ (void)concurrent {
    const char *label = "com.raywenderlich.mycoolapp.networking";
    dispatch_queue_t correntQueue = dispatch_queue_create(label, DISPATCH_QUEUE_CONCURRENT);
    
    dispatch_queue_t inactiveQueue = dispatch_queue_create(label, DISPATCH_QUEUE_CONCURRENT_INACTIVE);
    dispatch_async(inactiveQueue, ^{
        NSLog(@"Hi!!!");
    });
    dispatch_activate(inactiveQueue);
}

+ (void)qos {
    dispatch_queue_t queue = dispatch_get_global_queue(QOS_CLASS_USER_INTERACTIVE, 0);
    
    /*
     
     QOS_CLASS_USER_INTERACTIVE : UI 업데이트 계산, 애니메이션 계산 등 앱을 멈추게 하지 않는 것이 목적인 QOS
     QOS_CLASS_USER_INITIATED : 문서를 열거나 로컬 DB를 접근할 때 같이 빠른 작업에 최적화된 QOS
     QOS_CLASS_UTILITY : 장시간 작업에 최적화된 QOS. 계산이 오래 걸리는 작업이나 네트워킹 용도이다. 시스템은 성능과 에너지 효율을 조절한다.
     QOS_CLASS_BACKGROUND : DB 보수, 서버 remote 동기화 등 시간이 크게 중요하지 않는 작업에 적합한 QOS이다. 시스템은 속도보다 에너지 효율에 집중을 한다.
     QOS_CLASS_DEFAULT : QOS_CLASS_USER_INTERACTIVE나 QOS_CLASS_USER_INITIATED가 기본이다.
     QOS_CLASS_UNSPECIFIED : 쓰지 말자
     
     */
}

+ (void)addingTaskToQueue {
    dispatch_queue_t queue = dispatch_get_global_queue(QOS_CLASS_UTILITY, 0);
    
    dispatch_async(queue, ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"Hi!");
        });
    });
    
    dispatch_async(queue, ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"Hi! 2");
        });
    });
}

+ (void)dispatchWorkItem {
    dispatch_queue_t queue = dispatch_queue_create("xyz", DISPATCH_QUEUE_CONCURRENT);
    
//    dispatch_async(queue, ^{
//        NSLog(@"The block of code ran!");
//    });
    
    // ... 대신에
    
    // https://developer.apple.com/documentation/dispatch/1431050-dispatch_block_create
    dispatch_block_t block = dispatch_block_create(0, ^{
        NSLog(@"The block of code ran!");
    });
    
    dispatch_async(queue, block);
}

+ (void)dependencies {
    dispatch_queue_t queue = dispatch_queue_create("xyz", DISPATCH_QUEUE_CONCURRENT);
    dispatch_block_t backgroundBlock = dispatch_block_create(0, ^{
        NSLog(@"Background!");
    });
    dispatch_block_t updateUIBlock = dispatch_block_create(0, ^{
        NSLog(@"Main!");
    });
    
    dispatch_notify(backgroundBlock, queue, updateUIBlock);
    dispatch_async(queue, backgroundBlock);
}

@end
