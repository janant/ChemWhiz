//
//  ElementsViewController.m
//  ChemWhiz
//
//  Created by Anant Jain on 3/14/14.
//  Copyright (c) 2014 Anant Jain. All rights reserved.
//

#import "ElementsViewController.h"
#import "ElementInfoViewController.h"

@interface NSString (Contain)

- (BOOL)containsString:(NSString *)string;

@end

@implementation NSString (Contain)

- (BOOL)containsString:(NSString *)string
{
    return ([self rangeOfString:string options:NSCaseInsensitiveSearch].location != NSNotFound);
}

@end

@interface ElementsViewController ()

@property (strong, nonatomic) NSArray *allElements;
@property (strong, nonatomic) NSMutableArray *elementSearchResults;
@property (strong, nonatomic) UIImageView *backgroundImageView;

- (void)setUpTheme;

@end

@implementation ElementsViewController
{
    NSUInteger currentTheme;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"Show Info"])
    {
        NSDictionary *elementInfo = [_allElements objectAtIndex:[_elementsList indexPathForSelectedRow].row];
//        if (sender == _elementsList)
//        {
//            
//        }
//        else if (sender == _searchResults.searchResultsTableView)
//        {
//            elementInfo = [_elementSearchResults objectAtIndex:[_searchResults.searchResultsTableView indexPathForSelectedRow].row];
//        }
//        
        ElementInfoViewController *elementInfoVC = (ElementInfoViewController *)((UINavigationController *)segue.destinationViewController).topViewController;
        
        elementInfoVC.elementSymbol = [elementInfo objectForKey:@"Symbol"];
        elementInfoVC.elementName = [elementInfo objectForKey:@"Name"];
        elementInfoVC.atomicNumber = [NSString stringWithFormat:@"%d", [[elementInfo objectForKey:@"Number"] intValue]];
        elementInfoVC.atomicMass = [NSString stringWithFormat:@"%0.2f", [[elementInfo objectForKey:@"Mass"] floatValue]];
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    NSIndexPath *selectedCellIndex = [_elementsList indexPathForSelectedRow];
    NSIndexPath *searchSelectedCellIndex = [_searchResults.searchResultsTableView indexPathForSelectedRow];
    
    [self setUpTheme];
    
    [_elementsList reloadData];
    [_searchResults.searchResultsTableView reloadData];
    
    if (selectedCellIndex)
    {
        [_elementsList selectRowAtIndexPath:selectedCellIndex animated:NO scrollPosition:UITableViewScrollPositionNone];
        [_elementsList deselectRowAtIndexPath:selectedCellIndex animated:YES];
    }
    if (searchSelectedCellIndex)
    {
        [_searchResults.searchResultsTableView selectRowAtIndexPath:searchSelectedCellIndex animated:NO scrollPosition:UITableViewScrollPositionNone];
        [_searchResults.searchResultsTableView deselectRowAtIndexPath:searchSelectedCellIndex animated:YES];
    }
}

- (void)setUpTheme
{
    currentTheme = [[NSUserDefaults standardUserDefaults] integerForKey:@"Color Theme"];
    switch (currentTheme)
    {
        case 0:
            [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
            self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
            self.navigationController.navigationBar.barTintColor = nil;
            self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:1.0];
            self.navigationController.navigationBar.titleTextAttributes = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], NSForegroundColorAttributeName, nil];
            self.searchBar.barTintColor = [UIColor colorWithRed:65/255.0 green:65/255.0 blue:65/255.0 alpha:1.0];
            self.searchBar.tintColor = [UIColor whiteColor];
            
            self.tabBarController.tabBar.tintColor = [UIColor whiteColor];
            self.tabBarController.tabBar.barTintColor = [UIColor colorWithRed:0.3 green:0.3 blue:0.3 alpha:1.0];
            ((UIImageView *)_elementsList.backgroundView).image = [UIImage imageNamed:@"Black Gradient Background.png"];
            _searchResults.searchResultsTableView.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Black Gradient Background.png"]];
            _searchResults.searchResultsTableView.separatorColor = [UIColor lightGrayColor];
            
            _elementsList.separatorColor = [UIColor lightGrayColor];
            break;
        case 1:
            [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
            self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:0 green:0.478431 blue:1 alpha:1.0];
            self.navigationController.navigationBar.barTintColor = nil;
            self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:0.85 green:0.85 blue:0.85 alpha:1.0];
            self.navigationController.navigationBar.titleTextAttributes = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor blackColor], NSForegroundColorAttributeName, nil];
            self.searchBar.barTintColor = [UIColor colorWithRed:0.78 green:0.78 blue:0.78 alpha:1.0];
            self.searchBar.tintColor = [UIColor colorWithRed:0 green:0.478431 blue:1 alpha:1.0];
            
            self.tabBarController.tabBar.tintColor = [UIColor colorWithRed:0 green:0.478431 blue:1 alpha:1.0];
            self.tabBarController.tabBar.barTintColor = [UIColor colorWithRed:0.7 green:0.7 blue:0.7 alpha:1.0];
            ((UIImageView *)_elementsList.backgroundView).image = [UIImage imageNamed:@"White Gradient Background.png"];
            _searchResults.searchResultsTableView.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"White Gradient Background.png"]];
            _searchResults.searchResultsTableView.separatorColor = [UIColor grayColor];
            
            _elementsList.separatorColor = [UIColor grayColor];
            break;
        case 2:
        {
            [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
            self.navigationController.navigationBar.barTintColor = nil;
            self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:120/255.0 green:239/255.0 blue:99/255.0 alpha:1.0];
            self.navigationController.navigationBar.tintColor = [UIColor darkGrayColor];
            self.navigationController.navigationBar.titleTextAttributes = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor blackColor], NSForegroundColorAttributeName, nil];
            self.searchBar.barTintColor = [UIColor colorWithRed:70/255.0 green:239/255.0 blue:70/255.0 alpha:1.0];
            self.searchBar.tintColor = [UIColor darkGrayColor];
            
            self.tabBarController.tabBar.tintColor = [UIColor darkGrayColor];
            self.tabBarController.tabBar.barTintColor = [UIColor colorWithRed:109/255.0 green:200/255.0 blue:68/255.0 alpha:1.0];
            ((UIImageView *)_elementsList.backgroundView).image = [UIImage imageNamed:@"Green Gradient Background.png"];
            _searchResults.searchResultsTableView.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Green Gradient Background.png"]];
            _searchResults.searchResultsTableView.separatorColor = [UIColor grayColor];
            
            _elementsList.separatorColor = [UIColor grayColor];
            break;
        }
        case 3:
        {
            [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
            self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
            self.navigationController.navigationBar.barTintColor = nil;
            self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:62/255.0 green:185/255.0 blue:255/255.0 alpha:1.0];
            self.navigationController.navigationBar.titleTextAttributes = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], NSForegroundColorAttributeName, nil];
            self.searchBar.barTintColor = [UIColor colorWithRed:30u/255.0 green:140/255.0 blue:255/255.0 alpha:1.0];
            self.searchBar.tintColor = [UIColor whiteColor];
            
            self.tabBarController.tabBar.tintColor = [UIColor whiteColor];
            self.tabBarController.tabBar.barTintColor = [UIColor colorWithRed:62/255.0 green:165/255.0 blue:250/255.0 alpha:1.0];
            ((UIImageView *)_elementsList.backgroundView).image = [UIImage imageNamed:@"Blue Gradient Background.png"];
            _searchResults.searchResultsTableView.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Blue Gradient Background.png"]];
            _searchResults.searchResultsTableView.separatorColor = [UIColor whiteColor];
            
            _elementsList.separatorColor = [UIColor whiteColor];
            break;
        }
        case 4:
        {
            [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
            self.navigationController.navigationBar.barTintColor = nil;
            self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:255/255.0 green:241/255.0 blue:89/255.0 alpha:1.0];
            self.navigationController.navigationBar.tintColor = [UIColor darkGrayColor];
            self.navigationController.navigationBar.titleTextAttributes = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor blackColor], NSForegroundColorAttributeName, nil];
            self.searchBar.barTintColor = [UIColor colorWithRed:255/255.0 green:230/255.0 blue:20/255.0 alpha:1.0];
            self.searchBar.tintColor = [UIColor darkGrayColor];
            _searchResults.searchResultsTableView.separatorColor = [UIColor grayColor];
            
            self.tabBarController.tabBar.tintColor = [UIColor darkGrayColor];
            self.tabBarController.tabBar.barTintColor = [UIColor colorWithRed:219/255.0 green:207/255.0 blue:76/255.0 alpha:1.0];
            ((UIImageView *)_elementsList.backgroundView).image = [UIImage imageNamed:@"Yellow Gradient Background.png"];
            _searchResults.searchResultsTableView.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Yellow Gradient Background.png"]];
            
            _elementsList.separatorColor = [UIColor grayColor];
            break;
        }
        case 5:
        {
            [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
            self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
            self.navigationController.navigationBar.barTintColor = nil;
            self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:255/255.0 green:92/255.0 blue:95/255.0 alpha:1.0];
            self.navigationController.navigationBar.titleTextAttributes = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], NSForegroundColorAttributeName, nil];
            self.searchBar.barTintColor = [UIColor colorWithRed:255/255.0 green:25/255.0 blue:25/255.0 alpha:1.0];
            self.searchBar.tintColor = [UIColor whiteColor];
            
            self.tabBarController.tabBar.tintColor = [UIColor whiteColor];
            self.tabBarController.tabBar.barTintColor = [UIColor colorWithRed:234/255.0 green:75/255.0 blue:83/255.0 alpha:1.0];
            ((UIImageView *)_elementsList.backgroundView).image = [UIImage imageNamed:@"Red Gradient Background.png"];
            _searchResults.searchResultsTableView.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Red Gradient Background.png"]];
            _searchResults.searchResultsTableView.separatorColor = [UIColor whiteColor];
            
            _elementsList.separatorColor = [UIColor whiteColor];
            break;
        }

        default:
            break;
    }
}

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    searchBar.selectedScopeButtonIndex = _sortControl.selectedSegmentIndex;
    switch (searchBar.selectedScopeButtonIndex)
    {
        case 0:
        case 3:
            searchBar.keyboardType = UIKeyboardTypeDecimalPad;
            break;
        case 1:
        case 2:
            searchBar.keyboardType = UIKeyboardTypeAlphabet;
            break;
        default:
            break;
    }
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    NSString *textToSearchFor = [searchText stringByReplacingOccurrencesOfString:@" " withString:@""];
    _elementSearchResults = [NSMutableArray array];
    if (textToSearchFor.length == 0)
    {
        _elementSearchResults = [NSMutableArray arrayWithArray:_allElements];
    }
    else
    {
        switch (searchBar.selectedScopeButtonIndex)
        {
            case 0:
                for (NSDictionary *elementInfo in _allElements)
                {
                    if ([[NSString stringWithFormat:@"%d", [[elementInfo objectForKey:@"Number"] intValue]] containsString:textToSearchFor])
                    {
                        [_elementSearchResults addObject:elementInfo];
                    }
                }
                break;
            case 1:
                for (NSDictionary *elementInfo in _allElements)
                {
                    if ([[elementInfo objectForKey:@"Name"] containsString:textToSearchFor])
                    {
                        [_elementSearchResults addObject:elementInfo];
                    }
                }
                break;
            case 2:
                for (NSDictionary *elementInfo in _allElements)
                {
                    if ([[elementInfo objectForKey:@"Symbol"] containsString:textToSearchFor])
                    {
                        [_elementSearchResults addObject:elementInfo];
                    }
                }
                break;
            case 3:
                for (NSDictionary *elementInfo in _allElements)
                {
                    if ([[NSString stringWithFormat:@"%0.2f", [[elementInfo objectForKey:@"Mass"] floatValue]] containsString:textToSearchFor])
                    {
                        [_elementSearchResults addObject:elementInfo];
                    }
                }
                break;
            default:
                break;
        }
    }
}

- (void)searchBar:(UISearchBar *)searchBar selectedScopeButtonIndexDidChange:(NSInteger)selectedScope
{
    _sortControl.selectedSegmentIndex = selectedScope;
    [self changeSorting];
    [self searchBar:_searchBar textDidChange:_searchBar.text];
    
    switch (selectedScope)
    {
        case 0:
        case 3:
            searchBar.keyboardType = UIKeyboardTypeDecimalPad;
            break;
        case 1:
        case 2:
            searchBar.keyboardType = UIKeyboardTypeAlphabet;
            break;
        default:
            break;
    }
    
    [searchBar reloadInputViews];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _elementsList.backgroundColor = [UIColor clearColor];
    
    _elementsList.dataSource = self;
    _elementsList.delegate = self;
    self.allElements = [[NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Chemical Symbols" ofType:@"plist"]] allValues];
    self.allElements = [self.allElements sortedArrayUsingDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:@"Number" ascending:YES]]];
    
//    self.elementsList.contentInset = UIEdgeInsetsMake(self.navigationController.navigationBar.frame.size.height + [UIApplication sharedApplication].statusBarFrame.size.height, 0, self.tabBarController.tabBar.frame.size.height, 0);
//    self.elementsList.scrollIndicatorInsets = UIEdgeInsetsMake(self.navigationController.navigationBar.frame.size.height + [UIApplication sharedApplication].statusBarFrame.size.height, 0, self.tabBarController.tabBar.frame.size.height, 0);
    
    _backgroundImageView = [UIImageView new];
    _elementsList.backgroundView = _backgroundImageView;
    
    _searchResults.searchResultsTableView.rowHeight = 62;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == _elementsList) return _allElements.count;
    else if (tableView == _searchResults.searchResultsTableView) return _elementSearchResults.count;
    else return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [_elementsList dequeueReusableCellWithIdentifier:@"Cell"];
    
    if (tableView == _elementsList)
    {
        ((UILabel *)[cell viewWithTag:1]).text = [[_allElements objectAtIndex:indexPath.row] objectForKey:@"Symbol"];
        ((UILabel *)[cell viewWithTag:1]).layer.borderWidth = 1.5;
        ((UILabel *)[cell viewWithTag:1]).layer.cornerRadius = 3;
        ((UILabel *)[cell viewWithTag:2]).text = [[_allElements objectAtIndex:indexPath.row] objectForKey:@"Name"];
        ((UILabel *)[cell viewWithTag:3]).text = [NSString stringWithFormat:@"%d", [[[_allElements objectAtIndex:indexPath.row] objectForKey:@"Number"] intValue]];
        ((UILabel *)[cell viewWithTag:4]).text = [NSString stringWithFormat:@"%0.2lf", [[[_allElements objectAtIndex:indexPath.row] objectForKey:@"Mass"] doubleValue]];
    }
    else if (tableView == _searchResults.searchResultsTableView)
    {
        ((UILabel *)[cell viewWithTag:1]).text = [[_elementSearchResults objectAtIndex:indexPath.row] objectForKey:@"Symbol"];
        ((UILabel *)[cell viewWithTag:1]).layer.borderWidth = 1.5;
        ((UILabel *)[cell viewWithTag:1]).layer.cornerRadius = 3;
        ((UILabel *)[cell viewWithTag:2]).text = [[_elementSearchResults objectAtIndex:indexPath.row] objectForKey:@"Name"];
        ((UILabel *)[cell viewWithTag:3]).text = [NSString stringWithFormat:@"%d", [[[_elementSearchResults objectAtIndex:indexPath.row] objectForKey:@"Number"] intValue]];
        ((UILabel *)[cell viewWithTag:4]).text = [NSString stringWithFormat:@"%0.2lf", [[[_elementSearchResults objectAtIndex:indexPath.row] objectForKey:@"Mass"] doubleValue]];
    }
    
    switch (currentTheme)
    {
        case 0:
        case 3:
        case 5:
            ((UILabel *)[cell viewWithTag:1]).layer.borderColor = [UIColor whiteColor].CGColor;
            ((UILabel *)[cell viewWithTag:1]).layer.borderWidth = 1.5;
            ((UILabel *)[cell viewWithTag:1]).textColor = [UIColor whiteColor];
            ((UILabel *)[cell viewWithTag:2]).textColor = [UIColor whiteColor];
            ((UILabel *)[cell viewWithTag:3]).textColor = [UIColor whiteColor];
            ((UILabel *)[cell viewWithTag:4]).textColor = [UIColor whiteColor];
            break;
        case 1:
        case 2:
        case 4:
            ((UILabel *)[cell viewWithTag:1]).layer.borderColor = [UIColor colorWithRed:0.1 green:0.1 blue:0.1 alpha:1.0].CGColor;
            ((UILabel *)[cell viewWithTag:1]).textColor = [UIColor colorWithRed:0.1 green:0.1 blue:0.1 alpha:1.0];
            ((UILabel *)[cell viewWithTag:2]).textColor = [UIColor colorWithRed:0.1 green:0.1 blue:0.1 alpha:1.0];
            ((UILabel *)[cell viewWithTag:3]).textColor = [UIColor colorWithRed:0.1 green:0.1 blue:0.1 alpha:1.0];
            ((UILabel *)[cell viewWithTag:4]).textColor = [UIColor colorWithRed:0.1 green:0.1 blue:0.1 alpha:1.0];
            break;
        default:
            break;
    }
    
    cell.backgroundColor = [UIColor clearColor];
    
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

- (IBAction)changeSorting
{
    switch (_sortControl.selectedSegmentIndex)
    {
        case 0:
            self.allElements = [self.allElements sortedArrayUsingDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:@"Number" ascending:YES]]];
            break;
        case 1:
            self.allElements = [self.allElements sortedArrayUsingDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:@"Name" ascending:YES]]];
            break;
        case 2:
            self.allElements = [self.allElements sortedArrayUsingDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:@"Symbol" ascending:YES]]];
            break;
        case 3:
            self.allElements = [self.allElements sortedArrayUsingDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:@"Mass" ascending:YES]]];
            break;
        default:
            break;
    }
    [_elementsList reloadData];
}
@end
