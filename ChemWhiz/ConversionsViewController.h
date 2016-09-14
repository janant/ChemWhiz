//
//  ConversionsViewController.h
//  ChemWhiz
//
//  Created by Anant Jain on 3/8/14.
//  Copyright (c) 2014 Anant Jain. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ConversionsViewController : UIViewController <UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate, UIViewControllerTransitioningDelegate>

@property (weak, nonatomic) IBOutlet UIPickerView *unitsPicker;
@property (weak, nonatomic) IBOutlet UIButton *convertButton;

@property (weak, nonatomic) IBOutlet UITextField *quantityInputField;
@property (weak, nonatomic) IBOutlet UITextField *chemicalInputField;
@property (weak, nonatomic) IBOutlet UIStackView *mainStackView;

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *loadingIndicator;

@property (weak, nonatomic) IBOutlet UILabel *convertLabel;

@property (weak, nonatomic) IBOutlet UIImageView *backgroundImageView;

- (IBAction)convert:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *ofLabel;

@end
