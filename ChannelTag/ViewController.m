//
//  ViewController.m
//  ChannelTag
//
//  Created by Shin on 2017/11/26.
//  Copyright © 2017年 Shin. All rights reserved.
//

#import "ViewController.h"
#import "ChannelTags.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UILabel *tagLabel;

@end

@implementation ViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (IBAction)chooseBtn:(id)sender {
    //秀出来选择框
    ChannelTags *controller = [[ChannelTags alloc]init];
    [self presentViewController:controller animated:YES completion:^{
        
    }];
    
}

- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
