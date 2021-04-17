//
//  Chapter4Object.m
//  Practice_iOS_Concurrency
//
//  Created by Jinwoo Kim on 4/17/21.
//

#import "Chapter4Object.h"

@implementation Chapter4Object

+ (void)dispatchGroup1 {
    dispatch_group_t group = dispatch_group_create();
    
    dispatch_queue_t queue1 = dispatch_queue_create("com.pookjw.test1", DISPATCH_QUEUE_CONCURRENT_WITH_AUTORELEASE_POOL);
    dispatch_queue_t queue2 = dispatch_queue_create("com.pookjw.test1", DISPATCH_QUEUE_CONCURRENT_WITH_AUTORELEASE_POOL);
    
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        NSLog(@"Main Thread!");
    });
    
    dispatch_group_async(group, queue1, ^{
        NSLog(@"Hi! 1");
    });
    
    dispatch_group_async(group, queue1, ^{
        [NSThread sleepForTimeInterval:10];
        NSLog(@"Hi! 2");
    });
    
    dispatch_group_async(group, queue2, ^{
        [NSThread sleepForTimeInterval:10];
        NSLog(@"Hi! 3");
    });
}

+ (void)dispatchGroup2 {
    dispatch_group_t group = dispatch_group_create();
    dispatch_queue_t queue = dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0);
    
    dispatch_group_async(group, queue, ^{
        NSLog(@"Start a job (1)");
        [NSThread sleepForTimeInterval:3];
        NSLog(@"Finished (1)");
    });
    
    dispatch_group_async(group, queue, ^{
        NSLog(@"Started a job (2)");
        [NSThread sleepUntilDate:[[NSDate new] dateByAddingTimeInterval:2]];
        NSLog(@"Finished (2)");
    });
    
    dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, NSEC_PER_SEC * 5);
    
    if (dispatch_group_wait(group, time) != 0) {
        NSLog(@"I got tired of waiting");
    } else {
        NSLog(@"All the jobs have completed");
    }
}

+ (void)dispatchGroup3 {
    /*
     dispatch_group_t는 Object Reference Count 처럼 Count를 기준으로 completed를 받아온다.
     queue가 실행되거나 enter가 불리면 count가 증가하며, leave를 통해 Count를 줄인다.
     */
    dispatch_group_t group = dispatch_group_create();
    dispatch_queue_t queue = dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0);
    
    dispatch_group_async(group, queue, ^{
        NSLog(@"Start a job (1)");
        [NSThread sleepForTimeInterval:3];
        NSLog(@"Finished (1)");
    });
    
    dispatch_group_async(group, queue, ^{
        NSLog(@"Start a job (2)");
        [NSThread sleepUntilDate:[[NSDate new] dateByAddingTimeInterval:2]];
        NSLog(@"Finished (2)");
        
        // Count += 1
        dispatch_group_enter(group);
    });
    
    dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, NSEC_PER_SEC * 5);
    if (dispatch_group_wait(group, time)) {
        NSLog(@"I got tired of waiting");
    } else {
        NSLog(@"All the jobs have completed");
    }
}

+ (void)dispatchGroup4 {
    void (^myAsyncAdd)(NSInteger, NSInteger, void (^)(NSInteger)) = ^(NSInteger lhs, NSInteger rhs, void (^completion)(NSInteger)){
        completion(lhs + rhs);
    };
    
    void (^myAsyncForGroup)(dispatch_group_t, NSInteger, NSInteger, void(^)(NSInteger)) = ^(dispatch_group_t group, NSInteger lhs, NSInteger rhs, void(^completion)(NSInteger)){
        
        dispatch_group_enter(group);
        
        myAsyncAdd(lhs, rhs, ^(NSInteger result){
            completion(result);
            dispatch_group_leave(group);
        });
    };
    
    myAsyncForGroup(dispatch_group_create(), 3, 5, ^(NSInteger result){
        NSLog(@"%lu", result);
    });
}

+ (void)semaphore {
    /*
     wait는 value를 증가시키고
     signal은 value를 감소시킨다.
     value가 0이 되면 wait는 통과된다
     */
    
    dispatch_semaphore_t semaphore1 = dispatch_semaphore_create(0);
    dispatch_queue_t queue = dispatch_get_global_queue(QOS_CLASS_UNSPECIFIED, 0);
    dispatch_group_t group = dispatch_group_create();
    
    dispatch_async(queue, ^{
        dispatch_semaphore_wait(semaphore1, DISPATCH_TIME_FOREVER);
    });
    
    dispatch_async(queue, ^{
        dispatch_semaphore_wait(semaphore1, DISPATCH_TIME_FOREVER);
    });
    
    dispatch_group_async(group, queue, ^{
        [NSThread sleepForTimeInterval:3];
        dispatch_semaphore_signal(semaphore1);
    });
    
    dispatch_group_async(group, queue, ^{
        [NSThread sleepForTimeInterval:3];
        dispatch_semaphore_signal(semaphore1);
    });
    
    dispatch_group_async(group, queue, ^{
        [NSThread sleepForTimeInterval:3];
        dispatch_semaphore_signal(semaphore1);
    });
    
    dispatch_semaphore_wait(semaphore1, DISPATCH_TIME_FOREVER);
    NSLog(@"Hi!");
}

@end
