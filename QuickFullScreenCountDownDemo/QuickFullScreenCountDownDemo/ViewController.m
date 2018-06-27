//
//  ViewController.m
//  QuickFullScreenCountDownDemo
//
//  Created by pcjbird on 2018/6/27.
//  Copyright © 2018年 Zero Status. All rights reserved.
//

#import "ViewController.h"
#import <QuickFullScreenCountDown/QuickFullScreenCountDown.h>
#import <Wonderful/UIColor+Wonderful.h>


@interface ViewController ()

@property(nonatomic, strong) NSArray* colors;
@property (weak, nonatomic) IBOutlet UIButton *btnStart;
- (IBAction)OnStart:(id)sender;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.colors = @[Wonderful_RedColor1, Wonderful_RedColor2, Wonderful_CyanColor1, Wonderful_PinkColor2,Wonderful_RedColor5];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)OnStart:(id)sender {
    self.btnStart.enabled = NO;
    __weak typeof(self) weakSelf = self;
    [QuickFullScreenCountDown setContinueWithUIBackgroundModes:NO];
    [QuickFullScreenCountDown playWithNumber:3 endTitle:@"Go!" success:^(QuickFullScreenCountDown *countdown) {
        weakSelf.btnStart.enabled = YES;
        NSInteger i = random()%5;
        weakSelf.view.backgroundColor = [weakSelf.colors objectAtIndex:i];
    }];
}

-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}
@end
