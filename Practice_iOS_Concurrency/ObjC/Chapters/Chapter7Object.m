//
//  Chapter7Object.m
//  Practice_iOS_Concurrency
//
//  Created by Jinwoo Kim on 4/18/21.
//

#import "Chapter7Object.h"

@implementation Chapter7Object

+ (void)operationQueueManagement {
    NSOperationQueue *queue1 = [NSOperationQueue new];
    NSOperationQueue *queue2 = [NSOperationQueue new];
    NSOperation *op = [NSOperation new];
    [queue1 addOperation:op];
    
    // 에러! NSOperation은 중복으로 추가할 수 없고, 다른 NSOperationQueue에도 추가할 수 없다.
//    [queue1 addOperation:op];
//    [queue2 addOperation:op];
    
    // 반대로 dispatch_queue_t는 상관없음 - 재활용 가능 여부가 차이점
    
    dispatch_block_t block = dispatch_block_create(0, ^{});
    dispatch_queue_t dqueue1 = dispatch_queue_create("...1", DISPATCH_QUEUE_CONCURRENT_WITH_AUTORELEASE_POOL);
    dispatch_queue_t dqueue2 = dispatch_queue_create("...1", DISPATCH_QUEUE_CONCURRENT_WITH_AUTORELEASE_POOL);
    
    dispatch_async(dqueue1, block);
    dispatch_async(dqueue1, block);
    dispatch_async(dqueue2, block);
}

+ (void)waitingForCompletion {
    NSOperationQueue *queue = [NSOperationQueue new];
    
    NSBlockOperation *op = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"Hi! 1");
    }];
    [op addExecutionBlock:^{
        NSLog(@"Hi! 2");
    }];
    [op setCompletionBlock:^{
        NSLog(@"Completed!");
    }];
    
    [queue addOperation:op];
    [op waitUntilFinished];
    NSLog(@"Waiting was done!");
}

+ (void)qos {
    NSOperationQueue *queue = [NSOperationQueue new];
    // dispatch_queue_t의 QOS와 같음
    [queue setQualityOfService:NSQualityOfServiceUserInitiated];
}

+ (void)pause {
    NSOperationQueue *queue = [NSOperationQueue new];
    
    NSBlockOperation *op = [NSBlockOperation blockOperationWithBlock:^{
        [NSThread sleepForTimeInterval:3];
        // 안 불림
        NSLog(@"Huh?");
    }];
    
    [op setCompletionBlock:^{
        // 불림
        NSLog(@"Completed!");
    }];
    
    [queue addOperation:op];
    [op cancel];
}

+ (void)maximum {
    NSOperationQueue *queue = [NSOperationQueue new];
    
    // 기본
    queue.maxConcurrentOperationCount = NSOperationQueueDefaultMaxConcurrentOperationCount;
    
    // 최대 1개로 설정
    queue.maxConcurrentOperationCount = 1;
    
    [queue addOperationWithBlock:^{
        [NSThread sleepForTimeInterval:3];
        NSLog(@"Hi! 1");
    }];
    
    [queue addOperationWithBlock:^{
        [NSThread sleepForTimeInterval:5];
        NSLog(@"Hi! 2");
    }];
    
    /*
     3초 후에 1이 불리고, 5초 후에 2가 불린다. 후순위로 밀리는 셈. 최대 개수를 초과해도 다 돌아간다.
     */
}

+ (void)underlyingQueue {
    /*
     NSOperationQueue에 사용될 Queue를 dispatch_queue_t로 지정
     main 쓰레드는 쓰지 않는걸 권장 (해도 문제는 없는데, NSOperationQueue.mainQueue를 쓰면 되잖아)
     */
    
    NSOperationQueue *queue = [NSOperationQueue new];
    NSLog(@"%@", queue.underlyingQueue); // (null)
    dispatch_queue_t dqueue = dispatch_queue_create("com.pookjw.test", DISPATCH_QUEUE_CONCURRENT_WITH_AUTORELEASE_POOL);
    queue.underlyingQueue = dqueue;
//    queue.underlyingQueue = dispatch_get_main_queue();
    
    [queue addOperationWithBlock:^{
        // com.pookjw.test
        NSLog(@"%s", dispatch_queue_get_label(NSOperationQueue.currentQueue.underlyingQueue));
    }];
}

@end
