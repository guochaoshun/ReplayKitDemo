//
//  SecondViewController.m
//  测试刷新冲突
//
//  Created by 郭朝顺 on 2021/9/24.
//

#import "SecondViewController.h"

@interface SecondViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
    

}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {

    NSLog(@"局部刷新");
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];

    NSLog(@"全体刷新");
    [self.tableView reloadData];

//    NSLog(@"局部刷新1");
//    NSIndexPath *indexPath1 = [NSIndexPath indexPathForRow:1 inSection:0];
//    [self.tableView reloadRowsAtIndexPaths:@[indexPath1] withRowAnimation:UITableViewRowAnimationNone];

}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
    cell.contentView.backgroundColor = [UIColor orangeColor];
    cell.textLabel.text = @(indexPath.row).stringValue;
    NSLog(@"tableView刷新  -- %@",@(indexPath.row));
    return cell;
}



@end
