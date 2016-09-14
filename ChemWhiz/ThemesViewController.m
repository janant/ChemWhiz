//
//  ThemesViewController.m
//  ChemWhiz
//
//  Created by Anant Jain on 4/16/14.
//  Copyright (c) 2014 Anant Jain. All rights reserved.
//

#import "ThemesViewController.h"

@interface ThemesViewController ()

- (void)setUpTheme;

@end

@implementation ThemesViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self setUpTheme];
}

- (void)setUpTheme
{
    switch (_currentTheme)
    {
        case 0:
            _backgroundImageView.image = [UIImage imageNamed:@"Black Gradient Background.png"];
            _themesTableView.separatorColor = [UIColor lightGrayColor];
            break;
        case 1:
            _backgroundImageView.image = [UIImage imageNamed:@"White Gradient Background.png"];
            _themesTableView.separatorColor = [UIColor grayColor];
            break;
        case 2:
            _backgroundImageView.image = [UIImage imageNamed:@"Green Gradient Background.png"];
            _themesTableView.separatorColor = [UIColor grayColor];
            break;
        case 3:
            _backgroundImageView.image = [UIImage imageNamed:@"Blue Gradient Background.png"];
            _themesTableView.separatorColor = [UIColor whiteColor];
            break;
        case 4:
            _backgroundImageView.image = [UIImage imageNamed:@"Yellow Gradient Background.png"];
            _themesTableView.separatorColor = [UIColor grayColor];
            break;
        case 5:
            _backgroundImageView.image = [UIImage imageNamed:@"Red Gradient Background.png"];
            _themesTableView.separatorColor = [UIColor whiteColor];
            break;
        
        default:
            break;
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _themesTableView.dataSource = self;
    _themesTableView.delegate = self;
    _themesTableView.backgroundColor = [UIColor clearColor];
    
    _themesTableView.contentInset = UIEdgeInsetsMake(self.navigationController.navigationBar.frame.size.height + [UIApplication sharedApplication].statusBarFrame.size.height, 0, self.tabBarController.tabBar.frame.size.height, 0);
    _themesTableView.scrollIndicatorInsets = UIEdgeInsetsMake(self.navigationController.navigationBar.frame.size.height + [UIApplication sharedApplication].statusBarFrame.size.height, 0, self.tabBarController.tabBar.frame.size.height, 0);
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section)
    {
        case 0:
            return 6;
            break;
        default:
            return 0;
            break;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Theme Cell"];
    
    switch (indexPath.row)
    {
        case 0:
            ((UILabel *)[cell viewWithTag:2]).text = @"Black";
            ((UIImageView *)[cell viewWithTag:1]).image = [UIImage imageNamed:@"Black Icon.png"];
            break;
        case 1:
            ((UILabel *)[cell viewWithTag:2]).text = @"White";
            ((UIImageView *)[cell viewWithTag:1]).image = [UIImage imageNamed:@"White Icon.png"];
            break;
        case 2:
            ((UILabel *)[cell viewWithTag:2]).text = @"Green";
            ((UIImageView *)[cell viewWithTag:1]).image = [UIImage imageNamed:@"Green Icon.png"];
            break;
        case 3:
            ((UILabel *)[cell viewWithTag:2]).text = @"Blue";
            ((UIImageView *)[cell viewWithTag:1]).image = [UIImage imageNamed:@"Blue Icon.png"];
            break;
        case 4:
            ((UILabel *)[cell viewWithTag:2]).text = @"Yellow";
            ((UIImageView *)[cell viewWithTag:1]).image = [UIImage imageNamed:@"Yellow Icon.png"];
            break;
        case 5:
            ((UILabel *)[cell viewWithTag:2]).text = @"Red";
            ((UIImageView *)[cell viewWithTag:1]).image = [UIImage imageNamed:@"Red Icon.png"];
            break;
        default:
            break;
    }
    
    cell.backgroundColor = [UIColor clearColor];
    
    switch (_currentTheme)
    {
        case 0:
        case 3:
        case 5:
            ((UILabel *)[cell viewWithTag:2]).textColor = [UIColor whiteColor];
            break;
        case 1:
        case 2:
        case 4:
            ((UILabel *)[cell viewWithTag:2]).textColor = [UIColor blackColor];
            break;
        default:
            break;
    }
    
    if (indexPath.row == _currentTheme)
    {
        switch (_currentTheme)
        {
            case 0:
            case 3:
            case 5:
                ((UIImageView *)[cell viewWithTag:3]).image = [UIImage imageNamed:@"White Checkmark.png"];
                break;
            case 1:
                ((UIImageView *)[cell viewWithTag:3]).image = [UIImage imageNamed:@"Blue Checkmark.png"];
                break;
            case 2:
            case 4:
                ((UIImageView *)[cell viewWithTag:3]).image = [UIImage imageNamed:@"Black Checkmark.png"];
                break;
            default:
                break;
        }
    }
    else
    {
        ((UIImageView *)[cell viewWithTag:3]).image = nil;
    }
    
    
    ((UIImageView *)[cell viewWithTag:1]).layer.cornerRadius = 3;
    ((UIImageView *)[cell viewWithTag:1]).layer.masksToBounds = YES;
    ((UIImageView *)[cell viewWithTag:1]).layer.borderColor = [UIColor blackColor].CGColor;
    ((UIImageView *)[cell viewWithTag:1]).layer.borderWidth = 0.6;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [[NSUserDefaults standardUserDefaults] setInteger:indexPath.row forKey:@"Color Theme"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    _currentTheme = indexPath.row;
    
    switch (indexPath.row)
    {
        case 0:
        {
            [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
            self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
            self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:1.0];
            self.navigationController.navigationBar.titleTextAttributes = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], NSForegroundColorAttributeName, nil];
            
            self.tabBarController.tabBar.tintColor = [UIColor whiteColor];
            self.tabBarController.tabBar.barTintColor = [UIColor colorWithRed:0.3 green:0.3 blue:0.3 alpha:1.0];
            
            [UIView transitionWithView:_backgroundImageView duration:0.25 options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
                _backgroundImageView.image = [UIImage imageNamed:@"Black Gradient Background.png"];
            } completion:nil];
            
            _themesTableView.separatorColor = [UIColor lightGrayColor];
            break;
        }
        case 1:
        {
            [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
            self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:0 green:0.478431 blue:1 alpha:1.0];
            self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:0.85 green:0.85 blue:0.85 alpha:1.0];
            self.navigationController.navigationBar.titleTextAttributes = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor blackColor], NSForegroundColorAttributeName, nil];
            
            self.tabBarController.tabBar.tintColor = [UIColor colorWithRed:0 green:0.478431 blue:1 alpha:1.0];
            self.tabBarController.tabBar.barTintColor = [UIColor colorWithRed:0.7 green:0.7 blue:0.7 alpha:1.0];
            
            [UIView transitionWithView:_backgroundImageView duration:0.25 options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
                _backgroundImageView.image = [UIImage imageNamed:@"White Gradient Background.png"];
            } completion:nil];
            
            _themesTableView.separatorColor = [UIColor grayColor];
            break;
        }
        case 2:
        {
            [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
            self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:120/255.0 green:239/255.0 blue:99/255.0 alpha:1.0];
            self.navigationController.navigationBar.tintColor = [UIColor darkGrayColor];
            self.navigationController.navigationBar.titleTextAttributes = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor blackColor], NSForegroundColorAttributeName, nil];
            
            self.tabBarController.tabBar.tintColor = [UIColor darkGrayColor];
            self.tabBarController.tabBar.barTintColor = [UIColor colorWithRed:109/255.0 green:200/255.0 blue:68/255.0 alpha:1.0];
            
            [UIView transitionWithView:_backgroundImageView duration:0.25 options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
                _backgroundImageView.image = [UIImage imageNamed:@"Green Gradient Background.png"];
            } completion:nil];
            
            _themesTableView.separatorColor = [UIColor grayColor];
            break;
        }
        case 3:
        {
            [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
            self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
            self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:62/255.0 green:185/255.0 blue:255/255.0 alpha:1.0];
            self.navigationController.navigationBar.titleTextAttributes = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], NSForegroundColorAttributeName, nil];
            
            self.tabBarController.tabBar.tintColor = [UIColor whiteColor];
            self.tabBarController.tabBar.barTintColor = [UIColor colorWithRed:62/255.0 green:165/255.0 blue:250/255.0 alpha:1.0];
            
            [UIView transitionWithView:_backgroundImageView duration:0.25 options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
                _backgroundImageView.image = [UIImage imageNamed:@"Blue Gradient Background.png"];
            } completion:nil];
            
            _themesTableView.separatorColor = [UIColor whiteColor];
            break;
        }
        case 4:
        {
            [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
            self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:255/255.0 green:241/255.0 blue:89/255.0 alpha:1.0];
            self.navigationController.navigationBar.tintColor = [UIColor darkGrayColor];
            self.navigationController.navigationBar.titleTextAttributes = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor blackColor], NSForegroundColorAttributeName, nil];
            
            self.tabBarController.tabBar.tintColor = [UIColor darkGrayColor];
            self.tabBarController.tabBar.barTintColor = [UIColor colorWithRed:219/255.0 green:207/255.0 blue:76/255.0 alpha:1.0];
            
            [UIView transitionWithView:_backgroundImageView duration:0.25 options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
                _backgroundImageView.image = [UIImage imageNamed:@"Yellow Gradient Background.png"];
            } completion:nil];
            
            _themesTableView.separatorColor = [UIColor grayColor];
            break;
        }
        case 5:
        {
            [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
            self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
            self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:255/255.0 green:92/255.0 blue:95/255.0 alpha:1.0];
            self.navigationController.navigationBar.titleTextAttributes = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], NSForegroundColorAttributeName, nil];
            
            self.tabBarController.tabBar.tintColor = [UIColor whiteColor];
            self.tabBarController.tabBar.barTintColor = [UIColor colorWithRed:234/255.0 green:75/255.0 blue:83/255.0 alpha:1.0];
            
            [UIView transitionWithView:_backgroundImageView duration:0.25 options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
                _backgroundImageView.image = [UIImage imageNamed:@"Red Gradient Background.png"];
            } completion:nil];
            
            _themesTableView.separatorColor = [UIColor whiteColor];
            break;
        }
        default:
            break;
    }

    [_themesTableView reloadData];

    [_themesTableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
    [_themesTableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
