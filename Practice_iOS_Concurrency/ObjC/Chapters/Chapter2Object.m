//
//  Chapter2Object.m
//  Practice_iOS_Concurrency
//
//  Created by Jinwoo Kim on 4/12/21.
//

#import "Chapter2Object.h"

@implementation Chapter2Object

+ (void)gcd {
    dispatch_queue_t queue = dispatch_queue_create("com.raywenderlich.worker", DISPATCH_QUEUE_CONCURRENT);
    
    
    dispatch_async(queue, ^{
        // Call slow non-UI methods here
        
        dispatch_async(dispatch_get_main_queue(), ^{
            // Update the UI here
        });
    });
}

+ (void)operation {
    NSOperation *operation = [NSOperation new];
    
    void (^printStatus)(NSOperation *) = ^(NSOperation *operation){
        NSLog(@"isReady: %@", operation.isReady ? @"YES" : @"NO");
        NSLog(@"isExecuting: %@", operation.isExecuting ? @"YES" : @"NO");
        NSLog(@"isCancelled: %@", operation.isCancelled ? @"YES" : @"NO");
        NSLog(@"isFinished: %@", operation.isFinished ? @"YES" : @"NO");
    };
    
    printStatus(operation);
    [operation start];
    printStatus(operation);
}

+ (void)blockOperation {
    // subclass of NSOperation
    NSBlockOperation *blockOperation = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"Hi!");
        NSLog(@"%@", [NSThread currentThread]);
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            NSLog(@"Hi!!! 2");
            NSLog(@"%@", [NSThread currentThread]);
            NSLog(@"%@", [NSOperationQueue currentQueue]);
        }];
    }];
    [blockOperation start];
}

@end
