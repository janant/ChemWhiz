//
//  AboutViewController.m
//  ChemWhiz
//
//  Created by Anant Jain on 3/9/14.
//  Copyright (c) 2014 Anant Jain. All rights reserved.
//

#import "AboutViewController.h"

@interface AboutViewController ()

@end

@implementation AboutViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    switch ([[NSUserDefaults standardUserDefaults] integerForKey:@"Color Theme"])
    {
        case 0:
            self.backgroundImageView.image = [UIImage imageNamed:@"Black Gradient Background.png"];
            _textView.textColor = [UIColor whiteColor];
            break;
        case 1:
            self.backgroundImageView.image = [UIImage imageNamed:@"White Gradient Background.png"];
            _textView.textColor = [UIColor blackColor];
            break;
        case 2:
            self.backgroundImageView.image = [UIImage imageNamed:@"Green Gradient Background.png"];
            _textView.textColor = [UIColor blackColor];
            break;
        case 3:
            self.backgroundImageView.image = [UIImage imageNamed:@"Blue Gradient Background.png"];
            _textView.textColor = [UIColor whiteColor];
            break;
        case 4:
            self.backgroundImageView.image = [UIImage imageNamed:@"Yellow Gradient Background.png"];
            _textView.textColor = [UIColor blackColor];
            break;
        case 5:
            self.backgroundImageView.image = [UIImage imageNamed:@"Red Gradient Background.png"];
            _textView.textColor = [UIColor whiteColor];
            break;
        default:
            break;
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
