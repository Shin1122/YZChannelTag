//
//  ChannelTags.h
//  ChannelTag
//
//  Created by Shin on 2017/11/26.
//  Copyright © 2017年 Shin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ChannelCell.h"


/**
 选择出来的tags们

 @param tags 数组里都是对象
 */
typedef void(^ChoosedTags)(NSArray *chooseTags,NSArray *recommandTags);


/**
 单独选择的tag

 @param channel channel对象
 */
typedef void(^SelectedTag)(Channel *channel);

@interface ChannelTags : UIViewController

@property (nonatomic, strong) UICollectionView *mainView ;

@property (nonatomic, strong) NSMutableArray *myChannels ;

@property (nonatomic, strong) NSMutableArray *recommandChannels ;

@property (nonatomic, copy) ChoosedTags choosedTags ;

@property (nonatomic, copy) SelectedTag selectedTag ;


/**
 初始化器

 @param myTags 已选tag
 @param recommandTags 推荐tag
 @return id
 */
-(instancetype)initWithMyTags:(NSArray *)myTags andRecommandTags:(NSArray *)recommandTags;

@end
