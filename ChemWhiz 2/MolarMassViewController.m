//
//  MolarMassViewController.m
//  ChemWhiz
//
//  Created by Anant Jain on 3/8/14.
//  Copyright (c) 2014 Anant Jain. All rights reserved.
//

#import "MolarMassViewController.h"
#import "ShowWorkViewController.h"
#import "GrowAnimatedTransition.h"

@interface MolarMassViewController ()

- (void)calculateMolarMassOfChemicalWithFormula:(NSString *)formula;
- (void)addMolarMassOfFormula:(NSString *)formula currentMass:(double *)currentMolarMass formulaCoefficient:(NSUInteger)coefficient polyatomicSubscript:(NSUInteger)polyatomicSubscript succeeded:(BOOL *)succeeded;

- (void)displayMolarMass:(NSNumber *)mass;

- (void)displayErrorWithMessage:(NSString *)message;

- (void)setUpTheme;

@end

@implementation MolarMassViewController
{
    UIBarButtonItem *lowerKeyboardButton;
    UIToolbar *keyboardToolbar;
    
    NSString *enteredString;
    NSString *tempEnteredString;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"Show Work"])
    {
        UINavigationController *navController = (UINavigationController *)segue.destinationViewController;
        navController.modalPresentationStyle = UIModalPresentationCustom;
        navController.transitioningDelegate = self;
        
        ShowWorkViewController *showWorkVC = (ShowWorkViewController *)navController.topViewController;
        showWorkVC.formula = [NSString stringWithString:enteredString];
        showWorkVC.mass = [NSString stringWithString:_calculatedMolarMassLabel.text];
    }
}

- (id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source
{
    GrowAnimatedTransition *growAT = [GrowAnimatedTransition new];
    growAT.presenting = YES;
    growAT.backgroundRectFrame = [self.view convertRect:_backgroundRect.frame fromView:_mainStackView];
    return growAT;
}

- (id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    GrowAnimatedTransition *growAT = [GrowAnimatedTransition new];
    growAT.presenting = NO;
    growAT.backgroundRectFrame = [self.view convertRect:_backgroundRect.frame fromView:_mainStackView];
    return growAT;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    [self setUpTheme];
}

- (void)setUpTheme
{
    switch ([[NSUserDefaults standardUserDefaults] integerForKey:@"Color Theme"])
    {
        case 0:
            [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
            self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
            self.navigationController.navigationBar.barTintColor = nil;
            self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:1.0];
            self.navigationController.navigationBar.titleTextAttributes = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], NSForegroundColorAttributeName, nil];
            
            self.tabBarController.tabBar.tintColor = [UIColor whiteColor];
            self.tabBarController.tabBar.barTintColor = [UIColor colorWithRed:0.3 green:0.3 blue:0.3 alpha:1.0];
            self.backgroundImageView.image = [UIImage imageNamed:@"Black Gradient Background.png"];
            
            [_calculateButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            _calculateButton.tintColor = [UIColor whiteColor];
            _chemicalFormulaInputBox.backgroundColor = [UIColor colorWithRed:0.65 green:0.65 blue:0.65 alpha:1.0];
            _chemicalFormulaInputBox.keyboardAppearance = UIKeyboardAppearanceDark;
            keyboardToolbar.barStyle = UIBarStyleBlack;
            lowerKeyboardButton.tintColor = [UIColor whiteColor];
            _showWorkButton.tintColor = [UIColor whiteColor];
            
            _backgroundRect.backgroundColor = [UIColor colorWithRed:0.6 green:0.6 blue:0.6 alpha:1.0];
            
            _enterFormulaLabel.textColor = [UIColor whiteColor];
            _calculatedMolarMassLabel.textColor = [UIColor whiteColor];
            _unitLabel.textColor = [UIColor whiteColor];
            [_shareButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [_recordMassButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            break;
        case 1:
            [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
            self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:0 green:0.478431 blue:1 alpha:1.0];
            self.navigationController.navigationBar.barTintColor = nil;
            self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:0.85 green:0.85 blue:0.85 alpha:1.0];
            self.navigationController.navigationBar.titleTextAttributes = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor blackColor], NSForegroundColorAttributeName, nil];
            
            self.tabBarController.tabBar.tintColor = [UIColor colorWithRed:0 green:0.478431 blue:1 alpha:1.0];
            self.tabBarController.tabBar.barTintColor = [UIColor colorWithRed:0.7 green:0.7 blue:0.7 alpha:1.0];
            self.backgroundImageView.image = [UIImage imageNamed:@"White Gradient Background.png"];
            
            [_calculateButton setTitleColor:[UIColor colorWithRed:0 green:0.478431 blue:1 alpha:1.0] forState:UIControlStateNormal];
            _calculateButton.tintColor = [UIColor colorWithRed:0 green:0.478431 blue:1 alpha:1.0];
            _chemicalFormulaInputBox.backgroundColor = [UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1.0];
            _chemicalFormulaInputBox.keyboardAppearance = UIKeyboardAppearanceLight;
            keyboardToolbar.barStyle = UIBarStyleDefault;
            lowerKeyboardButton.tintColor = [UIColor blackColor];
            _showWorkButton.tintColor = [UIColor blackColor];
            
            _backgroundRect.backgroundColor = [UIColor colorWithRed:0.85 green:0.85 blue:0.85 alpha:1.0];
            
            _enterFormulaLabel.textColor = [UIColor blackColor];
            _calculatedMolarMassLabel.textColor = [UIColor blackColor];
            _unitLabel.textColor = [UIColor blackColor];
            [_shareButton setTitleColor:[UIColor colorWithRed:0 green:0.478431 blue:1 alpha:1.0] forState:UIControlStateNormal];
            [_recordMassButton setTitleColor:[UIColor colorWithRed:0 green:0.478431 blue:1 alpha:1.0] forState:UIControlStateNormal];
            break;
        case 2:
            [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
            self.navigationController.navigationBar.tintColor = [UIColor darkGrayColor];
            self.navigationController.navigationBar.barTintColor = nil;
            self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:120/255.0 green:239/255.0 blue:99/255.0 alpha:1.0];
            self.navigationController.navigationBar.titleTextAttributes = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor blackColor], NSForegroundColorAttributeName, nil];
            
            self.tabBarController.tabBar.tintColor = [UIColor darkGrayColor];
            self.tabBarController.tabBar.barTintColor = [UIColor colorWithRed:109/255.0 green:200/255.0 blue:68/255.0 alpha:1.0];
            _backgroundImageView.image = [UIImage imageNamed:@"Green Gradient Background.png"];
            
            [_calculateButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
            _calculateButton.tintColor = [UIColor darkGrayColor];
            _chemicalFormulaInputBox.backgroundColor = [UIColor colorWithRed:185/255.0 green:255/255.0 blue:120/255.0 alpha:1.0];
            _chemicalFormulaInputBox.keyboardAppearance = UIKeyboardAppearanceDark;
            keyboardToolbar.barStyle = UIBarStyleBlack;
            lowerKeyboardButton.tintColor = [UIColor whiteColor];
            _showWorkButton.tintColor = [UIColor darkGrayColor];
            
            _backgroundRect.backgroundColor = [UIColor colorWithRed:128/255.0 green:195/255.0 blue:90/255.0 alpha:1.0];
            
            _enterFormulaLabel.textColor = [UIColor blackColor];
            _calculatedMolarMassLabel.textColor = [UIColor blackColor];
            _unitLabel.textColor = [UIColor blackColor];
            [_shareButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
            [_recordMassButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
            break;
        case 3:
            [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
            self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
            self.navigationController.navigationBar.barTintColor = nil;
            self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:62/255.0 green:185/255.0 blue:255/255.0 alpha:1.0];
            self.navigationController.navigationBar.titleTextAttributes = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], NSForegroundColorAttributeName, nil];
            
            self.tabBarController.tabBar.tintColor = [UIColor whiteColor];
            self.tabBarController.tabBar.barTintColor = [UIColor colorWithRed:62/255.0 green:165/255.0 blue:250/255.0 alpha:1.0];
            _backgroundImageView.image = [UIImage imageNamed:@"Blue Gradient Background.png"];
            
            [_calculateButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            _calculateButton.tintColor = [UIColor whiteColor];
            _chemicalFormulaInputBox.backgroundColor = [UIColor colorWithRed:134/255.0 green:208/255.0 blue:255/255.0 alpha:1.0];
            _chemicalFormulaInputBox.keyboardAppearance = UIKeyboardAppearanceLight;
            keyboardToolbar.barStyle = UIBarStyleDefault;
            lowerKeyboardButton.tintColor = [UIColor blackColor];
            _showWorkButton.tintColor = [UIColor whiteColor];
            
            _backgroundRect.backgroundColor = [UIColor colorWithRed:59/255.0 green:163/255.0 blue:225/255.0 alpha:1.0];
            
            _enterFormulaLabel.textColor = [UIColor whiteColor];
            _calculatedMolarMassLabel.textColor = [UIColor whiteColor];
            _unitLabel.textColor = [UIColor whiteColor];
            [_shareButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [_recordMassButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            break;
        case 4:
            [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
            self.navigationController.navigationBar.tintColor = [UIColor darkGrayColor];
            self.navigationController.navigationBar.barTintColor = nil;
            self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:255/255.0 green:241/255.0 blue:89/255.0 alpha:1.0];
            self.navigationController.navigationBar.titleTextAttributes = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor blackColor], NSForegroundColorAttributeName, nil];
            
            self.tabBarController.tabBar.tintColor = [UIColor darkGrayColor];
            self.tabBarController.tabBar.barTintColor = [UIColor colorWithRed:219/255.0 green:207/255.0 blue:76/255.0 alpha:1.0];
            _backgroundImageView.image = [UIImage imageNamed:@"Yellow Gradient Background.png"];
            
            [_calculateButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
            _calculateButton.tintColor = [UIColor darkGrayColor];
            _chemicalFormulaInputBox.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:169/255.0 alpha:1.0];
            _chemicalFormulaInputBox.keyboardAppearance = UIKeyboardAppearanceDark;
            keyboardToolbar.barStyle = UIBarStyleBlack;
            lowerKeyboardButton.tintColor = [UIColor whiteColor];
            _showWorkButton.tintColor = [UIColor darkGrayColor];
            
            _backgroundRect.backgroundColor = [UIColor colorWithRed:220/255.0 green:209/255.0 blue:91/255.0 alpha:1.0];
            
            _enterFormulaLabel.textColor = [UIColor blackColor];
            _calculatedMolarMassLabel.textColor = [UIColor blackColor];
            _unitLabel.textColor = [UIColor blackColor];
            [_shareButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
            [_recordMassButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
            break;
        case 5:
            [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
            self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
            self.navigationController.navigationBar.barTintColor = nil;
            self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:255/255.0 green:92/255.0 blue:95/255.0 alpha:1.0];
            self.navigationController.navigationBar.titleTextAttributes = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], NSForegroundColorAttributeName, nil];
            
            self.tabBarController.tabBar.tintColor = [UIColor whiteColor];
            self.tabBarController.tabBar.barTintColor = [UIColor colorWithRed:234/255.0 green:75/255.0 blue:83/255.0 alpha:1.0];
            _backgroundImageView.image = [UIImage imageNamed:@"Red Gradient Background.png"];
            
            [_calculateButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            _calculateButton.tintColor = [UIColor whiteColor];
            _chemicalFormulaInputBox.backgroundColor = [UIColor colorWithRed:255/255.0 green:160/255.0 blue:162/255.0 alpha:1.0];
            _chemicalFormulaInputBox.keyboardAppearance = UIKeyboardAppearanceLight;
            keyboardToolbar.barStyle = UIBarStyleDefault;
            lowerKeyboardButton.tintColor = [UIColor blackColor];
            _showWorkButton.tintColor = [UIColor whiteColor];
            
            _backgroundRect.backgroundColor = [UIColor colorWithRed:220/255.0 green:97/255.0 blue:101/255.0 alpha:1.0];
            
            _enterFormulaLabel.textColor = [UIColor whiteColor];
            _calculatedMolarMassLabel.textColor = [UIColor whiteColor];
            _unitLabel.textColor = [UIColor whiteColor];
            [_shareButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [_recordMassButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            break;
        default:
            break;
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.    
    _chemicalFormulaInputBox.delegate = self;
    
    _loadingIndicator.hidden = YES;
    
    _calculatedMolarMassLabel.hidden = YES;
    _gramsPerMoleIndicator.hidden = YES;
    
    [_calculateButton setBackgroundImage:[[[UIImage imageNamed:@"Button Image.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(7, 7, 7, 7) resizingMode:UIImageResizingModeStretch] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] forState:UIControlStateNormal];
    _calculateButton.contentEdgeInsets = UIEdgeInsetsMake(3, 5, 3, 5);
    
    _backgroundRect.layer.cornerRadius = 15;
    _backgroundRect.layer.masksToBounds = YES;
    
    _backgroundRect.userInteractionEnabled = NO;
    _backgroundRect.alpha = 0.0;
    _showWorkButton.userInteractionEnabled = NO;
    _showWorkButton.alpha = 0.0;
    
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:1.0];
    self.tabBarController.tabBar.barTintColor = [UIColor colorWithRed:0.3 green:0.3 blue:0.3 alpha:1.0];
    
    lowerKeyboardButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:_chemicalFormulaInputBox action:@selector(resignFirstResponder)];
    keyboardToolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
    keyboardToolbar.barStyle = UIBarStyleBlackTranslucent;
    keyboardToolbar.tintColor = [UIColor whiteColor];
    keyboardToolbar.items = @[[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                              lowerKeyboardButton
                              ];
    
    _chemicalFormulaInputBox.inputAccessoryView = keyboardToolbar;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    [self performSelectorInBackground:@selector(calculateMolarMassOfChemicalWithFormula:) withObject:textField.text];
    
    _loadingIndicator.hidden = NO;
    [_loadingIndicator startAnimating];
    
    return YES;
}

- (void)displayMolarMass:(NSNumber *)mass
{
    _calculatedMolarMassLabel.text = [NSString stringWithFormat:@"%0.2lf", [mass doubleValue]];
    
    _calculatedMolarMassLabel.hidden = NO;
    _gramsPerMoleIndicator.hidden = NO;
    
    _backgroundRect.userInteractionEnabled = YES;
    _showWorkButton.userInteractionEnabled = YES;
    [UIView animateWithDuration:0.25 animations:^{
        _backgroundRect.alpha = 1.0;
        _showWorkButton.alpha = 1.0;
    }];
    
    enteredString = [NSString stringWithString:tempEnteredString];
    
    _loadingIndicator.hidden = YES;
    [_loadingIndicator stopAnimating];
    
    [_recordMassButton setTitle:@"Copy" forState:UIControlStateNormal];
    _recordMassButton.enabled = YES;
    
    switch ([[NSUserDefaults standardUserDefaults] integerForKey:@"Color Theme"])
    {
        case 0:
        case 3:
        case 5:
            [_recordMassButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            break;
        case 1:
            [_recordMassButton setTitleColor:[UIColor colorWithRed:0 green:0.478431 blue:1 alpha:1.0] forState:UIControlStateNormal];
            break;
        case 2:
        case 4:
            [_recordMassButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        default:
            break;
    }
}

- (void)displayErrorWithMessage:(NSString *)message
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:message delegate:nil cancelButtonTitle:nil otherButtonTitles:@"Dismiss", nil];
    [alert show];
    
    _loadingIndicator.hidden = YES;
    [_loadingIndicator stopAnimating];
}

- (void)calculateMolarMassOfChemicalWithFormula:(NSString *)formula
{
    // Removes whitespace from formula.
    formula = [formula stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    // Returns error message if empty formula is given.
    if (formula.length == 0)
    {
        [self performSelectorOnMainThread:@selector(displayErrorWithMessage:) withObject:@"Error: please enter a chemical formula." waitUntilDone:NO];
        return;
    }
    
    tempEnteredString = [NSString stringWithString:formula];
    
    double molarMass = 0.0;
    NSUInteger currentPosition = 0;
    
    // Determines beginning coefficient
    NSUInteger coefficient = 1;
    if ([formula characterAtIndex:0] >= '0' && [formula characterAtIndex:0] <= '9')
    {
        NSMutableString *coefficientString = [NSMutableString new];
        for ( ; currentPosition < formula.length; currentPosition++)
        {
            unichar character = [formula characterAtIndex:currentPosition];
            if (character >= '0' && character <= '9')
            {
                [coefficientString appendFormat:@"%c", character];
            }
            else
            {
                break;
            }
        }
        coefficient = coefficientString.integerValue;
    }
    
    if (currentPosition == formula.length)
    {
        [self performSelectorOnMainThread:@selector(displayErrorWithMessage:) withObject:@"Error: please enter a chemical formula." waitUntilDone:NO];
        return;
    }
    
    // Parsing for chemicals
    for ( ; currentPosition < formula.length; currentPosition++)
    {
        unichar currentCharacter = [formula characterAtIndex:currentPosition];
        
        if (currentCharacter >= 'A' && currentCharacter <= 'Z')
        {
            NSMutableString *symbolsString = [NSMutableString new];
            for ( ; currentPosition < formula.length; currentPosition++)
            {
                currentCharacter = [formula characterAtIndex:currentPosition];
                if ((currentCharacter >= 'A' && currentCharacter <= 'Z') || (currentCharacter >= 'a' && currentCharacter <= 'z') || (currentCharacter >= '0' && currentCharacter <= '9'))
                {
                    [symbolsString appendFormat:@"%c", currentCharacter];
                }
                else
                {
                    currentPosition--;
                    break;
                }
            }
            
            BOOL succeeded;
            
            [self addMolarMassOfFormula:symbolsString currentMass:&molarMass formulaCoefficient:coefficient polyatomicSubscript:1 succeeded:&succeeded];
            
            if (!succeeded)
            {
                return;
            }
        }
        else if (currentCharacter == '(')
        {
            currentPosition++;
            NSMutableString *polyatomicSymbolsString = [NSMutableString string];
            NSUInteger polyatomicSubscript = 1;
            BOOL hasClosingParenthesis = NO;
            NSUInteger numberOfUnclosedParentheses = 1;
            
            for ( ; currentPosition < formula.length; currentPosition++)
            {
                currentCharacter = [formula characterAtIndex:currentPosition];
                if ((currentCharacter >= 'A' && currentCharacter <= 'Z') || (currentCharacter >= 'a' && currentCharacter <= 'z') || (currentCharacter >= '0' && currentCharacter <= '9'))
                {
                    [polyatomicSymbolsString appendFormat:@"%c", currentCharacter];
                }
                else if (currentCharacter == '(')
                {
                    numberOfUnclosedParentheses++;
                    [polyatomicSymbolsString appendFormat:@"%c", currentCharacter];
                }
                else if (currentCharacter == ')')
                {
                    numberOfUnclosedParentheses--;
                    if (numberOfUnclosedParentheses > 0)
                    {
                        [polyatomicSymbolsString appendFormat:@"%c", currentCharacter];
                    }
                    else
                    {
                        hasClosingParenthesis = YES;
                        currentPosition++;
                        NSMutableString *polyatomicSubscriptString = [NSMutableString string];
                        for ( ; currentPosition < formula.length; currentPosition++)
                        {
                            currentCharacter = [formula characterAtIndex:currentPosition];
                            if (currentCharacter >= '0' && currentCharacter <= '9')
                            {
                                [polyatomicSubscriptString appendFormat:@"%c", currentCharacter];
                            }
                            else
                            {
                                currentPosition--;
                                break;
                            }
                        }
                        if (polyatomicSubscriptString.length == 0)
                        {
                            [self performSelectorOnMainThread:@selector(displayErrorWithMessage:) withObject:@"Error: no subscript after polyatomic ion." waitUntilDone:NO];
                            return;
                        }
                        else
                        {
                            polyatomicSubscript = polyatomicSubscriptString.integerValue;
                        }
                        break;
                    }
                }
                else
                {
                    [self performSelectorOnMainThread:@selector(displayErrorWithMessage:) withObject:[NSString stringWithFormat:@"Error: unidentified character '%c' in formula.", currentCharacter] waitUntilDone:NO];
                    return;
                }
            }
            
            if (!hasClosingParenthesis)
            {
                [self performSelectorOnMainThread:@selector(displayErrorWithMessage:) withObject:@"Error: no closing parenthesis in polyatomic ion." waitUntilDone:NO];
                return;
            }
            
            BOOL succeeded;
            
            [self addMolarMassOfFormula:polyatomicSymbolsString currentMass:&molarMass formulaCoefficient:coefficient polyatomicSubscript:polyatomicSubscript succeeded:&succeeded];
            
            if (!succeeded)
            {
                return;
            }
        }
        else if (currentCharacter == '*')
        {
            currentPosition++;
            if (currentPosition == formula.length)
            {
                [self performSelectorOnMainThread:@selector(displayErrorWithMessage:) withObject:@"Error: no formula for hydrate." waitUntilDone:NO];
                return;
            }
            
            NSUInteger hydrateCoefficient = 1;
            
            if ([formula characterAtIndex:currentPosition] >= '0' && [formula characterAtIndex:currentPosition] <= '9')
            {
                NSMutableString *coefficientString = [NSMutableString new];
                for ( ; currentPosition < formula.length; currentPosition++)
                {
                    unichar character = [formula characterAtIndex:currentPosition];
                    if (character >= '0' && character <= '9')
                    {
                        [coefficientString appendFormat:@"%c", character];
                    }
                    else
                    {
                        break;
                    }
                }
                hydrateCoefficient = coefficientString.integerValue;
            }
            
            if (currentPosition == formula.length)
            {
                [self performSelectorOnMainThread:@selector(displayErrorWithMessage:) withObject:@"Error: no formula after hydrate coefficient." waitUntilDone:NO];
                return;
            }
            
            NSMutableString *hydrateSymbolsString = [NSMutableString string];
            
            for ( ; currentPosition < formula.length; currentPosition++)
            {
                currentCharacter = [formula characterAtIndex:currentPosition];
                
                if ((currentCharacter >= 'A' && currentCharacter <= 'Z') || (currentCharacter >= 'a' && currentCharacter <= 'z') || (currentCharacter >= '0' && currentCharacter <= '9'))
                {
                    [hydrateSymbolsString appendFormat:@"%c", currentCharacter];
                }
                else if (currentCharacter == '(')
                {
                    [self performSelectorOnMainThread:@selector(displayErrorWithMessage:) withObject:@"Error: hydrates cannot have polyatomic ions." waitUntilDone:NO];
                    return;
                }
                else if (currentCharacter == '*')
                {
                    [self performSelectorOnMainThread:@selector(displayErrorWithMessage:) withObject:@"Error: hydrates cannot have hydrates within them." waitUntilDone:NO];
                    return;
                }
                else
                {
                    [self performSelectorOnMainThread:@selector(displayErrorWithMessage:) withObject:[NSString stringWithFormat:@"Error: unidentified character '%c' in hydrate formula.", currentCharacter] waitUntilDone:NO];
                    return;
                }
            }
            
            BOOL succeeded;
            
            [self addMolarMassOfFormula:hydrateSymbolsString currentMass:&molarMass formulaCoefficient:coefficient polyatomicSubscript:hydrateCoefficient succeeded:&succeeded];
            
            if (!succeeded)
            {
                return;
            }
        }
        else
        {
            [self performSelectorOnMainThread:@selector(displayErrorWithMessage:) withObject:[NSString stringWithFormat:@"Error: unidentified character '%c' in formula.", currentCharacter] waitUntilDone:NO];
            return;
        }
    }
    
    [self performSelectorOnMainThread:@selector(displayMolarMass:) withObject:[NSNumber numberWithDouble:molarMass] waitUntilDone:NO];
}

- (void)addMolarMassOfFormula:(NSString *)formula currentMass:(double *)currentMolarMass formulaCoefficient:(NSUInteger)coefficient polyatomicSubscript:(NSUInteger)polyatomicSubscript succeeded:(BOOL *)succeeded
{
    for (NSUInteger currentPosition = 0; currentPosition < formula.length; currentPosition++)
    {
        unichar currentCharacter = [formula characterAtIndex:currentPosition];
        if (currentCharacter == '(')
        {
            NSUInteger indexOfFirstParenthesis = currentPosition;
            NSUInteger indexOfLastParenthesis = 0;
            currentPosition++;
            NSMutableString *polyatomicSymbolsString = [NSMutableString string];
            NSUInteger nestedPolyatomicSubscript = 1;
            BOOL hasClosingParenthesis = NO;
            NSUInteger numberOfUnclosedParentheses = 1;
            
            for ( ; currentPosition < formula.length; currentPosition++)
            {
                currentCharacter = [formula characterAtIndex:currentPosition];
                if ((currentCharacter >= 'A' && currentCharacter <= 'Z') || (currentCharacter >= 'a' && currentCharacter <= 'z') || (currentCharacter >= '0' && currentCharacter <= '9'))
                {
                    [polyatomicSymbolsString appendFormat:@"%c", currentCharacter];
                }
                else if (currentCharacter == '(')
                {
                    numberOfUnclosedParentheses++;
                    [polyatomicSymbolsString appendFormat:@"%c", currentCharacter];
                }
                else if (currentCharacter == ')')
                {
                    numberOfUnclosedParentheses--;
                    if (numberOfUnclosedParentheses > 0)
                    {
                        [polyatomicSymbolsString appendFormat:@"%c", currentCharacter];
                    }
                    else
                    {
                        hasClosingParenthesis = YES;
                        currentPosition++;
                        NSMutableString *polyatomicSubscriptString = [NSMutableString string];
                        for ( ; currentPosition < formula.length; currentPosition++)
                        {
                            currentCharacter = [formula characterAtIndex:currentPosition];
                            if (currentCharacter >= '0' && currentCharacter <= '9')
                            {
                                indexOfLastParenthesis = currentPosition+1;
                                [polyatomicSubscriptString appendFormat:@"%c", currentCharacter];
                            }
                            else
                            {
                                indexOfLastParenthesis = currentPosition;
                                currentPosition--;
                                break;
                            }
                        }
                        
                        if (polyatomicSubscriptString.length == 0)
                        {
                            [self performSelectorOnMainThread:@selector(displayErrorWithMessage:) withObject:@"Error: no subscript after polyatomic ion." waitUntilDone:NO];
                            *succeeded = NO;
                            return;
                        }
                        else
                        {
                            nestedPolyatomicSubscript = polyatomicSubscriptString.integerValue;
                        }
                        break;
                    }
                }
                else
                {
                    [self performSelectorOnMainThread:@selector(displayErrorWithMessage:) withObject:[NSString stringWithFormat:@"Error: unidentified character '%c' in formula.", currentCharacter] waitUntilDone:NO];
                    *succeeded = NO;
                    return;
                }
            }
            
            if (!hasClosingParenthesis)
            {
                [self performSelectorOnMainThread:@selector(displayErrorWithMessage:) withObject:@"Error: no closing parenthesis in polyatomic ion." waitUntilDone:NO];
                *succeeded = NO;
                return;
            }
            
            BOOL newSucceeded = NO;
            
            [self addMolarMassOfFormula:polyatomicSymbolsString currentMass:currentMolarMass formulaCoefficient:coefficient polyatomicSubscript:polyatomicSubscript * nestedPolyatomicSubscript succeeded:&newSucceeded];
            
            if (!newSucceeded)
            {
                return;
            }
            else
            {
                NSString *toAddFormula = [NSString stringWithFormat:@"%@%@", [formula substringToIndex:indexOfFirstParenthesis], [formula substringFromIndex:indexOfLastParenthesis]];
                
                newSucceeded = NO;
                
                [self addMolarMassOfFormula:toAddFormula currentMass:currentMolarMass formulaCoefficient:coefficient polyatomicSubscript:polyatomicSubscript succeeded:&newSucceeded];
                
                if (!newSucceeded)
                {
                    return;
                }
                
                *succeeded = YES;
                
                return;
            }
        }
    }
    
    NSDictionary *elementsDictionary = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Chemical Symbols" ofType:@"plist"]];
    
    // Parses for elements
    for (NSUInteger currentPosition = 0; currentPosition < formula.length; currentPosition++)
    {
        unichar currentCharacter = [formula characterAtIndex:currentPosition];
        if (currentCharacter >= 'A' && currentCharacter <= 'Z')
        {
            NSMutableString *elementSymbol = [NSMutableString string];
            [elementSymbol appendFormat:@"%c", currentCharacter];
            
            NSUInteger elementSubscript = 1;
            
            currentPosition++;
            
            // Finds the element symbol and its subscript (if it has one)
            for ( ; currentPosition < formula.length; currentPosition++)
            {
                currentCharacter = [formula characterAtIndex:currentPosition];
                if (currentCharacter >= 'a' && currentCharacter <= 'z')
                {
                    [elementSymbol appendFormat:@"%c", currentCharacter];
                }
                if (currentCharacter >= 'A' && currentCharacter <= 'Z')
                {
                    currentPosition--;
                    break;
                }
                else if (currentCharacter >= '0' && currentCharacter <= '9')
                {
                    NSMutableString *elementSubscriptString = [NSMutableString string];
                    for ( ; currentPosition < formula.length; currentPosition++)
                    {
                        currentCharacter = [formula characterAtIndex:currentPosition];
                        if (currentCharacter >= '0' && currentCharacter <= '9')
                        {
                            [elementSubscriptString appendFormat:@"%c", currentCharacter];
                        }
                        else
                        {
                            currentPosition--;
                            break;
                        }
                    }
                    elementSubscript = elementSubscriptString.integerValue;
                    break;
                }
            }
            
            // Checks if symbol exists and adds it if it does
            NSDictionary *elementInfo = [elementsDictionary objectForKey:elementSymbol];
            if (elementInfo)
            {
                // Adds the element name enough times as outlined by coefficient, elementSubscript, and polyatomicSubscript
                for (NSInteger i = 0; i < elementSubscript * coefficient * polyatomicSubscript; i++)
                {
                    *currentMolarMass += [[elementInfo objectForKey:@"Mass"] doubleValue];
                }
            }
            else
            {
                [self performSelectorOnMainThread:@selector(displayErrorWithMessage:) withObject:[NSString stringWithFormat:@"Error: element symbol %@ does not exist.", elementSymbol] waitUntilDone:NO];
                *succeeded = NO;
                return;
            }
        }
        else
        {
            [self performSelectorOnMainThread:@selector(displayErrorWithMessage:) withObject:@"Error: unidentified element symbol. Check capitalization." waitUntilDone:NO];
            *succeeded = NO;
            return;
        }
    }
    *succeeded = YES;
}

- (IBAction)calculateMolarMass:(id)sender
{
    if (_chemicalFormulaInputBox.isFirstResponder) [_chemicalFormulaInputBox resignFirstResponder];
    
    _loadingIndicator.hidden = NO;
    [_loadingIndicator startAnimating];
    
    [self performSelectorInBackground:@selector(calculateMolarMassOfChemicalWithFormula:) withObject:_chemicalFormulaInputBox.text];
}

- (IBAction)shareMass:(id)sender
{
    UIActivityViewController *activityVC = [[UIActivityViewController alloc] initWithActivityItems:@[_calculatedMolarMassLabel.text] applicationActivities:nil];
    [self presentViewController:activityVC animated:YES completion:nil];
}

- (IBAction)copyMass:(id)sender
{
    [UIPasteboard generalPasteboard].string = _calculatedMolarMassLabel.text;
    [_recordMassButton setTitle:@"Copied" forState:UIControlStateNormal];
    _recordMassButton.enabled = NO;
    [_recordMassButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
}

@end
