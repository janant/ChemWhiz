//
//  ShowWorkViewController.h
//  ChemWhiz
//
//  Created by Anant Jain on 4/18/14.
//  Copyright (c) 2014 Anant Jain. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShowWorkViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *showWorkTable;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *loadingIndicator;

@property (strong, nonatomic) NSString *formula;
@property (strong, nonatomic) NSString *mass;

- (IBAction)exit:(id)sender;

@end
