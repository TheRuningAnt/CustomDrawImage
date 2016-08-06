//
//  ViewController.m
//  CustomDrawImage
//
//  Created by 赵广亮 on 16/8/6.
//  Copyright © 2016年 zhaoguangliang. All rights reserved.
//

#import "ViewController.h"
#import "CustomView.h"
@interface ViewController ()
@property (weak, nonatomic) IBOutlet CustomView *customView;
@property (strong,nonatomic)NSArray *colors;

@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.colors = [NSArray arrayWithObjects:[UIColor redColor],[UIColor  greenColor],[UIColor blueColor],[UIColor yellowColor],[UIColor purpleColor],[UIColor whiteColor],[UIColor blackColor], nil];
}
- (IBAction)colorChange:(id)sender {
    self.customView.color = self.colors[((UISegmentedControl*)sender).selectedSegmentIndex];
}
- (IBAction)shapeChange:(id)sender {
    self.customView.shape = (ShapeType)((UISegmentedControl*)sender).selectedSegmentIndex;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
