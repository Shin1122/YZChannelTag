//
//  ChannelCell.h
//  ChannelTag
//
//  Created by Shin on 2017/11/26.
//  Copyright © 2017年 Shin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Channel.h"

@protocol ChannelCellDeleteDelegate

- (void)deleteCell:(UIButton *)sender;

@end


@interface ChannelCell : UICollectionViewCell

/**
 样式
 */
@property (nonatomic, assign) ChannelType style ;

/**
 标题
 */
@property (nonatomic, strong) UILabel *title ;
/** 右上角的删除按钮 */
@property (nonatomic, strong) UIButton * delBtn ;


@property (nonatomic, assign) id <ChannelCellDeleteDelegate> delegate ;

@property (nonatomic, strong) Channel *model ;

@end
