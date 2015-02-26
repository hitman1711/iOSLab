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
    [UIView animateWithDuration:0.5 animations:^{
        self.slider.frame = CGRectMake(0, 28, 60, 568);
        CGRect rect = self.secondView.frame;
        self.secondView.frame = CGRectMake(rect.origin.x+60,rect.origin.y, rect.size.width, rect.size.height);
    }];
}
-(void)moveBack{
    [UIView animateWithDuration:0.3 animations:^{
        self.slider.frame = CGRectMake(-60, 28, 60, 568);
        CGRect rect = self.secondView.frame;
        self.secondView.frame = CGRectMake(rect.origin.x-60,rect.origin.y, rect.size.width, rect.size.height);
    }];
}
-(IBAction)movement:(UIPanGestureRecognizer *)pan{
    CGPoint translatedPoint = [pan translationInView:self.secondView];
    CGPoint velocity = [pan velocityInView:[pan view]];
    NSLog(@"velocity x: %f", velocity.x);
    NSLog(@"translated x: %f", translatedPoint.x);
   
    if (pan.state == UIGestureRecognizerStateBegan) {
            }
    if (pan.state == UIGestureRecognizerStateChanged) {
        NSLog(@"position x: %f", self.slider.frame.origin.x);
        if ((self.slider.frame.origin.x>=-60)&&(self.slider.frame.origin.x <=0)) {
            self.secondView.center = CGPointMake(self.secondView.center.x + translatedPoint.x, self.secondView.center.y);
            self.slider.center = CGPointMake(self.slider.center.x+translatedPoint.x, self.slider.center.y);
            [pan setTranslation:CGPointMake(0, 0) inView:self.secondView];
        }
    }
        if (pan.state == UIGestureRecognizerStateEnded) {
            CGPoint position = self.slider.frame.origin;
            if (position.x<-60) {
                CGFloat f = -60;
                self.slider.frame = CGRectMake(f, self.slider.frame.origin.y, self.slider.frame.size.width, self.slider.frame.size.height);
                [self.myButton setTitle:@"show" forState:UIControlStateNormal];
                NSLog(@"%@", @"Returning to -60");
                NSLog(@"position x: %f", self.slider.frame.origin.x);
            }
            if (position.x>0) {
                CGFloat f = 0;
                self.slider.frame = CGRectMake(f, self.slider.frame.origin.y, self.slider.frame.size.width, self.slider.frame.size.height);
                [self.myButton setTitle:@"hide" forState:UIControlStateNormal];
                NSLog(@"%@", @"Returning to 0");
                NSLog(@"position x: %f", self.slider.frame.origin.x);
            }
            
    }

    
}


@end
