//
//  Chapter4Object.h
//  Practice_iOS_Concurrency
//
//  Created by Jinwoo Kim on 4/17/21.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Chapter4Object : NSObject
+ (void)dispatchGroup1;
+ (void)dispatchGroup2;
+ (void)dispatchGroup3;
+ (void)dispatchGroup4;
+ (void)semaphore;
@end

NS_ASSUME_NONNULL_END
