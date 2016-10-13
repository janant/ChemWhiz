//
//  AnswersViewController.h
//  ChemWhiz
//
//  Created by Anant Jain on 3/8/14.
//  Copyright (c) 2014 Anant Jain. All rights reserved.
//

#import <UIKit/UIKit.h>

enum unitTypes
{
    unitTypeMoles,
    unitTypeGrams,
    unitTypeLiters,
    unitTypeParticles
};

@interface AnswersViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *answersTable;

@property enum unitTypes unit;
@property double inputQuantity;
@property (strong, nonatomic) NSString *formulaName;
@property (weak, nonatomic) IBOutlet UIImageView *backgroundImageView;

@property double molarMassOfChemical;

- (IBAction)exit:(id)sender;

@end
