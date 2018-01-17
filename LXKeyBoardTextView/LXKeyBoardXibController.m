//
//  LXKeyBoardXibController.m
//  LXKeyBoardTextView
//
//  Created by chenergou on 2018/1/17.
//  Copyright © 2018年 漫漫. All rights reserved.
//

#import "LXKeyBoardXibController.h"
#import "LXKeyBoard.h"
@interface LXKeyBoardXibController ()
@property (weak, nonatomic) IBOutlet LXKeyBoard *keyBoard;

@end

@implementation LXKeyBoardXibController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.keyBoard.isDisappear = NO;
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.keyBoard.isDisappear = YES;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self.keyBoard beginUpdateUI];
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
