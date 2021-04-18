//
//  Chapter10Object.m
//  Practice_iOS_Concurrency
//
//  Created by Jinwoo Kim on 4/19/21.
//

#import "Chapter10Object.h"

@implementation Chapter10Object

+ (void)cancel {
    NSOperationQueue *queue = [NSOperationQueue new];
    
    NSBlockOperation *op1 = [NSBlockOperation blockOperationWithBlock:^{
        [NSThread sleepForTimeInterval:5];
        NSLog(@"Hi! 1");
    }];
    
    NSBlockOperation *op2 = [NSBlockOperation blockOperationWithBlock:^{
        [NSThread sleepForTimeInterval:5];
        NSLog(@"Hi! 2");
    }];
    
    [op1 setCompletionBlock:^{
        NSLog(@"Completed 1!"); // cancel 하자마자 나옴
    }];
    
    [queue addOperation:op1];
    [queue addOperation:op2];
    
    [op1 cancel]; // Hi! 1는 안 나옴!
    
    NSLog(@"op1.isCancelled: %@", op1.isCancelled ? @"YES" : @"NO"); // YES
    NSLog(@"op1.isFinished: %@", op1.isFinished ? @"YES" : @"NO"); // YES
}

+ (void)cancelAllOperations {
    NSOperationQueue *queue = [NSOperationQueue new];
    
    NSBlockOperation *op1 = [NSBlockOperation blockOperationWithBlock:^{
        [NSThread sleepForTimeInterval:5];
        NSLog(@"Hi! 1");
    }];
    
    NSBlockOperation *op2 = [NSBlockOperation blockOperationWithBlock:^{
        [NSThread sleepForTimeInterval:5];
        NSLog(@"Hi! 2");
    }];
    
    [queue addOperation:op1];
    [queue addOperation:op2];
    
    [op1 setCompletionBlock:^{
        NSLog(@"Completed 1!"); // cancel 하자마자 나옴
    }];
    
    [op2 setCompletionBlock:^{
        NSLog(@"Completed 2!"); // cancel 하자마자 나옴
    }];
    
    [queue cancelAllOperations];
    
    NSLog(@"op1.isCancelled: %@", op1.isCancelled ? @"YES" : @"NO"); // YES
    NSLog(@"op1.isFinished: %@", op1.isFinished ? @"YES" : @"NO"); // YES
}

@end
