//
//  ViewController.m
//  CircleProgress
//
//  Created by wangwei on 16/10/9.
//  Copyright © 2016年 wangwei-WW. All rights reserved.
//

#import "ViewController.h"
#import "CCCircleView.h"



@interface ViewController ()

@property (nonatomic, strong) CCCircleView *circleView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initViews];
}
- (void)initViews {
    [self.view addSubview:self.circleView];
    self.circleView.center = self.view.center;
    
}

#pragma mark - getter
- (CCCircleView *)circleView {
    if (!_circleView) {
        _circleView = [[CCCircleView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
        CGFloat progress = arc4random()%10*0.1;
        _circleView.progress = progress;
        //_circleView.winth = 4.0;
    }
    return _circleView;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
