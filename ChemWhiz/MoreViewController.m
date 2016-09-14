//
//  MoreViewController.m
//  ChemWhiz
//
//  Created by Anant Jain on 3/10/14.
//  Copyright (c) 2014 Anant Jain. All rights reserved.
//

#import "MoreViewController.h"
#import "ThemesViewController.h"

@interface MoreViewController ()

- (void)changeColorTheme:(UISegmentedControl *)sender;

- (void)deselectCell:(NSNotification *)notification;

- (void)setUpTheme;

@end

@implementation MoreViewController

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"Show Themes"])
    {
        ThemesViewController *themesVC = (ThemesViewController *)segue.destinationViewController;
        themesVC.currentTheme = [[NSUserDefaults standardUserDefaults] integerForKey:@"Color Theme"];
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    
    NSIndexPath *selectedCellIndex = [_moreTableView indexPathForSelectedRow];
    
    [self setUpTheme];
    
    [_moreTableView reloadData];

    if (selectedCellIndex)
    {
        [_moreTableView selectRowAtIndexPath:selectedCellIndex animated:NO scrollPosition:UITableViewScrollPositionNone];
        [_moreTableView deselectRowAtIndexPath:selectedCellIndex animated:YES];
    }
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
            
            _moreTableView.separatorColor = [UIColor lightGrayColor];
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
            
            _moreTableView.separatorColor = [UIColor grayColor];
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
            
            _moreTableView.separatorColor = [UIColor grayColor];
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
            
            _moreTableView.separatorColor = [UIColor whiteColor];
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
            
            _moreTableView.separatorColor = [UIColor grayColor];
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
            
            _moreTableView.separatorColor = [UIColor whiteColor];
            break;
        default:
            break;
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _moreTableView.dataSource = self;
    _moreTableView.delegate = self;
    
    _moreTableView.backgroundColor = [UIColor clearColor];
    _moreTableView.contentInset = UIEdgeInsetsMake(self.navigationController.navigationBar.frame.size.height + [UIApplication sharedApplication].statusBarFrame.size.height, 0, self.tabBarController.tabBar.frame.size.height, 0);
    _moreTableView.scrollIndicatorInsets = UIEdgeInsetsMake(self.navigationController.navigationBar.frame.size.height + [UIApplication sharedApplication].statusBarFrame.size.height, 0, self.tabBarController.tabBar.frame.size.height, 0);
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(deselectCell:) name:@"Deselect URL cell" object:nil];
}

- (void)deselectCell:(NSNotification *)notification
{
    if (self.isViewLoaded && self.view.window)
    {
        NSIndexPath *selectedCellIndex = [_moreTableView indexPathForSelectedRow];
        if (selectedCellIndex)
        {
            [_moreTableView selectRowAtIndexPath:selectedCellIndex animated:NO scrollPosition:UITableViewScrollPositionNone];
            [_moreTableView deselectRowAtIndexPath:selectedCellIndex animated:YES];
        }
    }
}

- (void)changeColorTheme:(UISegmentedControl *)sender
{
    if (sender == _colorThemeControl)
    {
        switch (_colorThemeControl.selectedSegmentIndex)
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
                
                _colorThemeControl.tintColor = [UIColor whiteColor];
                
                _moreTableView.separatorColor = [UIColor lightGrayColor];
                [[NSUserDefaults standardUserDefaults] setInteger:0 forKey:@"Color Theme"];
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
                
                _colorThemeControl.tintColor = [UIColor colorWithRed:0 green:0.478431 blue:1 alpha:1.0];
                
                _moreTableView.separatorColor = [UIColor grayColor];
                [[NSUserDefaults standardUserDefaults] setInteger:1 forKey:@"Color Theme"];
                break;
            }
            default:
                break;
        }
        
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        [_moreTableView reloadData];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section)
    {
        case 0:
            [self performSegueWithIdentifier:@"Show Themes" sender:nil];
            break;
        case 1:
            [self performSegueWithIdentifier:@"Show About" sender:nil];
            break;
        case 2:
            [self performSegueWithIdentifier:@"Show Guidelines" sender:nil];
            break;
        case 3:
            switch (indexPath.row)
            {
                case 0:
                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://trovesite.com/aakashadesara/"]];
                    break;
                case 1:
                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://itunes.apple.com/us/app/chemwhiz/id839352831?mt=8"]];
                    break;
                default:
                    break;
            }
            break;
        default:
            break;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section)
    {
        case 0:
            return 1;
            break;
        case 1:
            return 1;
            break;
        case 2:
            return 1;
            break;
        case 3:
            return 2;
            break;
        default:
            return 0;
            break;
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section
{
    switch (section)
    {
        case 3:
            return @"Links will open in an external app.";
            break;
        default:
            return nil;
            break;
    }
}

- (void)tableView:(UITableView *)tableView willDisplayFooterView:(UIView *)view forSection:(NSInteger)section
{
    UITableViewHeaderFooterView *footer = (UITableViewHeaderFooterView *)view;
    
    switch ([[NSUserDefaults standardUserDefaults] integerForKey:@"Color Theme"])
    {
        case 0:
        case 3:
        case 5:
            footer.textLabel.textColor = [UIColor whiteColor];
            break;
        case 1:
        case 2:
        case 4:
            footer.textLabel.textColor = [UIColor blackColor];
            break;
        default:
            break;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    
    switch (indexPath.section)
    {
        case 0:
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:nil];
            cell.textLabel.text = @"Theme";
            switch ([[NSUserDefaults standardUserDefaults] integerForKey:@"Color Theme"])
            {
                case 0:
                    cell.detailTextLabel.text = @"Black";
                    break;
                case 1:
                    cell.detailTextLabel.text = @"White";
                    break;
                case 2:
                    cell.detailTextLabel.text = @"Green";
                    break;
                case 3:
                    cell.detailTextLabel.text = @"Blue";
                    break;
                case 4:
                    cell.detailTextLabel.text = @"Yellow";
                    break;
                case 5:
                    cell.detailTextLabel.text = @"Red";
                    break;
                default:
                    break;
            }
            break;
        case 1:
            cell.textLabel.text = @"About ChemWhiz";
            break;
        case 2:
            cell.textLabel.text = @"Formatting Guidelines";
            break;
        case 3:
            switch (indexPath.row)
            {
                case 0:
                    cell.textLabel.text = @"Visit our site";
                    break;
                case 1:
                    cell.textLabel.text = @"Rate ChemWhiz";
                    break;
                default:
                    break;
            }
            break;
        default:
            break;
    }
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.backgroundColor = [UIColor clearColor];
    
    switch ([[NSUserDefaults standardUserDefaults] integerForKey:@"Color Theme"])
    {
        case 0:
        case 3:
        case 5:
            cell.textLabel.textColor = [UIColor whiteColor];
            cell.detailTextLabel.textColor = [UIColor whiteColor];
            break;
        case 1:
        case 2:
        case 4:
            cell.textLabel.textColor = [UIColor blackColor];
            cell.detailTextLabel.textColor = [UIColor blackColor];
            break;
    }
    
    return cell;
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
