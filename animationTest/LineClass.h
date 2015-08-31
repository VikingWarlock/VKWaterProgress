//
//  LineClass.h
//  animationTest
//
//  Created by VKWK on 8/31/15.
//  Copyright © 2015 VKWK. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LineClass : UIView

@property(nonatomic,assign)float progress;
@property(nonatomic,assign)BOOL showLabel;
@property(nonatomic,assign)UIColor *emptyColor;
@property(nonatomic,assign)UIColor *fillColor;

-(void)showInView:(UIView*)view;

-(void)dismiss;

-(void)done;

@end
