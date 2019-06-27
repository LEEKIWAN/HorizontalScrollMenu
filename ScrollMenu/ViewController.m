//
//  ViewController.m
//  ScrollMenu
//
//  Created by kiwan on 26/06/2019.
//  Copyright © 2019 kiwan. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet CategoryView *categoryView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)viewDidAppear:(BOOL)animated {
    
    [_categoryView setDelegate:self];
    [_categoryView setIsFitTextWidth:YES];
    [_categoryView.selectBarView setBackgroundColor:UIColor.grayColor];
    [_categoryView setData:[self createViewTabDatas]];
    [_categoryView setSelectIndex:0];
    
}

- (NSMutableArray<NSString *> *)createViewTabDatas {
    NSMutableArray *array = [[NSMutableArray alloc] init];
    
    [array addObject:@"ki"];
    [array addObject:@"ki22"];
    [array addObject:@"ki3333"];
    [array addObject:@"ki44444222222"];
    [array addObject:@"ki44444"];
    [array addObject:@"ki44444"];
    [array addObject:@"ki44444"];
    
    return array;
}

#pragma mark - CategoryViewDelegate
- (void)didSelectMainCategoryTab:(CategoryView *)view index:(NSInteger)index {
    NSLog(@"%ld", (long)index);
}

#pragma mark - Event

@end
