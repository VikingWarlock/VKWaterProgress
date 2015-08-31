//
//  ViewController.m
//  animationTest
//
//  Created by VKWK on 8/31/15.
//  Copyright © 2015 VKWK. All rights reserved.
//

#import "ViewController.h"
#import "LineClass.h"

@interface ViewController ()
{
    NSTimer *baseTimer;
    int percentage;
    LineClass *line;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    line=[[LineClass alloc]init];
    line.frame=CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    line.fillColor=[UIColor blueColor];
    line.emptyColor=[UIColor yellowColor];
    line.showLabel=YES;
    [line showInView:self.view];

    baseTimer=[NSTimer scheduledTimerWithTimeInterval:.4f target:self selector:@selector(timer) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop]addTimer:baseTimer forMode:NSRunLoopCommonModes];
    percentage=0.f;
    // Do any additional setup after loading the view, typically from a nib.
}

-(void)timer
{
    percentage+=arc4random()%20;
    if (percentage>100) {
        line.progress=1.f;
        percentage=100;
        [line done];
        [baseTimer invalidate];
    }else
    {
        line.progress=percentage/100.f;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
