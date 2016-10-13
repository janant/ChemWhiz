//
//  ElementsViewController.h
//  ChemWhiz
//
//  Created by Anant Jain on 3/14/14.
//  Copyright (c) 2014 Anant Jain. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ElementsViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate, UISearchDisplayDelegate>

@property (weak, nonatomic) IBOutlet UITableView *elementsList;
@property (weak, nonatomic) IBOutlet UISegmentedControl *sortControl;
@property (strong, nonatomic) IBOutlet UISearchDisplayController *searchResults;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;

- (IBAction)changeSorting;

@end
