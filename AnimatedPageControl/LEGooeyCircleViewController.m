//
//  LEGooeyCircleViewController.m
//  AnimatedPageControl
//
//  Created by 陈记权 on 7/5/16.
//  Copyright © 2016 LeEco. All rights reserved.
//

#import "LEGooeyCircleViewController.h"
#import "LEGooerView.h"

@interface LEGooeyCircleViewController ()

@property (weak, nonatomic) IBOutlet LEGooerView *gooerView;

@property (weak, nonatomic) IBOutlet UISlider *progressSlider;
@property (weak, nonatomic) IBOutlet UILabel *displayLabel;

@end

@implementation LEGooeyCircleViewController

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    self.progressSlider.value = self.gooerView.circleGooerLayer.progress;
}

- (IBAction)slideValueChanged:(id)sender
{
    UISlider *slide = (UISlider *)sender;
    self.gooerView.circleGooerLayer.progress = slide.value;
    self.displayLabel.text = [NSString stringWithFormat:@"P:%@", @(slide.value)];
}
@end
