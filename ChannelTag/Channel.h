//
//  Channel.h
//  ChannelTag
//
//  Created by Shin on 2017/11/26.
//  Copyright © 2017年 Shin. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 cell类型
 
 - MyChannel: 我的频道样式 不带“+”的
 - RecommandChannel: 推荐频道样式 带“+”的
 */
typedef NS_ENUM(NSUInteger, ChannelType) {
    MyChannel,
    RecommandChannel,
};

@interface Channel : NSObject

@property (nonatomic, assign) BOOL resident ;
@property (nonatomic, assign) BOOL editable ;

@property (nonatomic, strong) NSString *title ;

@property (nonatomic, assign) BOOL selected ;

@property (nonatomic, assign) ChannelType tagType ;

@end
