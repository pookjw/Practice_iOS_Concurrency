//
//  Chapter9Object.m
//  Practice_iOS_Concurrency
//
//  Created by Jinwoo Kim on 4/18/21.
//

#import "Chapter9Object.h"

@implementation Chapter9Object

+ (void)dependenciesSync1 {
    // dependency로 등록된 작업이 끝나야 실행된다.
    NSOperationQueue *queue = [NSOperationQueue new];
    
    NSBlockOperation *op1 = [NSBlockOperation blockOperationWithBlock:^{
        [NSThread sleepForTimeInterval:1];
        NSLog(@"Hi! 1");
    }];
    NSBlockOperation *op2 = [NSBlockOperation blockOperationWithBlock:^{
        [NSThread sleepForTimeInterval:2];
        NSLog(@"Hi! 2");
    }];
    NSBlockOperation *op3 = [NSBlockOperation blockOperationWithBlock:^{
        [NSThread sleepForTimeInterval:3];
        NSLog(@"Hi! 3");
    }];
    
    [op2 addDependency:op1];
    [op3 addDependency:op2];
    
    [queue addOperation:op1];
    [queue addOperation:op2];
    [queue addOperation:op3];
    
    [op3 removeDependency:op2];
}

+ (void)sync2 {
    // 호기심... 책에는 없음
    NSOperationQueue *queue = [NSOperationQueue new];
    queue.maxConcurrentOperationCount = 1;
    
    NSBlockOperation *op1 = [NSBlockOperation blockOperationWithBlock:^{
        [NSThread sleepForTimeInterval:1];
        NSLog(@"Hi! 1");
    }];
    NSBlockOperation *op2 = [NSBlockOperation blockOperationWithBlock:^{
        [NSThread sleepForTimeInterval:2];
        NSLog(@"Hi! 2");
    }];
    NSBlockOperation *op3 = [NSBlockOperation blockOperationWithBlock:^{
        [NSThread sleepForTimeInterval:3];
        NSLog(@"Hi! 3");
    }];
    
    [queue addOperation:op1];
    [queue addOperation:op2];
    [queue addOperation:op3];
}

+ (void)sync3 {
    // 호기심... 책에는 없음
    NSOperationQueue *queue = [NSOperationQueue new];
    
    [queue addBarrierBlock:^{
        [NSThread sleepForTimeInterval:1];
        NSLog(@"Hi! 1");
    }];
    
    [queue addBarrierBlock:^{
        [NSThread sleepForTimeInterval:2];
        NSLog(@"Hi! 2");
    }];
    
    [queue addBarrierBlock:^{
        [NSThread sleepForTimeInterval:3];
        NSLog(@"Hi! 3");
    }];
}

@end
