//
//  Chapter7Object.h
//  Practice_iOS_Concurrency
//
//  Created by Jinwoo Kim on 4/18/21.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Chapter7Object : NSObject
+ (void)operationQueueManagement;
+ (void)waitingForCompletion;
+ (void)qos;
+ (void)pause;
+ (void)maximum;
+ (void)underlyingQueue;
@end

NS_ASSUME_NONNULL_END
