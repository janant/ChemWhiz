//
//  ElementInfoViewController.h
//  ChemWhiz
//
//  Created by Anant Jain on 3/10/14.
//  Copyright (c) 2014 Anant Jain. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ElementInfoViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *symbolLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *atomicNumberLabel;
@property (weak, nonatomic) IBOutlet UILabel *massLabel;

@property (weak, nonatomic) IBOutlet UIStackView *mainStackView;
@property (weak, nonatomic) IBOutlet UILabel *selectElementLabel;


@property (weak, nonatomic) IBOutlet UILabel *atomicNumberIndicatorLabel;
@property (weak, nonatomic) IBOutlet UILabel *massIndicatorLabel;

@property (weak, nonatomic) IBOutlet UIImageView *backgroundImageView;

@property (strong, nonatomic) NSString *elementSymbol;
@property (strong, nonatomic) NSString *elementName;
@property (strong, nonatomic) NSString *atomicNumber;
@property (strong, nonatomic) NSString *atomicMass;

- (IBAction)shareElement:(id)sender;

@end
