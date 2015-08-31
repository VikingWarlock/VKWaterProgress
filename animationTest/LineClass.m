//
//  LineClass.m
//  animationTest
//
//  Created by VKWK on 8/31/15.
//  Copyright © 2015 VKWK. All rights reserved.
//

#import "LineClass.h"
@import QuartzCore;

#define N 5

@interface LineClass()
{
    NSTimer *BaseTimer;
    UIBezierPath *roundPath;
    float timeInterval;
    float ShowedHeight;
    UILabel *PercentLabel;
    BOOL labelShown;
}
@end

@implementation LineClass


-(instancetype)init
{
    self=[super init];
    if (self) {
        timeInterval=0.f;
        ShowedHeight=0.f;
    }
    return self;
}

-(void)setProgress:(float)progress
{
    _progress=progress;
    if (self.showLabel&&progress<=1.f) {
        PercentLabel.text=[NSString stringWithFormat:@"%d %%",(int)(100*progress)];
    }else
    {
    }
}



-(void)showInView:(UIView *)view
{
    [view addSubview:self];
    if (BaseTimer==nil) {
        BaseTimer=[NSTimer scheduledTimerWithTimeInterval:1/30.f target:self selector:@selector(timer) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop]addTimer:BaseTimer forMode:NSRunLoopCommonModes];
    }
}

-(void)setShowLabel:(BOOL)showLabel
{
    _showLabel=showLabel;
    if (showLabel) {
        if (PercentLabel==nil) {
            PercentLabel=[[UILabel alloc]init];
            PercentLabel.textAlignment=NSTextAlignmentCenter;
//            if (self.fillColor) {
//                PercentLabel.textColor=[self converseColor:self.fillColor];
//            }else
//            {
//                PercentLabel.textColor=[UIColor whiteColor];
//            }

            PercentLabel.textColor=[UIColor whiteColor];
            PercentLabel.font=[UIFont systemFontOfSize:50.f];
            PercentLabel.minimumScaleFactor=10.f;
            float width=self.frame.size.width;
            float height=self.frame.size.height;
            int wid=(int)(width*0.6);
            int hei=(int)(height*0.6);
            float maxLength=MIN(wid, hei);
            PercentLabel.frame=CGRectMake(width*0.5f-maxLength/2.f, height*0.618f-maxLength/2.f, maxLength, maxLength);
            PercentLabel.layer.borderColor=[UIColor whiteColor].CGColor;
            PercentLabel.layer.borderWidth=5.f;
            PercentLabel.layer.cornerRadius=maxLength/2.f;
            PercentLabel.backgroundColor=[UIColor clearColor];
            [self addSubview:PercentLabel];
        }
        
    }else
    {
        [PercentLabel removeFromSuperview];
    }
}

-(void)dismiss
{

}

-(void)setEmptyColor:(UIColor *)emptyColor
{
    self.backgroundColor=emptyColor;
}

-(void)setFillColor:(UIColor *)fillColor
{
    _fillColor=fillColor;
//    CGContextRef ctx=UIGraphicsGetCurrentContext();
//    CGContextSetFillColorWithColor(ctx, fillColor.CGColor);
//    CGContextSetStrokeColorWithColor(ctx, fillColor.CGColor);
    
}


-(void)timer
{
    timeInterval+=0.3f;
    [self setNeedsDisplay];
}

-(void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    [self draw];
}

-(void)draw
{
    float width=self.frame.size.width;
    if (roundPath==nil) {
        roundPath=[UIBezierPath bezierPath];
    }
    [roundPath removeAllPoints];
    float startx=0.f;
    float starty=self.frame.size.height*(1-self.progress);

    [roundPath moveToPoint:CGPointMake(startx, starty)];
    for (startx=0.f; startx<width+1.f; startx+=1.f) {
        int heightOffset=(arc4random()%100)-100;
        float offset=heightOffset/100.f*1.5;
        [roundPath addLineToPoint:CGPointMake(startx, starty+(3)*sinf(startx/width*N*2*M_PI+timeInterval)+offset)];
    }
    
    if (_progress<0.35) {
        PercentLabel.textColor=[UIColor blackColor];
        PercentLabel.layer.borderColor=[UIColor blackColor].CGColor;
    }else
    {
        PercentLabel.textColor=[UIColor whiteColor];
        PercentLabel.layer.borderColor=[UIColor whiteColor].CGColor;
    }
    
    [_fillColor setStroke];
    [_fillColor setFill];
    
    [roundPath stroke];
    [roundPath addLineToPoint:CGPointMake(width, self.frame.size.height)];
    [roundPath addLineToPoint:CGPointMake(0, self.frame.size.height)];
    [roundPath addLineToPoint:CGPointMake(0, starty)];
    [roundPath fill];
}

-(UIColor *)converseColor:(UIColor*)origin
{
    return nil;
}

-(void)done
{
    self.progress=1.3;
    [self draw];
    [BaseTimer invalidate];
    
    [UIView animateWithDuration:0.3f animations:^{
        PercentLabel.text=@"完成";
        
    } completion:^(BOOL finished) {
        
    }];

}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
