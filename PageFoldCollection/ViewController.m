//
//  ViewController.m
//  PageFoldCollection
//
//  Created by zangqilong on 14/11/24.
//  Copyright (c) 2014年 zangqilong. All rights reserved.
//

#import "ViewController.h"
#import "PageCollectionViewCell.h"
#import "MacroDefinition.h"
#import "FoldingView.h"

@interface ViewController ()
- (void)addFoldView;
@property(nonatomic) FoldingView *foldView;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self addFoldView];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.foldView poke];
}

#pragma mark - Private instance methods

- (void)addFoldView
{
    CGFloat padding = 30.f;
    CGFloat width = CGRectGetWidth(self.view.bounds) - padding * 2;
    CGRect frame = CGRectMake(0, 0, width, width);
    
    self.foldView = [[FoldingView alloc] initWithFrame:frame
                                                 image:[UIImage imageNamed:@"boat.jpg"]];
    self.foldView.center = self.view.center;
    [self.view addSubview:self.foldView];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
