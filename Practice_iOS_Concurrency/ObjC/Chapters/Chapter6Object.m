//
//  Chapter6Object.m
//  Practice_iOS_Concurrency
//
//  Created by Jinwoo Kim on 4/17/21.
//

#import "Chapter6Object.h"

@interface _Chapter2Operation : NSOperation
@end

@implementation _Chapter2Operation
- (void)main {
    NSLog(@"Called!");
}
@end

@implementation Chapter6Object

+ (void)operation {
    NSOperation *operation = [NSOperation new];
    NSLog(@"isReady: %@", operation.isReady ? @"YES" : @"NO");
    NSLog(@"isExecuting: %@", operation.isExecuting ? @"YES" : @"NO");
    NSLog(@"isCancelled: %@", operation.isCancelled ? @"YES" : @"NO");
    NSLog(@"isFinished: %@", operation.isFinished ? @"YES" : @"NO");
}

+ (void)blockOperation {
    NSBlockOperation *blockOperation = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"Hi!");
        NSLog(@"%@", [NSThread currentThread]);
        [NSOperationQueue.mainQueue addOperationWithBlock:^{
            NSLog(@"Hi! 2");
            NSLog(@"%@", [NSThread currentThread]);
            NSLog(@"%@", [NSOperationQueue currentQueue]);
        }];
    }];
    
    [blockOperation start];
}

+ (void)multipleBlockOperations1 {
    NSString *sentence = @"Ray's courses are the best!";
    NSBlockOperation *wordOperation = [NSBlockOperation new];
    
    for (NSString *word in [sentence componentsSeparatedByString:@" "]) {
        [wordOperation addExecutionBlock:^{
            NSLog(@"%@", word);
        }];
    }
    
    wordOperation.completionBlock = ^{
        NSLog(@"Thank you for your patronage!");
    };
    
    [wordOperation start];
}

+ (void)multipleBlockOperations2 {
    NSString *sentence = @"Ray's courses are the best!";
    NSBlockOperation *wordOperation = [NSBlockOperation new];
    
    for (NSString *word in [sentence componentsSeparatedByString:@" "]) {
        [wordOperation addExecutionBlock:^{
            NSLog(@"%@", word);
            sleep(2);
        }];
    }
    
    wordOperation.completionBlock = ^{
        NSLog(@"Thank you for your patronage!");
    };
    
    NSDate *startDate = [NSDate new];
    [wordOperation start];
    // 2.001279로 찍히는걸 보야 concurrent하게 돌아가는걸 확인할 수 있다.
    NSLog(@"%f", [[NSDate new] timeIntervalSinceDate:startDate]);
}

+ (void)subclassingOperation {
    _Chapter2Operation *op = [_Chapter2Operation new];
    [op start];
}

@end
