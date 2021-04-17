//
//  Chapter5Object.m
//  Practice_iOS_Concurrency
//
//  Created by Jinwoo Kim on 4/18/21.
//

#import "Chapter5Object.h"

@implementation Chapter5Object

+ (void)threadSafe {
    // Private
    dispatch_queue_t threadSafeCountQueue = dispatch_queue_create("...", DISPATCH_QUEUE_CONCURRENT_WITH_AUTORELEASE_POOL);
    
    // Private
    NSInteger _count = 0;
    
    // Public
    // 여러 Thread에서 _count에 접근해서 Race Condition이 일어나는 문제를 방지하기 위해, 별도의 Thread를 만들어준다.
    
    /*
     - Swift 코드를 참조하자
     */
}

+ (void)priority {
    // semaphore로 Priority를 정해준다.
    
    dispatch_queue_t high = dispatch_get_global_queue(QOS_CLASS_USER_INTERACTIVE, 0);
    dispatch_queue_t medium = dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0);
    dispatch_queue_t low = dispatch_get_global_queue(QOS_CLASS_BACKGROUND, 0);
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(1);
    
    dispatch_async(high, ^{
        [NSThread sleepForTimeInterval:2];
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        NSLog(@"High priority task is now running");
        dispatch_semaphore_signal(semaphore);
    });
    
    for (NSInteger i = 0; i <= 10; i++) {
        dispatch_async(medium, ^{
            double waitTime = arc4random_uniform(7);
            NSLog(@"Running medium task, %f", waitTime);
            [NSThread sleepForTimeInterval:waitTime];
        });
    }
    
    dispatch_async(low, ^{
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        NSLog(@"Running long, lowest priority task");
        [NSThread sleepForTimeInterval:5];
        dispatch_semaphore_signal(semaphore);
    });
}

@end
