//
//  Chapter9Object.h
//  Practice_iOS_Concurrency
//
//  Created by Jinwoo Kim on 4/18/21.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Chapter9Object : NSObject
+ (void)dependenciesSync1;
+ (void)sync2;
+ (void)sync3;
@end

NS_ASSUME_NONNULL_END
