//
//  MolarMassViewController.h
//  ChemWhiz
//
//  Created by Anant Jain on 3/8/14.
//  Copyright (c) 2014 Anant Jain. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MolarMassViewController : UIViewController <UITextFieldDelegate, UIViewControllerTransitioningDelegate>

@property (weak, nonatomic) IBOutlet UITextField *chemicalFormulaInputBox;
@property (weak, nonatomic) IBOutlet UILabel *calculatedMolarMassLabel;
@property (weak, nonatomic) IBOutlet UILabel *gramsPerMoleIndicator;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *loadingIndicator;
@property (weak, nonatomic) IBOutlet UIButton *calculateButton;
@property (weak, nonatomic) IBOutlet UIButton *showWorkButton;

@property (weak, nonatomic) IBOutlet UIView *backgroundRect;
@property (weak, nonatomic) IBOutlet UIImageView *backgroundImageView;
@property (weak, nonatomic) IBOutlet UILabel *enterFormulaLabel;

@property (weak, nonatomic) IBOutlet UIButton *recordMassButton;

@property (weak, nonatomic) IBOutlet UILabel *unitLabel;
@property (weak, nonatomic) IBOutlet UIButton *shareButton;
@property (weak, nonatomic) IBOutlet UIStackView *mainStackView;

- (IBAction)calculateMolarMass:(id)sender;
- (IBAction)shareMass:(id)sender;
- (IBAction)copyMass:(id)sender;

@end
