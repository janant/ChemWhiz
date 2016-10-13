//
//  MoreViewController.h
//  ChemWhiz
//
//  Created by Anant Jain on 3/10/14.
//  Copyright (c) 2014 Anant Jain. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MoreViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *moreTableView;

@property (strong, nonatomic) UISegmentedControl *colorThemeControl;
@property (weak, nonatomic) IBOutlet UIImageView *backgroundImageView;

@end
