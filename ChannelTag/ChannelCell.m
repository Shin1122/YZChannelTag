//
//  ChannelCell.m
//  ChannelTag
//
//  Created by Shin on 2017/11/26.
//  Copyright © 2017年 Shin. All rights reserved.
//

#import "ChannelCell.h"

@interface ChannelCell (){
    
}



@end

@implementation ChannelCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        //title
        _title = [[UILabel alloc]init];
        [self.contentView addSubview:_title];
        _title.frame = CGRectMake(5, 5, frame.size.width-10, frame.size.height-10);
        _title.backgroundColor = [UIColor colorWithRed:0.08 green:0.08 blue:0.08 alpha:1.0];
        _title.layer.masksToBounds = YES;
        _title.layer.cornerRadius = M_PI;
        _title.font = [UIFont systemFontOfSize:16];
        _title.textAlignment = NSTextAlignmentCenter;
        _title.numberOfLines = 0;
        _title.textColor = [UIColor colorWithRed:0.36 green:0.36 blue:0.36 alpha:1.00];
        
        _delBtn = [[UIButton alloc]init];
        [self.contentView addSubview:_delBtn];
        _delBtn.frame = CGRectMake(frame.size.width-18, 0, 18, 18);
        [_delBtn setImage:[UIImage imageNamed:@"del"] forState:UIControlStateNormal];
        [_delBtn addTarget:self action:@selector(delete:) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

-(void)setModel:(Channel *)model{
    
    _model = model;
    
    if (model.tagType == MyChannel) {
        if ([model.title containsString:@"＋"]) {
            model.title = [model.title substringFromIndex:1];
        }
        if (model.editable) {
        }else{
            model.editable = YES;
        }
        if (model.resident) {
            _delBtn.hidden = YES;
        }else{
            _delBtn.hidden = NO;
        }
        
        //选择出来的tag高亮显示
        if (model.selected) {
            _title.textColor = [UIColor colorWithRed:0.5 green:0.26 blue:0.27 alpha:1.0];
        }else{
            _title.textColor = [UIColor colorWithRed:0.36 green:0.36 blue:0.36 alpha:1.0];
        }
        
    }else if (model.tagType == RecommandChannel){
        if (![model.title containsString:@"＋"]) {
            model.title = [@"＋" stringByAppendingString:model.title];
        }
        if (model.editable) {
            model.editable = NO;
        }else{
        }
//        if (model.resident) {
//            _delBtn.hidden = YES;
//        }else{
//            _delBtn.hidden = NO;
//        }
        _delBtn.hidden = YES;
    }
    _title.text = model.title;
    
}



- (void)delete:(UIButton *)sender{
    
    [_delegate deleteCell:sender];
}



@end
