//
//  ViewController.m
//  Clock Firework
//
//  Created by HIROKI on 2014/03/18.
//  Copyright (c) 2014年 HIROKI. All rights reserved.
//

#import "ViewController.h"
#import "FireworkLayerView.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    FireworkLayerView *v = [[FireworkLayerView alloc] initWithFrame:self.view.bounds];
    v.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:v];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
