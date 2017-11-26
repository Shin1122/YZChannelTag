//
//  ChannelTags.m
//  ChannelTag
//
//  Created by Shin on 2017/11/26.
//  Copyright © 2017年 Shin. All rights reserved.
//

#import "ChannelTags.h"

#define SCREENWIDTH self.view.frame.size.width

@interface ChannelTags ()<UICollectionViewDelegate,UICollectionViewDataSource,ChannelCellDeleteDelegate>{
    
    NSMutableArray *_myTags;
    NSMutableArray *_recommandTags;
    
}

@end

@implementation ChannelTags

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:0.11 green:0.11 blue:0.11 alpha:1.00];
    //加载数据
    [self makeData];
    //视图
    [self setupViews];
    
}
- (void)makeData{
    _myChannels = @[@"关注",@"推荐",@"热点",@"北京",@"视频",@"社会",@"图片",@"娱乐",@"问答",@"科技",@"汽车",@"财经",@"军事",@"体育",@"段子",@"国际",@"趣图",@"健康",@"特卖",@"房产",@"美食"].mutableCopy;
    _recommandChannels = @[@"小说",@"时尚",@"历史",@"育儿",@"直播",@"搞笑",@"数码",@"养生",@"电影",@"手机",@"旅游",@"宠物",@"情感",@"家居",@"教育",@"三农"].mutableCopy;
    [self makeTags];
}

- (void)makeTags{
    _myTags = @[].mutableCopy;
    _recommandTags = @[].mutableCopy;
    for (NSString *title in _myChannels) {
        Channel *mod = [[Channel alloc]init];
        mod.title = title;
        if ([title isEqualToString:@"关注"]||[title isEqualToString:@"推荐"]) {
            mod.resident = YES;//常驻
        }
        mod.editable = YES;
        mod.tagType = MyChannel;
        [_myTags addObject:mod];
    }
    for (NSString *title in _recommandChannels) {
        Channel *mod = [[Channel alloc]init];
        mod.title = title;
        if ([title isEqualToString:@"关注"]||[title isEqualToString:@"推荐"]) {
            mod.resident = YES;//常驻
        }
        mod.editable = NO;
        mod.tagType = RecommandChannel;
        [_recommandTags addObject:mod];
    }
}

- (void)setupViews{
    
    UIButton *exit = [[UIButton alloc]init];
    [self.view addSubview:exit];
    exit.frame = CGRectMake(15, 30, 20, 20);
    [exit setImage:[UIImage imageNamed:@"Exit"] forState:UIControlStateNormal];
    exit.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [exit addTarget:self action:@selector(returnLast) forControlEvents:UIControlEventTouchUpInside];
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    _mainView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, exit.frame.origin.y+exit.frame.size.height, self.view.frame.size.width, self.view.frame.size.height-40) collectionViewLayout:layout];
    [self.view addSubview:_mainView];
    _mainView.backgroundColor = [UIColor colorWithRed:0.11 green:0.11 blue:0.11 alpha:1.00];
    [_mainView registerClass:[ChannelCell class] forCellWithReuseIdentifier:@"cellIdentifier"];
    [_mainView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"head1"];
    [_mainView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"head2"];
    
    _mainView.delegate = self;
    _mainView.dataSource = self;
    
    //添加长按的手势
    UILongPressGestureRecognizer *longPress=[[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longPress:)];
    [_mainView addGestureRecognizer:longPress];
    
    
}

- (void)longPress:(UIGestureRecognizer *)longPress {
    //获取点击在collectionView的坐标
    CGPoint point=[longPress locationInView:_mainView];
    //从长按开始
    if (longPress.state == UIGestureRecognizerStateBegan) {
        NSIndexPath *indexPath=[_mainView indexPathForItemAtPoint:point];
        [_mainView beginInteractiveMovementForItemAtIndexPath:indexPath];
        //长按手势状态改变
    } else if(longPress.state==UIGestureRecognizerStateChanged) {
        [_mainView updateInteractiveMovementTargetPosition:point];
        //长按手势结束
    } else if (longPress.state==UIGestureRecognizerStateEnded) {
        [_mainView endInteractiveMovement];
        //其他情况
    } else {
        [_mainView cancelInteractiveMovement];
    }
    
}

#pragma mark- collection datasource
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (section == 0) {
        return _myTags.count;
    }else{
        return _recommandTags.count;
    }
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString * CellIdentifier = @"cellIdentifier";
    ChannelCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    if (indexPath.section == 0) {
        if (_myTags.count>indexPath.item) {
            cell.model = _myTags[indexPath.item];
            cell.delBtn.tag = indexPath.item;
            cell.delegate = self;
        }
    }else if (indexPath.section == 1){
        if (_recommandTags.count>indexPath.item) {
            cell.model = _recommandTags[indexPath.item];
        }
    }
    
    return cell;
}

#pragma mark- collection delegate
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 2;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return CGSizeMake(SCREENWIDTH/4-10, 53);
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(0, 10, 4, 10);
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 4;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 5;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    return CGSizeMake(collectionView.bounds.size.width, 50);
}

-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    UICollectionReusableView *header = nil;
    //三个section的情况
    if (indexPath.section == 0) {
        //section的header
        if (kind == UICollectionElementKindSectionHeader){
            NSString *CellIdentifier = @"head1";
            //从缓存中获取 Headercell
            header=[collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:CellIdentifier forIndexPath:indexPath];
            UILabel *lab1 = [[UILabel alloc]init];
            [header addSubview:lab1];
            lab1.text = @"我的频道";
            lab1.frame = CGRectMake(20, 0, 200, 60);
            lab1.textColor = [UIColor colorWithRed:0.36 green:0.36 blue:0.36 alpha:1.00];
        }
    }else if (indexPath.section == 1){
        //section的header
        if (kind == UICollectionElementKindSectionHeader){
            NSString *CellIdentifier = @"head2";
            //从缓存中获取 Headercell
            header=[collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:CellIdentifier forIndexPath:indexPath];
        }
    }
        return header;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canMoveItemAtIndexPath:(NSIndexPath *)indexPath{
    ChannelCell *cell = (ChannelCell *)[collectionView cellForItemAtIndexPath:indexPath];
    if (indexPath.section == 0) {
        if (cell.model.resident) {
            return NO;
        }else{
            return YES;
        }
    }
    return NO;
}
//
//- (NSIndexPath *)collectionView:(UICollectionView *)collectionView targetIndexPathForMoveFromItemAtIndexPath:(NSIndexPath *)originalIndexPath toProposedIndexPath:(NSIndexPath *)proposedIndexPath {
//    /* 两个indexpath参数, 分别代表源位置, 和将要移动的目的位置*/
//    //-1 是为了不让最后一个可以交换位置
//    if (proposedIndexPath.item == (_myTags.count - 1)) {
//        //初始位置
//        return originalIndexPath;
//    } else {
//        //-1 是为了不让最后一个可以交换位置
//        if (originalIndexPath.item == (_myTags.count - 1)) {
//            return originalIndexPath;
//        }
//        //      移动后的位置
//        return proposedIndexPath;
//    }
//}
-(void)collectionView:(UICollectionView *)collectionView moveItemAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath{
    //记录要移动的数据
    id object= _myTags[sourceIndexPath.item];
    //删除要移动的数据
    [_myTags removeObjectAtIndex:sourceIndexPath.item];
    //添加新的数据到指定的位置
    [_myTags insertObject:object atIndex:destinationIndexPath.item];
    
}



-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 1) {
        ChannelCell *cell = (ChannelCell *)[collectionView cellForItemAtIndexPath:indexPath];
        cell.model.editable = YES;
        cell.model.tagType = MyChannel;
        cell.delBtn.hidden = NO;
        [_mainView reloadItemsAtIndexPaths:@[indexPath]];
        [_recommandTags removeObjectAtIndex:indexPath.item];
        [_myTags addObject:cell.model];
        NSIndexPath *targetIndexPage = [NSIndexPath indexPathForItem:_myTags.count-1 inSection:0];
        cell.delBtn.tag = targetIndexPage.item;
        [_mainView moveItemAtIndexPath:indexPath toIndexPath:targetIndexPage];
    }
}

-(void)deleteCell:(UIButton *)sender{
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:sender.tag inSection:0];
    ChannelCell *cell = (ChannelCell *)[_mainView cellForItemAtIndexPath:indexPath];
    cell.model.editable = NO;
    cell.model.tagType = RecommandChannel;
    cell.delBtn.hidden = YES;
    [_mainView reloadItemsAtIndexPaths:@[indexPath]];
    [_myTags removeObjectAtIndex:indexPath.item];
    [_recommandTags insertObject:cell.model atIndex:0];
     NSIndexPath *targetIndexPage = [NSIndexPath indexPathForItem:0 inSection:1];
    [_mainView moveItemAtIndexPath:indexPath toIndexPath:targetIndexPage];
    
}


- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

- (void)returnLast{
    [self dismissViewControllerAnimated:YES completion:^{}];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
