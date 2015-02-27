//
//  ViewController.m
//  splitView
//
//  Created by Артур Сагидулин on 26.02.15.
//  Copyright (c) 2015 Артур Сагидулин. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIView *slider;
@property (strong, nonatomic) IBOutlet UIPanGestureRecognizer *myPan;
@property (weak, nonatomic) IBOutlet UIView *secondView;
@property (weak, nonatomic) IBOutlet UIButton *myButton;


@end

@implementation ViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.myButton setTitle:@"show" forState:UIControlStateNormal];
    CGRect rect = self.slider.frame;
    NSLog(@"width: %f height: %f", rect.size.width, rect.size.height);
    self.slider.frame = CGRectMake(-60, 28, 60, 568);
    NSLog(@"%f", self.slider.frame.size.width);
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)clicked:(id)sender {
    UIButton *button = sender;
    if ([button.titleLabel.text isEqualToString:@"hide"]) {
        [self.myButton setTitle:@"show" forState:UIControlStateNormal];
        [self moveBack];
    } else if ([button.titleLabel.text isEqualToString:@"show"]){
        [self.myButton setTitle:@"hide" forState:UIControlStateNormal];
        [self moveRight];
    }
}
-(void)moveRight{
    [UIView animateWithDuration:0.3 animations:^{
        self.slider.frame = CGRectMake(0, 28, 60, 568);
        CGRect rect = self.secondView.frame;
        self.secondView.frame = CGRectMake(rect.origin.x+60,rect.origin.y, rect.size.width, rect.size.height);
    }];
    //NSLog(@"slider center: %f", self.slider.center.x);
    //NSLog(@"view center: %f", self.secondView.center.x);
}
-(void)moveBack{
    [UIView animateWithDuration:0.3 animations:^{
        self.slider.frame = CGRectMake(-60, 28, 60, 568);
        CGRect rect = self.secondView.frame;
        self.secondView.frame = CGRectMake(rect.origin.x-60,rect.origin.y, rect.size.width, rect.size.height);
    }];
    //NSLog(@"slider center: %f", self.slider.center.x);
    //NSLog(@"view center: %f", self.secondView.center.x);
}

-(IBAction)movement:(UIPanGestureRecognizer *)pan{
    CGPoint translatedPoint = [pan translationInView:self.secondView];
    //CGPoint velocity = [pan velocityInView:[pan view]];
    //NSLog(@"velocity x: %f", velocity.x);
    //NSLog(@"translated x: %f", translatedPoint.x);
    
    switch (pan.state) {
        case UIGestureRecognizerStateBegan:{
            //NSLog(@"x: %f", self.secondView.frame.origin.x);
            break;
        }
        case UIGestureRecognizerStateChanged:{
            //NSLog(@"position x: %f", self.slider.frame.origin.x);
            if ((self.slider.frame.origin.x>=-60)&&(self.slider.frame.origin.x <=0) && (self.secondView.frame.origin.x>=27.5)) {
                if (translatedPoint.x>60) {
                    translatedPoint.x = 60;
                }
                if (translatedPoint.x<-60) {
                    translatedPoint.x = -60;
                }
                CGPoint p = CGPointMake(self.secondView.center.x + translatedPoint.x, self.secondView.center.y);
                CGPoint p2 = CGPointMake(self.slider.center.x+translatedPoint.x, self.slider.center.y);
                if ((p.x < -30)&&(p2.x<160)) {
                    p.x = -30;
                    p2.x = 160;
                }
                self.secondView.center = p;
                self.slider.center = p2;
                [pan setTranslation:CGPointMake(0, 0) inView:self.secondView];
            }
            break;
        }
        case UIGestureRecognizerStateEnded:{
            CGRect slider = self.slider.frame;
            CGRect view = self.secondView.frame;
            if (slider.origin.x<-60 || view.origin.x<27.5) {
                CGFloat f = -60;
                CGFloat f2 = 27.5;
                self.slider.frame = CGRectMake(f, slider.origin.y, slider.size.width, slider.size.height);
                self.secondView.frame = CGRectMake(f2, view.origin.y, view.size.width, view.size.height);
                [self.myButton setTitle:@"show" forState:UIControlStateNormal];
                
            } else if (slider.origin.x>0 || view.origin.x>87.5) {
                CGFloat f = 0;
                CGFloat f2 = 87.5;
                self.slider.frame = CGRectMake(f, slider.origin.y, slider.size.width, slider.size.height);
                self.secondView.frame = CGRectMake(f2, view.origin.y, view.size.width, view.size.height);
                [self.myButton setTitle:@"hide" forState:UIControlStateNormal];
                
            } else if ((slider.origin.x<=-30)&&(slider.origin.x>=-60)) {
                [UIView animateWithDuration:0.3 animations:^{
                    self.slider.frame = CGRectMake(-60, 28, 60, 568);
                    CGRect rect = self.secondView.frame;
                    self.secondView.frame = CGRectMake(rect.origin.x+slider.origin.x,rect.origin.y, rect.size.width, rect.size.height);
                }];
            } else if ((slider.origin.x>-30)&&(slider.origin.x<=0)){
                [UIView animateWithDuration:0.3 animations:^{
                    self.slider.frame = CGRectMake(0, 28, 60, 568);
                    CGRect rect = self.secondView.frame;
                    self.secondView.frame = CGRectMake(rect.origin.x-slider.origin.x,rect.origin.y, rect.size.width, rect.size.height);
                }];
            }
            break;
        }
        default:
            break;
    }

    
}


@end
