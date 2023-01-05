//
//  NSObject+AsrManager.h
//  Runner
//
//  Created by 吴海恒 on 2023/1/3.
//

#import <Foundation/Foundation.h>

@interface AsrManager:NSObject
typedef void(^AsrCallback)(NSString* message);
+(instancetype)initWith:(AsrCallback)success failure:(AsrCallback)failure;
- (void)start;
- (void)stop;
- (void)cancel;
@end

