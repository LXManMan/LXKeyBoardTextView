//
//  ViewController.m
//  LXKeyBoardTextView
//
//  Created by chenergou on 2017/12/21.
//  Copyright © 2017年 漫漫. All rights reserved.
//

#import "ViewController.h"
#import "LXKeyboadController.h"
#import "LXKeyBoardXibController.h"
@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *tabelview;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.title = @"自定义限制多行输入框";
    
     [self setUp];
}


-(void)setUp{
    [self.view addSubview:self.tableview];
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    if (!cell) {
        cell =[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
   
    
    if (indexPath.row == 0) {
        cell.textLabel.text = @"代码初始化键盘";
    }else{
        cell.textLabel.text = @"xib初始化键盘";

    }
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
    if (indexPath.row == 0) {
        LXKeyboadController *changeVc =[[LXKeyboadController alloc]init];
        [self.navigationController pushViewController:changeVc animated:YES];
    }else{
        LXKeyBoardXibController *changeVc =[[LXKeyBoardXibController alloc]init];
        [self.navigationController pushViewController:changeVc animated:YES];
        
    }
    
}
-(UITableView *)tableview{
    
    if (!_tabelview) {
        _tabelview =[[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tabelview.delegate = self;
        _tabelview.dataSource = self;
        
        _tabelview.showsVerticalScrollIndicator = NO;
        _tabelview.showsHorizontalScrollIndicator = NO;
        _tabelview.tableFooterView = [UIView new];
        
        [_tabelview registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
        
    }
    return _tabelview;
}


@end
