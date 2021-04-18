//
//  Chapter10Object.h
//  Practice_iOS_Concurrency
//
//  Created by Jinwoo Kim on 4/19/21.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Chapter10Object : NSObject
+ (void)cancel;
+ (void)cancelAllOperations;
@end

NS_ASSUME_NONNULL_END
