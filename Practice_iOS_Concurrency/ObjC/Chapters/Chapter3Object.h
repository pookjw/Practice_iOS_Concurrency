//
//  Chapter3Object.h
//  Practice_iOS_Concurrency
//
//  Created by Jinwoo Kim on 4/12/21.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Chapter3Object : NSObject
+ (void)concurrent;
+ (void)qos;
+ (void)addingTaskToQueue;
+ (void)dispatchWorkItem;
+ (void)dependencies;
@end

NS_ASSUME_NONNULL_END
