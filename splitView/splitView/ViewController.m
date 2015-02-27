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
    CGRect rect = self.slider.frame;
    height = [UIScreen mainScreen].applicationFrame.size.height;
    self.slider.frame = CGRectMake(-60, 28, 60, height);
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)clicked:(id)sender {
    UIButton *button = sender;
    if ([button.titleLabel.text isEqualToString:@"hide"]) {
        [self.myButton setTitle:@"show" forState:UIControlStateNormal];
        [self moveBack:-60];
    } else if ([button.titleLabel.text isEqualToString:@"show"]){
        [self.myButton setTitle:@"hide" forState:UIControlStateNormal];
        [self moveRight:self.slider.frame.origin.x];
    }
}
-(void)moveRight:(CGFloat)sliderX{
    [UIView animateWithDuration:0.3 animations:^{
        self.slider.frame = CGRectMake(0, 28, 60, height);
        CGRect rect = self.secondView.frame;
        self.secondView.frame = CGRectMake(rect.origin.x-sliderX,rect.origin.y, rect.size.width, rect.size.height);
    }];
}
-(void)moveBack:(CGFloat)sliderX{
    [UIView animateWithDuration:0.3 animations:^{
        self.slider.frame = CGRectMake(-60, 28, 60, height);
        CGRect rect = self.secondView.frame;
        self.secondView.frame = CGRectMake(rect.origin.x+sliderX,rect.origin.y, rect.size.width, rect.size.height);
    }];
}

-(IBAction)movement:(UIPanGestureRecognizer *)pan{
    CGPoint translatedPoint = [pan translationInView:self.secondView];
    CGRect slider = self.slider.frame;
    CGRect view = self.secondView.frame;
    //CGPoint velocity = [pan velocityInView:[pan view]];
    
    switch (pan.state) {
        case UIGestureRecognizerStateBegan:{
            break;
        }
        case UIGestureRecognizerStateChanged:{
            if ((self.slider.frame.origin.x>=-60)&&(self.slider.frame.origin.x <=0) && (self.secondView.frame.origin.x>=27.5)) {
                CGPoint p = CGPointMake(self.secondView.center.x + translatedPoint.x, self.secondView.center.y);
                CGPoint p2 = CGPointMake(self.slider.center.x+translatedPoint.x, self.slider.center.y);
                NSLog(@"px: %f", p.x);
                if (p2.x>30 && p.x>247){
                    p2.x = 30;
                    p.x=247;
                }
                self.secondView.center = p;
                self.slider.center = p2;
                NSLog(@"view: %f", self.secondView.center.x);
                [pan setTranslation:CGPointMake(0, 0) inView:self.secondView];
            break;
            }
        }
        case UIGestureRecognizerStateEnded:{
            if (slider.origin.x<-60 || view.origin.x<27.5) {
                CGFloat f = -60;
                CGFloat f2 = 27.5;
                self.slider.frame = CGRectMake(f, slider.origin.y, slider.size.width, slider.size.height);
                self.secondView.frame = CGRectMake(f2, view.origin.y, view.size.width, view.size.height);
                [self.myButton setTitle:@"show" forState:UIControlStateNormal];
                
            } else if ((slider.origin.x<=-30)&&(slider.origin.x>=-60)) {
                [self moveBack:slider.origin.x];
            } else if ((slider.origin.x>-30)&&(slider.origin.x<=0)){
                [self moveRight:slider.origin.x];
            }
            break;
        }
        default:
            break;
    }

    
}


@end
