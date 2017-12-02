# YZChannelTag
## 仿写《今日头条》的tag选择页面

item可以移动的collectionview应用

<img src="https://github.com/Shin1122/YZChannelTag/blob/master/taggif.gif" width = "414" height = "736" alt="图片名称" align=center />

在《今日头条》中，该页面是用来选择自己感兴趣的频道标签从而改变segment的。标签功能应用的需求现在也比较多，主要使用collectionview中item可以移动的方法和思路来写这样的页面。

##用法

```
ChannelTags *controller = [[ChannelTags alloc]initWithMyTags:_myTags andRecommandTags:_recommandTags];

[self presentViewController:controller animated:YES completion:^{}];
```
可以直接加载出来该Controller,可自定义修改模态。

##初始化
```
/**
初始化器

@param myTags 已选tag
@param recommandTags 推荐tag
@return id
*/
-(instancetype)initWithMyTags:(NSArray *)myTags andRecommandTags:(NSArray *)recommandTags;

```
初始化器传入两个字符类型元素的数组，做为两组不同的数据源，可以是NSMutableArray类型。在设置完成后数组元素会发生变化，再次进入页面后会加载新的数据源。

##应用点
* 在collectionview上添加的长按手势
```
//添加长按的手势
UILongPressGestureRecognizer *longPress=[[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longPress:)];
[_mainView addGestureRecognizer:longPress];
```
* 手势状态的变化和操作
```
- (void)longPress:(UIGestureRecognizer *)longPress {
//获取点击在collectionView的坐标
CGPoint point=[longPress locationInView:_mainView];
//从长按开始
NSIndexPath *indexPath=[_mainView indexPathForItemAtPoint:point];
if (longPress.state == UIGestureRecognizerStateBegan) {
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
```
* 实现回调方法
```
- (BOOL)collectionView:(UICollectionView *)collectionView canMoveItemAtIndexPath:(NSIndexPath *)indexPath;
-(void)collectionView:(UICollectionView *)collectionView moveItemAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath;
```





