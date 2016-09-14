//
//  ShowWorkViewController.m
//  ChemWhiz
//
//  Created by Anant Jain on 4/18/14.
//  Copyright (c) 2014 Anant Jain. All rights reserved.
//

#import "ShowWorkViewController.h"

@interface ShowWorkViewController ()

- (void)setUpTheme;

- (void)addElementsOfFormula:(NSString *)formula currentMass:(double *)currentMolarMass formulaCoefficient:(NSUInteger)coefficient polyatomicSubscript:(NSUInteger)polyatomicSubscript succeeded:(BOOL *)succeeded;
- (void)calculateAtomsOfChemicalWithFormula:(NSString *)formula;
- (void)displayErrorWithMessage:(NSString *)message;

- (void)displayWork;

@end

@implementation ShowWorkViewController
{
    NSMutableArray *atomsInFormula;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self setUpTheme];
    
    [_showWorkTable reloadData];
}

- (void)setUpTheme
{
    switch ([[NSUserDefaults standardUserDefaults] integerForKey:@"Color Theme"])
    {
        case 0:
            self.view.backgroundColor = [UIColor colorWithRed:0.6 green:0.6 blue:0.6 alpha:1.0];
            self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:0.6 green:0.6 blue:0.6 alpha:1.0];
            self.navigationController.navigationBar.titleTextAttributes = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], NSForegroundColorAttributeName, nil];
            self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
            _showWorkTable.separatorColor = [UIColor lightGrayColor];
            break;
        case 1:
            self.view.backgroundColor = [UIColor colorWithRed:0.85 green:0.85 blue:0.85 alpha:1.0];
            self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:0.85 green:0.85 blue:0.85 alpha:1.0];
            self.navigationController.navigationBar.titleTextAttributes = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor blackColor], NSForegroundColorAttributeName, nil];
            self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:0 green:0.478431 blue:1 alpha:1.0];
            _showWorkTable.separatorColor = [UIColor grayColor];
            break;
        case 2:
            self.view.backgroundColor = [UIColor colorWithRed:128/255.0 green:195/255.0 blue:90/255.0 alpha:1.0];
            self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:128/255.0 green:195/255.0 blue:90/255.0 alpha:1.0];
            self.navigationController.navigationBar.titleTextAttributes = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor blackColor], NSForegroundColorAttributeName, nil];
            self.navigationController.navigationBar.tintColor = [UIColor darkGrayColor];
            _showWorkTable.separatorColor = [UIColor grayColor];
            break;
        case 3:
            self.view.backgroundColor = [UIColor colorWithRed:59/255.0 green:163/255.0 blue:225/255.0 alpha:1.0];
            self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:59/255.0 green:163/255.0 blue:225/255.0 alpha:1.0];
            self.navigationController.navigationBar.titleTextAttributes = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], NSForegroundColorAttributeName, nil];
            self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
            _showWorkTable.separatorColor = [UIColor whiteColor];
            break;
        case 4:
            self.view.backgroundColor = [UIColor colorWithRed:220/255.0 green:209/255.0 blue:91/255.0 alpha:1.0];
            self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:220/255.0 green:209/255.0 blue:91/255.0 alpha:1.0];
            self.navigationController.navigationBar.titleTextAttributes = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor blackColor], NSForegroundColorAttributeName, nil];
            self.navigationController.navigationBar.tintColor = [UIColor darkGrayColor];
            _showWorkTable.separatorColor = [UIColor grayColor];
            break;
        case 5:
            self.view.backgroundColor = [UIColor colorWithRed:220/255.0 green:97/255.0 blue:101/255.0 alpha:1.0];
            self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:220/255.0 green:97/255.0 blue:101/255.0 alpha:1.0];
            self.navigationController.navigationBar.titleTextAttributes = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], NSForegroundColorAttributeName, nil];
            self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
            _showWorkTable.separatorColor = [UIColor whiteColor];
            break;
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _showWorkTable.backgroundColor = [UIColor clearColor];
    
    atomsInFormula = [NSMutableArray array];
    
    _showWorkTable.alpha = 0;
    _loadingIndicator.alpha = 1.0;
    
    [_loadingIndicator startAnimating];
    
    [self performSelectorInBackground:@selector(calculateAtomsOfChemicalWithFormula:) withObject:_formula];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section)
    {
        case 0:
            return 1;
            break;
        case 1:
            return [[atomsInFormula objectAtIndex:0] count];
            break;
        case 2:
            return 1;
            break;
        default:
            return 0;
            break;
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    switch (section) {
        case 0:
            return @"Input";
            break;
        case 1:
            return @"Atoms and Total Masses";
            break;
        case 2:
            return @"Total mass";
            break;
        default:
            return nil;
            break;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section)
    {
        case 0:
            return 44;
            break;
        case 1:
            return 94;
            break;
        case 2:
            return 70;
            break;
        default:
            return 0;
            break;
    }
}

- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section
{
    UITableViewHeaderFooterView *header = (UITableViewHeaderFooterView *)view;
    switch ([[NSUserDefaults standardUserDefaults] integerForKey:@"Color Theme"])
    {
        case 0:
        case 3:
        case 5:
            header.textLabel.textColor = [UIColor whiteColor];
            break;
        case 1:
            header.textLabel.textColor = [UIColor blackColor];
            break;
        case 2:
        case 4:
            header.textLabel.textColor = [UIColor darkGrayColor];
            break;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell;
    
    switch (indexPath.section)
    {
        case 0:
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
            cell.textLabel.text = self.formula;
            
            switch ([[NSUserDefaults standardUserDefaults] integerForKey:@"Color Theme"])
            {
                case 0:
                case 3:
                case 5:
                    cell.textLabel.textColor = [UIColor whiteColor];
                    break;
                case 1:
                    cell.textLabel.textColor = [UIColor blackColor];
                    break;
                case 2:
                case 4:
                    cell.textLabel.textColor = [UIColor darkGrayColor];
                    break;
            }
            break;
        case 1:
            cell = [tableView dequeueReusableCellWithIdentifier:@"Work Cell"];
            ((UILabel *)[cell viewWithTag:1]).text = [[[atomsInFormula objectAtIndex:0] objectAtIndex:indexPath.row] objectForKey:@"Name"];
            ((UILabel *)[cell viewWithTag:2]).text = [NSString stringWithFormat:@"Quantity: %d", [[[atomsInFormula objectAtIndex:1] objectAtIndex:indexPath.row] intValue]];
            ((UILabel *)[cell viewWithTag:3]).text = [NSString stringWithFormat:@"Mass: %0.2f g/mol", [[[[atomsInFormula objectAtIndex:0] objectAtIndex:indexPath.row] objectForKey:@"Mass"] floatValue]];
            ((UILabel *)[cell viewWithTag:4]).text = [NSString stringWithFormat:@"%0.2f", (float)([[[atomsInFormula objectAtIndex:1] objectAtIndex:indexPath.row] intValue] * [[[[atomsInFormula objectAtIndex:0] objectAtIndex:indexPath.row] objectForKey:@"Mass"] floatValue])];
            ((UILabel *)[cell viewWithTag:6]).text = [[[atomsInFormula objectAtIndex:0] objectAtIndex:indexPath.row] objectForKey:@"Symbol"];
            
            ((UILabel *)[cell viewWithTag:6]).layer.borderWidth = 1;
            ((UILabel *)[cell viewWithTag:6]).layer.cornerRadius = 4;
            ((UILabel *)[cell viewWithTag:6]).layer.masksToBounds = YES;
            
            switch ([[NSUserDefaults standardUserDefaults] integerForKey:@"Color Theme"])
            {
                case 0:
                case 3:
                case 5:
                    ((UILabel *)[cell viewWithTag:1]).textColor = [UIColor whiteColor];
                    ((UILabel *)[cell viewWithTag:2]).textColor = [UIColor whiteColor];
                    ((UILabel *)[cell viewWithTag:3]).textColor = [UIColor whiteColor];
                    ((UILabel *)[cell viewWithTag:4]).textColor = [UIColor whiteColor];
                    ((UILabel *)[cell viewWithTag:5]).textColor = [UIColor whiteColor];
                    ((UILabel *)[cell viewWithTag:6]).textColor = [UIColor whiteColor];
                    ((UILabel *)[cell viewWithTag:6]).layer.borderColor = [UIColor whiteColor].CGColor;
                    break;
                case 1:
                    ((UILabel *)[cell viewWithTag:1]).textColor = [UIColor blackColor];
                    ((UILabel *)[cell viewWithTag:2]).textColor = [UIColor blackColor];
                    ((UILabel *)[cell viewWithTag:3]).textColor = [UIColor blackColor];
                    ((UILabel *)[cell viewWithTag:4]).textColor = [UIColor blackColor];
                    ((UILabel *)[cell viewWithTag:5]).textColor = [UIColor blackColor];
                    ((UILabel *)[cell viewWithTag:6]).textColor = [UIColor blackColor];
                    ((UILabel *)[cell viewWithTag:6]).layer.borderColor = [UIColor blackColor].CGColor;
                    break;
                case 2:
                case 4:
                    ((UILabel *)[cell viewWithTag:1]).textColor = [UIColor darkGrayColor];
                    ((UILabel *)[cell viewWithTag:2]).textColor = [UIColor darkGrayColor];
                    ((UILabel *)[cell viewWithTag:3]).textColor = [UIColor darkGrayColor];
                    ((UILabel *)[cell viewWithTag:4]).textColor = [UIColor darkGrayColor];
                    ((UILabel *)[cell viewWithTag:5]).textColor = [UIColor darkGrayColor];
                    ((UILabel *)[cell viewWithTag:6]).textColor = [UIColor darkGrayColor];
                    ((UILabel *)[cell viewWithTag:6]).layer.borderColor = [UIColor darkGrayColor].CGColor;
                    break;
            }
            
            break;
        case 2:
            cell = [tableView dequeueReusableCellWithIdentifier:@"Answer Cell"];
            
            ((UILabel *)[cell viewWithTag:1]).text = self.formula;
            ((UILabel *)[cell viewWithTag:2]).text = self.mass;
            
            switch ([[NSUserDefaults standardUserDefaults] integerForKey:@"Color Theme"])
            {
                case 0:
                case 3:
                case 5:
                    ((UILabel *)[cell viewWithTag:1]).textColor = [UIColor whiteColor];
                    ((UILabel *)[cell viewWithTag:2]).textColor = [UIColor whiteColor];
                    ((UILabel *)[cell viewWithTag:3]).textColor = [UIColor whiteColor];
                    break;
                case 1:
                    ((UILabel *)[cell viewWithTag:1]).textColor = [UIColor blackColor];
                    ((UILabel *)[cell viewWithTag:2]).textColor = [UIColor blackColor];
                    ((UILabel *)[cell viewWithTag:3]).textColor = [UIColor blackColor];
                    break;
                case 2:
                case 4:
                    ((UILabel *)[cell viewWithTag:1]).textColor = [UIColor darkGrayColor];
                    ((UILabel *)[cell viewWithTag:2]).textColor = [UIColor darkGrayColor];
                    ((UILabel *)[cell viewWithTag:3]).textColor = [UIColor darkGrayColor];
                    break;
            }
            break;
        default:
            break;
    }
    
    cell.backgroundColor = [UIColor clearColor];
    cell.userInteractionEnabled = NO;
    
    return cell;
}

- (void)displayErrorWithMessage:(NSString *)message
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:message delegate:nil cancelButtonTitle:nil otherButtonTitles:@"Dismiss", nil];
    [alert show];
}

- (void)calculateAtomsOfChemicalWithFormula:(NSString *)formula
{
    // Removes whitespace from formula.
    formula = [formula stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    // Returns error message if empty formula is given.
    if (formula.length == 0)
    {
        [self performSelectorOnMainThread:@selector(displayErrorWithMessage:) withObject:@"Error: please enter a chemical formula." waitUntilDone:NO];
        return;
    }
    
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
            
            [self addElementsOfFormula:symbolsString currentMass:&molarMass formulaCoefficient:coefficient polyatomicSubscript:1 succeeded:&succeeded];
            
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
            
            [self addElementsOfFormula:polyatomicSymbolsString currentMass:&molarMass formulaCoefficient:coefficient polyatomicSubscript:polyatomicSubscript succeeded:&succeeded];
            
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
            
            [self addElementsOfFormula:hydrateSymbolsString currentMass:&molarMass formulaCoefficient:coefficient polyatomicSubscript:hydrateCoefficient succeeded:&succeeded];
            
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
    
    [self performSelectorOnMainThread:@selector(displayWork) withObject:nil waitUntilDone:YES];
}

- (void)addElementsOfFormula:(NSString *)formula currentMass:(double *)currentMolarMass formulaCoefficient:(NSUInteger)coefficient polyatomicSubscript:(NSUInteger)polyatomicSubscript succeeded:(BOOL *)succeeded
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
            
            [self addElementsOfFormula:polyatomicSymbolsString currentMass:currentMolarMass formulaCoefficient:coefficient polyatomicSubscript:polyatomicSubscript * nestedPolyatomicSubscript succeeded:&newSucceeded];
            
            if (!newSucceeded)
            {
                return;
            }
            else
            {
                NSString *toAddFormula = [NSString stringWithFormat:@"%@%@", [formula substringToIndex:indexOfFirstParenthesis], [formula substringFromIndex:indexOfLastParenthesis]];
                
                newSucceeded = NO;
                
                [self addElementsOfFormula:toAddFormula currentMass:currentMolarMass formulaCoefficient:coefficient polyatomicSubscript:polyatomicSubscript succeeded:&newSucceeded];
                
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
                    [atomsInFormula addObject:elementInfo];
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

- (void)displayWork
{
    NSArray *elementTypes = [[NSSet setWithArray:atomsInFormula] sortedArrayUsingDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:@"Number" ascending:YES]]];
    NSMutableArray *counts = [NSMutableArray array];
    
    for (NSDictionary *elementInfo in elementTypes)
    {
        int numberOfTimesAppeared = 0;
        for (NSDictionary *element in atomsInFormula)
        {
            if ([element isEqualToDictionary:elementInfo]) numberOfTimesAppeared++;
        }
        [counts addObject:[NSNumber numberWithInt:numberOfTimesAppeared]];
    }
    
    _showWorkTable.dataSource = self;
    _showWorkTable.delegate = self;
    
    atomsInFormula = [NSMutableArray arrayWithArray:@[elementTypes, counts]];
    [_showWorkTable reloadData];
    
    [UIView animateWithDuration:0.25 animations:^{
        _showWorkTable.alpha = 1.0;
        _loadingIndicator.alpha = 0.0;
    } completion:^(BOOL finished) {
        [_loadingIndicator stopAnimating];
        _loadingIndicator.hidden = YES;
    }];
}

- (IBAction)exit:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
