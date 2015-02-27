//
//  ViewController.m
//  splitView
//
//  Created by Артур Сагидулин on 26.02.15.
//  Copyright (c) 2015 Артур Сагидулин. All rights reserved.
//

#import "ViewController.h"

@interface ViewController (){
    CGFloat height;
    CGFloat width;
    CGFloat leftBorderOfView;
    CGFloat verticalPaddingOfSlider;
}
@property (weak, nonatomic) IBOutlet UIView *slider;
@property (strong, nonatomic) IBOutlet UIPanGestureRecognizer *myPan;
@property (weak, nonatomic) IBOutlet UIView *secondView;
@property (weak, nonatomic) IBOutlet UIButton *myButton;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.myButton setTitle:@"show" forState:UIControlStateNormal];
    height = [UIScreen mainScreen].applicationFrame.size.height;
    width = 60;
    verticalPaddingOfSlider = 28;
    leftBorderOfView = -60;
    self.slider.frame = CGRectMake(0, -verticalPaddingOfSlider, width, height);
    self.secondView.frame = CGRectMake(leftBorderOfView, self.secondView.frame.origin.y, self.secondView.frame.size.width, self.secondView.frame.size.height);
}

- (IBAction)clicked:(id)sender {
    UIButton *button = sender;
    if ([button.titleLabel.text isEqualToString:@"hide"]) {
        [self.myButton setTitle:@"show" forState:UIControlStateNormal];
        [self moveBack:leftBorderOfView];
    } else if ([button.titleLabel.text isEqualToString:@"show"]){
        [self.myButton setTitle:@"hide" forState:UIControlStateNormal];
        [self moveRight:leftBorderOfView];
    }
}
-(void)moveRight:(CGFloat)transition{
    [UIView animateWithDuration:0.4 animations:^{
        CGRect rect = self.secondView.frame;
        self.secondView.frame = CGRectMake(0,rect.origin.y, rect.size.width, rect.size.height);
    }];
}
-(void)moveBack:(CGFloat)transition{
    [UIView animateWithDuration:0.4 animations:^{
        CGRect rect = self.secondView.frame;
        self.secondView.frame = CGRectMake(leftBorderOfView,rect.origin.y, rect.size.width, rect.size.height);
    }];
}

-(IBAction)movement:(UIPanGestureRecognizer *)pan{
    CGPoint translatedPoint = [pan translationInView:self.secondView];
    CGPoint velocity = [pan velocityInView:self.secondView];
    CGRect view = self.secondView.frame;
    switch (pan.state) {
        case UIGestureRecognizerStateBegan:{
            break;
        }
        case UIGestureRecognizerStateChanged:{
                CGFloat leftBorderForCenterOfView = 100;
                CGFloat rightBorderForCenterOfView = 160;
                CGPoint newView = CGPointMake(self.secondView.center.x + translatedPoint.x, self.secondView.center.y);
                if (newView.x>rightBorderForCenterOfView){
                    newView.x=rightBorderForCenterOfView;
                } else if (newView.x<leftBorderForCenterOfView){
                    newView.x = leftBorderForCenterOfView;
                }
                self.secondView.center = newView;
                NSLog(@"view: %f", view.origin.x);
                [pan setTranslation:CGPointMake(0, 0) inView:self.secondView];
            break;
        }
        case UIGestureRecognizerStateEnded:{
            CGFloat centerOfMovement = -30;
            CGFloat magicCoefficient = 4;
            if ((view.origin.x+velocity.x/magicCoefficient<=centerOfMovement)&&(view.origin.x>=leftBorderOfView)) {
                [self moveBack:view.origin.x];
            } else if ((view.origin.x+velocity.x/magicCoefficient>centerOfMovement)&&(view.origin.x<=0)){
                [self moveRight:view.origin.x];
            }
        }
        default:
            break;
    }

    
}


@end
