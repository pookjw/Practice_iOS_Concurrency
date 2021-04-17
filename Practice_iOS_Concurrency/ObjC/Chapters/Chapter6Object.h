//
//  Chapter6Object.h
//  Practice_iOS_Concurrency
//
//  Created by Jinwoo Kim on 4/17/21.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Chapter6Object : NSObject
+ (void)operation;
+ (void)blockOperation;
+ (void)multipleBlockOperations1;
+ (void)multipleBlockOperations2;
+ (void)subclassingOperation;
@end

NS_ASSUME_NONNULL_END
