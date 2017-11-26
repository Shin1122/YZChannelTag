//
//  ChannelTags.h
//  ChannelTag
//
//  Created by Shin on 2017/11/26.
//  Copyright © 2017年 Shin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ChannelCell.h"

@interface ChannelTags : UIViewController

@property (nonatomic, strong) UICollectionView *mainView ;

@property (nonatomic, strong) NSMutableArray *myChannels ;

@property (nonatomic, strong) NSMutableArray *recommandChannels ;


@end
