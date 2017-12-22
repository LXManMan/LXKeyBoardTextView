//
//  ViewController.m
//  LXKeyBoardTextView
//
//  Created by chenergou on 2017/12/21.
//  Copyright © 2017年 漫漫. All rights reserved.
//

#import "ViewController.h"
#import "LXKeyboadController.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.title = @"自定义限制多行输入框";
}
- (IBAction)click:(id)sender {
    LXKeyboadController *changeVc =[[LXKeyboadController alloc]init];
    [self.navigationController pushViewController:changeVc animated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
