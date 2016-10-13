//
//  AnswersViewController.m
//  ChemWhiz
//
//  Created by Anant Jain on 3/8/14.
//  Copyright (c) 2014 Anant Jain. All rights reserved.
//

#import "AnswersViewController.h"

@interface AnswersViewController ()

- (void)setUpTheme;

@end

@implementation AnswersViewController
{
    double grams;
    double moles;
    double liters;
    double particles;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self setUpTheme];
    
    [_answersTable reloadData];
}

- (void)setUpTheme
{
    switch ([[NSUserDefaults standardUserDefaults] integerForKey:@"Color Theme"])
    {
        case 0:
            [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
            self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
            self.navigationController.navigationBar.barTintColor = nil;
            self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:0.6 green:0.6 blue:0.6 alpha:1.0];
            self.navigationController.navigationBar.titleTextAttributes = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], NSForegroundColorAttributeName, nil];
            
            self.tabBarController.tabBar.tintColor = [UIColor whiteColor];
            self.tabBarController.tabBar.barTintColor = [UIColor colorWithRed:0.3 green:0.3 blue:0.3 alpha:1.0];
            self.view.backgroundColor = [UIColor colorWithRed:0.6 green:0.6 blue:0.6 alpha:1.0];
            
            _answersTable.separatorColor = [UIColor lightGrayColor];
            break;
        case 1:
            [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
            self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:0 green:0.478431 blue:1 alpha:1.0];
            self.navigationController.navigationBar.barTintColor = nil;
            self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:0.85 green:0.85 blue:0.85 alpha:1.0];
            self.navigationController.navigationBar.titleTextAttributes = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor blackColor], NSForegroundColorAttributeName, nil];
            
            self.tabBarController.tabBar.tintColor = [UIColor colorWithRed:0 green:0.478431 blue:1 alpha:1.0];
            self.tabBarController.tabBar.barTintColor = [UIColor colorWithRed:0.7 green:0.7 blue:0.7 alpha:1.0];
            self.view.backgroundColor = [UIColor colorWithRed:0.85 green:0.85 blue:0.85 alpha:1.0];
            
            _answersTable.separatorColor = [UIColor grayColor];
            break;
        case 2:
            [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
            self.navigationController.navigationBar.tintColor = [UIColor darkGrayColor];
            self.navigationController.navigationBar.barTintColor = nil;
            self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:128/255.0 green:195/255.0 blue:90/255.0 alpha:1.0];
            self.navigationController.navigationBar.titleTextAttributes = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor blackColor], NSForegroundColorAttributeName, nil];
            
            self.tabBarController.tabBar.tintColor = [UIColor darkGrayColor];
            self.tabBarController.tabBar.barTintColor = [UIColor colorWithRed:109/255.0 green:200/255.0 blue:68/255.0 alpha:1.0];
            self.view.backgroundColor = [UIColor colorWithRed:128/255.0 green:195/255.0 blue:90/255.0 alpha:1.0];
            
            _answersTable.separatorColor = [UIColor grayColor];
            break;
        case 3:
            [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
            self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
            self.navigationController.navigationBar.barTintColor = nil;
            self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:59/255.0 green:163/255.0 blue:225/255.0 alpha:1.0];
            self.navigationController.navigationBar.titleTextAttributes = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], NSForegroundColorAttributeName, nil];
            
            self.tabBarController.tabBar.tintColor = [UIColor whiteColor];
            self.tabBarController.tabBar.barTintColor = [UIColor colorWithRed:62/255.0 green:165/255.0 blue:250/255.0 alpha:1.0];
            self.view.backgroundColor = [UIColor colorWithRed:59/255.0 green:163/255.0 blue:225/255.0 alpha:1.0];
            
            _answersTable.separatorColor = [UIColor whiteColor];
            break;
        case 4:
            [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
            self.navigationController.navigationBar.tintColor = [UIColor darkGrayColor];
            self.navigationController.navigationBar.barTintColor = nil;
            self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:220/255.0 green:209/255.0 blue:91/255.0 alpha:1.0];
            self.navigationController.navigationBar.titleTextAttributes = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor blackColor], NSForegroundColorAttributeName, nil];
            
            self.tabBarController.tabBar.tintColor = [UIColor darkGrayColor];
            self.tabBarController.tabBar.barTintColor = [UIColor colorWithRed:219/255.0 green:207/255.0 blue:76/255.0 alpha:1.0];
            self.view.backgroundColor = [UIColor colorWithRed:220/255.0 green:209/255.0 blue:91/255.0 alpha:1.0];
            
            _answersTable.separatorColor = [UIColor grayColor];
            break;
        case 5:
            [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
            self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
            self.navigationController.navigationBar.barTintColor = nil;
            self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:220/255.0 green:97/255.0 blue:101/255.0 alpha:1.0];
            self.navigationController.navigationBar.titleTextAttributes = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], NSForegroundColorAttributeName, nil];
            
            self.tabBarController.tabBar.tintColor = [UIColor whiteColor];
            self.tabBarController.tabBar.barTintColor = [UIColor colorWithRed:234/255.0 green:75/255.0 blue:83/255.0 alpha:1.0];
            self.view.backgroundColor = [UIColor colorWithRed:220/255.0 green:97/255.0 blue:101/255.0 alpha:1.0];
            
            _answersTable.separatorColor = [UIColor whiteColor];
            break;
        default:
            break;
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _answersTable.dataSource = self;
    _answersTable.delegate = self;
    _answersTable.backgroundColor = [UIColor clearColor];
    
    switch (_unit)
    {
        case unitTypeGrams:
            grams = _inputQuantity;
            moles = grams / _molarMassOfChemical;
            particles = moles * 6.02e23;
            liters = moles * 22.4;
            break;
        case unitTypeParticles:
            particles = _inputQuantity;
            moles = particles / (6.02e23);
            liters = moles * 22.4;
            grams = moles * _molarMassOfChemical;
            break;
        case unitTypeMoles:
            moles = _inputQuantity;
            grams = moles * _molarMassOfChemical;
            particles = moles * 6.02e23;
            liters = moles * 22.4;
            break;
        case unitTypeLiters:
            liters = _inputQuantity;
            moles = liters / 22.4;
            grams = moles * _molarMassOfChemical;
            particles = moles * 6.02e23;
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

- (BOOL)tableView:(UITableView *)tableView shouldShowMenuForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return (indexPath.section == 1);
}

- (BOOL)tableView:(UITableView *)tableView canPerformAction:(SEL)action forRowAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender
{
    return (action == @selector(copy:));
}

- (void)tableView:(UITableView *)tableView performAction:(SEL)action forRowAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender
{
    UITableViewCell *copyCell = [self tableView:tableView cellForRowAtIndexPath:indexPath];
    [UIPasteboard generalPasteboard].string = copyCell.textLabel.text;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section) {
        case 0:
            return 2;
            break;
        case 1:
            return 4;
            break;
        default:
            return 0;
            break;
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    switch (section)
    {
        case 0:
            return @"Input";
            break;
        case 1:
            return @"Conversions";
            break;
        default:
            return nil;
            break;
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section
{
    switch (section)
    {
        case 1:
            return @"Tap and hold down to copy. Remember to round to the correct number of significant figures.";
            break;
        default:
            return nil;
            break;
    }
}

- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section
{
    UITableViewHeaderFooterView *header = (UITableViewHeaderFooterView *)view;
    switch ([[NSUserDefaults standardUserDefaults] integerForKey:@"Color Theme"])
    {
        case 0:
        case 3:
        case 5:
            [header.textLabel setTextColor:[UIColor whiteColor]];
            break;
        case 1:
            [header.textLabel setTextColor:[UIColor blackColor]];
            break;
        case 2:
        case 4:
            [header.textLabel setTextColor:[UIColor darkGrayColor]];
            break;
        default:
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
            [footer.textLabel setTextColor:[UIColor whiteColor]];
            break;
        case 1:
            [footer.textLabel setTextColor:[UIColor blackColor]];
            break;
        case 2:
        case 4:
            [footer.textLabel setTextColor:[UIColor darkGrayColor]];
            break;
        default:
            break;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:nil];
    
    switch (indexPath.section)
    {
        case 0:
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            switch (indexPath.row)
            {
                case 0:
                    cell.textLabel.text = [NSString stringWithFormat:@"%lf", _inputQuantity];
                    switch (_unit)
                    {
                        case unitTypeGrams:
                            cell.detailTextLabel.text = @"grams";
                            break;
                        case unitTypeLiters:
                            cell.detailTextLabel.text = @"liters";
                            break;
                        case unitTypeMoles:
                            cell.detailTextLabel.text = @"moles";
                            break;
                        case unitTypeParticles:
                            cell.detailTextLabel.text = @"particles";
                            break;
                        default:
                            break;
                    }
                    break;
                case 1:
                    cell.textLabel.text = self.formulaName;
                    cell.detailTextLabel.text = [NSString stringWithFormat:@"%0.2lf g/mol", self.molarMassOfChemical];
                    break;
                default:
                    break;
            }
            break;
        case 1:
        {
            cell.selectionStyle = UITableViewCellSelectionStyleDefault;
            NSNumberFormatter *formatter = [NSNumberFormatter new];
            formatter.maximumFractionDigits = 5;
            
            switch (indexPath.row)
            {
                case 0:
                    cell.textLabel.text = [formatter stringFromNumber:[NSNumber numberWithDouble:moles]];
                    cell.detailTextLabel.text = @"moles";
                    break;
                case 1:
                    cell.textLabel.text = [formatter stringFromNumber:[NSNumber numberWithDouble:grams]];
                    cell.detailTextLabel.text = @"grams";
                    break;
                case 2:
                    cell.textLabel.text = [formatter stringFromNumber:[NSNumber numberWithDouble:liters]];
                    cell.detailTextLabel.text = @"liters (at STP)";
                    break;
                case 3:
                    cell.textLabel.text = [NSString stringWithFormat:@"%g", particles];
                    cell.detailTextLabel.text = @"particles";
                    break;
                default:
                    break;
            }
        }
        default:
            break;
    }
    
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
            cell.textLabel.textColor = [UIColor blackColor];
            cell.detailTextLabel.textColor = [UIColor blackColor];
            break;
        case 2:
        case 4:
            cell.textLabel.textColor = [UIColor darkGrayColor];
            cell.detailTextLabel.textColor = [UIColor darkGrayColor];
            break;
        default:
            break;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

- (IBAction)exit:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
