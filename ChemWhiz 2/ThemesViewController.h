//
//  ThemesViewController.h
//  ChemWhiz
//
//  Created by Anant Jain on 4/16/14.
//  Copyright (c) 2014 Anant Jain. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ThemesViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *backgroundImageView;
@property (weak, nonatomic) IBOutlet UITableView *themesTableView;

@property NSUInteger currentTheme;

@end
