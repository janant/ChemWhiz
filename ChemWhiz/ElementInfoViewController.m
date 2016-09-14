//
//  ElementInfoViewController.m
//  ChemWhiz
//
//  Created by Anant Jain on 3/10/14.
//  Copyright (c) 2014 Anant Jain. All rights reserved.
//

#import "ElementInfoViewController.h"

@interface ElementInfoViewController ()

- (void)setUpTheme;

@end

@implementation ElementInfoViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self setUpTheme];
}

- (void)setUpTheme
{
    switch ([[NSUserDefaults standardUserDefaults] integerForKey:@"Color Theme"])
    {
        case 0:
            [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
            self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
            self.navigationController.navigationBar.barTintColor = nil;
            self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:1.0];
            self.navigationController.navigationBar.titleTextAttributes = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], NSForegroundColorAttributeName, nil];
            
            self.tabBarController.tabBar.tintColor = [UIColor whiteColor];
            self.tabBarController.tabBar.barTintColor = [UIColor colorWithRed:0.3 green:0.3 blue:0.3 alpha:1.0];
            self.backgroundImageView.image = [UIImage imageNamed:@"Black Gradient Background.png"];
            
            _symbolLabel.layer.borderColor = [UIColor whiteColor].CGColor;
            _symbolLabel.textColor = [UIColor whiteColor];
            _nameLabel.textColor = [UIColor whiteColor];
            _atomicNumberLabel.textColor = [UIColor whiteColor];
            _massLabel.textColor = [UIColor whiteColor];
            _atomicNumberIndicatorLabel.textColor = [UIColor whiteColor];
            _massIndicatorLabel.textColor = [UIColor whiteColor];
            _selectElementLabel.textColor = [UIColor whiteColor];
            
            break;
        case 1:
            [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
            self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:0 green:0.478431 blue:1 alpha:1.0];
            self.navigationController.navigationBar.barTintColor = nil;
            self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:0.85 green:0.85 blue:0.85 alpha:1.0];
            self.navigationController.navigationBar.titleTextAttributes = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor blackColor], NSForegroundColorAttributeName, nil];
            
            self.tabBarController.tabBar.tintColor = [UIColor colorWithRed:0 green:0.478431 blue:1 alpha:1.0];
            self.tabBarController.tabBar.barTintColor = [UIColor colorWithRed:0.7 green:0.7 blue:0.7 alpha:1.0];
            self.backgroundImageView.image = [UIImage imageNamed:@"White Gradient Background.png"];
            
            _symbolLabel.layer.borderColor = [UIColor blackColor].CGColor;
            _symbolLabel.textColor = [UIColor blackColor];
            _nameLabel.textColor = [UIColor blackColor];
            _atomicNumberLabel.textColor = [UIColor blackColor];
            _massLabel.textColor = [UIColor blackColor];
            _atomicNumberIndicatorLabel.textColor = [UIColor blackColor];
            _massIndicatorLabel.textColor = [UIColor blackColor];
            _selectElementLabel.textColor = [UIColor blackColor];
            
            break;
        case 2:
            [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
            self.navigationController.navigationBar.barTintColor = nil;
            self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:120/255.0 green:239/255.0 blue:99/255.0 alpha:1.0];
            self.navigationController.navigationBar.tintColor = [UIColor darkGrayColor];
            self.navigationController.navigationBar.titleTextAttributes = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor blackColor], NSForegroundColorAttributeName, nil];
            
            self.tabBarController.tabBar.tintColor = [UIColor darkGrayColor];
            self.tabBarController.tabBar.barTintColor = [UIColor colorWithRed:109/255.0 green:200/255.0 blue:68/255.0 alpha:1.0];
            _backgroundImageView.image = [UIImage imageNamed:@"Green Gradient Background.png"];
            
            _symbolLabel.layer.borderColor = [UIColor darkGrayColor].CGColor;
            _symbolLabel.textColor = [UIColor darkGrayColor];
            _nameLabel.textColor = [UIColor darkGrayColor];
            _atomicNumberLabel.textColor = [UIColor darkGrayColor];
            _massLabel.textColor = [UIColor darkGrayColor];
            _atomicNumberIndicatorLabel.textColor = [UIColor darkGrayColor];
            _massIndicatorLabel.textColor = [UIColor darkGrayColor];
            _selectElementLabel.textColor = [UIColor darkGrayColor];
            
            break;
        case 3:
            [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
            self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
            self.navigationController.navigationBar.barTintColor = nil;
            self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:62/255.0 green:185/255.0 blue:255/255.0 alpha:1.0];
            self.navigationController.navigationBar.titleTextAttributes = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], NSForegroundColorAttributeName, nil];
            
            self.tabBarController.tabBar.tintColor = [UIColor whiteColor];
            self.tabBarController.tabBar.barTintColor = [UIColor colorWithRed:62/255.0 green:165/255.0 blue:250/255.0 alpha:1.0];
            _backgroundImageView.image = [UIImage imageNamed:@"Blue Gradient Background.png"];
            
            _symbolLabel.layer.borderColor = [UIColor whiteColor].CGColor;
            _symbolLabel.textColor = [UIColor whiteColor];
            _nameLabel.textColor = [UIColor whiteColor];
            _atomicNumberLabel.textColor = [UIColor whiteColor];
            _massLabel.textColor = [UIColor whiteColor];
            _atomicNumberIndicatorLabel.textColor = [UIColor whiteColor];
            _massIndicatorLabel.textColor = [UIColor whiteColor];
            _selectElementLabel.textColor = [UIColor whiteColor];
            
            break;
        case 4:
            [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
            self.navigationController.navigationBar.barTintColor = nil;
            self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:255/255.0 green:241/255.0 blue:89/255.0 alpha:1.0];
            self.navigationController.navigationBar.tintColor = [UIColor darkGrayColor];
            self.navigationController.navigationBar.titleTextAttributes = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor blackColor], NSForegroundColorAttributeName, nil];
            
            self.tabBarController.tabBar.tintColor = [UIColor darkGrayColor];
            self.tabBarController.tabBar.barTintColor = [UIColor colorWithRed:219/255.0 green:207/255.0 blue:76/255.0 alpha:1.0];
            _backgroundImageView.image = [UIImage imageNamed:@"Yellow Gradient Background.png"];
            
            _symbolLabel.layer.borderColor = [UIColor darkGrayColor].CGColor;
            _symbolLabel.textColor = [UIColor darkGrayColor];
            _nameLabel.textColor = [UIColor darkGrayColor];
            _atomicNumberLabel.textColor = [UIColor darkGrayColor];
            _massLabel.textColor = [UIColor darkGrayColor];
            _atomicNumberIndicatorLabel.textColor = [UIColor darkGrayColor];
            _massIndicatorLabel.textColor = [UIColor darkGrayColor];
            _selectElementLabel.textColor = [UIColor darkGrayColor];
            
            break;
        case 5:
            [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
            self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
            self.navigationController.navigationBar.barTintColor = nil;
            self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:255/255.0 green:92/255.0 blue:95/255.0 alpha:1.0];
            self.navigationController.navigationBar.titleTextAttributes = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], NSForegroundColorAttributeName, nil];
            
            self.tabBarController.tabBar.tintColor = [UIColor whiteColor];
            self.tabBarController.tabBar.barTintColor = [UIColor colorWithRed:234/255.0 green:75/255.0 blue:83/255.0 alpha:1.0];
            _backgroundImageView.image = [UIImage imageNamed:@"Red Gradient Background.png"];
            
            _symbolLabel.layer.borderColor = [UIColor whiteColor].CGColor;
            _symbolLabel.textColor = [UIColor whiteColor];
            _nameLabel.textColor = [UIColor whiteColor];
            _atomicNumberLabel.textColor = [UIColor whiteColor];
            _massLabel.textColor = [UIColor whiteColor];
            _atomicNumberIndicatorLabel.textColor = [UIColor whiteColor];
            _massIndicatorLabel.textColor = [UIColor whiteColor];
            _selectElementLabel.textColor = [UIColor whiteColor];
            
            break;
        default:
            break;
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.symbolLabel.layer.borderColor = [UIColor whiteColor].CGColor;
    self.symbolLabel.layer.borderWidth = 1.5;
    self.symbolLabel.layer.cornerRadius = 5;
    
    self.symbolLabel.text = self.elementSymbol;
    self.nameLabel.text = self.elementName;
    self.atomicNumberLabel.text = self.atomicNumber;
    self.massLabel.text = [NSString stringWithFormat:@"%@ g/mol", self.atomicMass];
    
    if (_elementName) {
        _selectElementLabel.hidden = YES;
    }
    else {
        _mainStackView.hidden = YES;
    }
    
    [self setUpTheme];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)shareElement:(id)sender
{
    NSString *shareContents = [NSString stringWithFormat:@"%@ (%@):\nAtomic Number: %@\nMolar Mass: %@", self.elementName, self.elementSymbol, self.atomicNumber, self.atomicMass];
    UIActivityViewController *activityVC = [[UIActivityViewController alloc] initWithActivityItems:@[shareContents] applicationActivities:nil];
    [self presentViewController:activityVC animated:YES completion:nil];
}
@end
