////
////  MassCalculator.m
////  ChemWhiz
////
////  Created by Anant Jain on 10/26/15.
////  Copyright © 2015 Anant Jain. All rights reserved.
////
//
//#import "MassCalculator.h"
//
//@implementation MassCalculator
//
//- (void)calculateMolarMassOfChemicalWithFormula:(NSString *)formula
//{
//    // Removes whitespace from formula.
//    formula = [formula stringByReplacingOccurrencesOfString:@" " withString:@""];
//    
//    // Returns error message if empty formula is given.
//    if (formula.length == 0)
//    {
//        [self performSelectorOnMainThread:@selector(displayErrorWithMessage:) withObject:@"Error: please enter a chemical formula." waitUntilDone:NO];
//        return;
//    }
//    
//    tempEnteredString = [NSString stringWithString:formula];
//    
//    double molarMass = 0.0;
//    NSUInteger currentPosition = 0;
//    
//    // Determines beginning coefficient
//    NSUInteger coefficient = 1;
//    if ([formula characterAtIndex:0] >= '0' && [formula characterAtIndex:0] <= '9')
//    {
//        NSMutableString *coefficientString = [NSMutableString new];
//        for ( ; currentPosition < formula.length; currentPosition++)
//        {
//            unichar character = [formula characterAtIndex:currentPosition];
//            if (character >= '0' && character <= '9')
//            {
//                [coefficientString appendFormat:@"%c", character];
//            }
//            else
//            {
//                break;
//            }
//        }
//        coefficient = coefficientString.integerValue;
//    }
//    
//    if (currentPosition == formula.length)
//    {
//        [self performSelectorOnMainThread:@selector(displayErrorWithMessage:) withObject:@"Error: please enter a chemical formula." waitUntilDone:NO];
//        return;
//    }
//    
//    // Parsing for chemicals
//    for ( ; currentPosition < formula.length; currentPosition++)
//    {
//        unichar currentCharacter = [formula characterAtIndex:currentPosition];
//        
//        if (currentCharacter >= 'A' && currentCharacter <= 'Z')
//        {
//            NSMutableString *symbolsString = [NSMutableString new];
//            for ( ; currentPosition < formula.length; currentPosition++)
//            {
//                currentCharacter = [formula characterAtIndex:currentPosition];
//                if ((currentCharacter >= 'A' && currentCharacter <= 'Z') || (currentCharacter >= 'a' && currentCharacter <= 'z') || (currentCharacter >= '0' && currentCharacter <= '9'))
//                {
//                    [symbolsString appendFormat:@"%c", currentCharacter];
//                }
//                else
//                {
//                    currentPosition--;
//                    break;
//                }
//            }
//            
//            BOOL succeeded;
//            
//            [self addMolarMassOfFormula:symbolsString currentMass:&molarMass formulaCoefficient:coefficient polyatomicSubscript:1 succeeded:&succeeded];
//            
//            if (!succeeded)
//            {
//                return;
//            }
//        }
//        else if (currentCharacter == '(')
//        {
//            currentPosition++;
//            NSMutableString *polyatomicSymbolsString = [NSMutableString string];
//            NSUInteger polyatomicSubscript = 1;
//            BOOL hasClosingParenthesis = NO;
//            NSUInteger numberOfUnclosedParentheses = 1;
//            
//            for ( ; currentPosition < formula.length; currentPosition++)
//            {
//                currentCharacter = [formula characterAtIndex:currentPosition];
//                if ((currentCharacter >= 'A' && currentCharacter <= 'Z') || (currentCharacter >= 'a' && currentCharacter <= 'z') || (currentCharacter >= '0' && currentCharacter <= '9'))
//                {
//                    [polyatomicSymbolsString appendFormat:@"%c", currentCharacter];
//                }
//                else if (currentCharacter == '(')
//                {
//                    numberOfUnclosedParentheses++;
//                    [polyatomicSymbolsString appendFormat:@"%c", currentCharacter];
//                }
//                else if (currentCharacter == ')')
//                {
//                    numberOfUnclosedParentheses--;
//                    if (numberOfUnclosedParentheses > 0)
//                    {
//                        [polyatomicSymbolsString appendFormat:@"%c", currentCharacter];
//                    }
//                    else
//                    {
//                        hasClosingParenthesis = YES;
//                        currentPosition++;
//                        NSMutableString *polyatomicSubscriptString = [NSMutableString string];
//                        for ( ; currentPosition < formula.length; currentPosition++)
//                        {
//                            currentCharacter = [formula characterAtIndex:currentPosition];
//                            if (currentCharacter >= '0' && currentCharacter <= '9')
//                            {
//                                [polyatomicSubscriptString appendFormat:@"%c", currentCharacter];
//                            }
//                            else
//                            {
//                                currentPosition--;
//                                break;
//                            }
//                        }
//                        if (polyatomicSubscriptString.length == 0)
//                        {
//                            [self performSelectorOnMainThread:@selector(displayErrorWithMessage:) withObject:@"Error: no subscript after polyatomic ion." waitUntilDone:NO];
//                            return;
//                        }
//                        else
//                        {
//                            polyatomicSubscript = polyatomicSubscriptString.integerValue;
//                        }
//                        break;
//                    }
//                }
//                else
//                {
//                    [self performSelectorOnMainThread:@selector(displayErrorWithMessage:) withObject:[NSString stringWithFormat:@"Error: unidentified character '%c' in formula.", currentCharacter] waitUntilDone:NO];
//                    return;
//                }
//            }
//            
//            if (!hasClosingParenthesis)
//            {
//                [self performSelectorOnMainThread:@selector(displayErrorWithMessage:) withObject:@"Error: no closing parenthesis in polyatomic ion." waitUntilDone:NO];
//                return;
//            }
//            
//            BOOL succeeded;
//            
//            [self addMolarMassOfFormula:polyatomicSymbolsString currentMass:&molarMass formulaCoefficient:coefficient polyatomicSubscript:polyatomicSubscript succeeded:&succeeded];
//            
//            if (!succeeded)
//            {
//                return;
//            }
//        }
//        else if (currentCharacter == '*')
//        {
//            currentPosition++;
//            if (currentPosition == formula.length)
//            {
//                [self performSelectorOnMainThread:@selector(displayErrorWithMessage:) withObject:@"Error: no formula for hydrate." waitUntilDone:NO];
//                return;
//            }
//            
//            NSUInteger hydrateCoefficient = 1;
//            
//            if ([formula characterAtIndex:currentPosition] >= '0' && [formula characterAtIndex:currentPosition] <= '9')
//            {
//                NSMutableString *coefficientString = [NSMutableString new];
//                for ( ; currentPosition < formula.length; currentPosition++)
//                {
//                    unichar character = [formula characterAtIndex:currentPosition];
//                    if (character >= '0' && character <= '9')
//                    {
//                        [coefficientString appendFormat:@"%c", character];
//                    }
//                    else
//                    {
//                        break;
//                    }
//                }
//                hydrateCoefficient = coefficientString.integerValue;
//            }
//            
//            if (currentPosition == formula.length)
//            {
//                [self performSelectorOnMainThread:@selector(displayErrorWithMessage:) withObject:@"Error: no formula after hydrate coefficient." waitUntilDone:NO];
//                return;
//            }
//            
//            NSMutableString *hydrateSymbolsString = [NSMutableString string];
//            
//            for ( ; currentPosition < formula.length; currentPosition++)
//            {
//                currentCharacter = [formula characterAtIndex:currentPosition];
//                
//                if ((currentCharacter >= 'A' && currentCharacter <= 'Z') || (currentCharacter >= 'a' && currentCharacter <= 'z') || (currentCharacter >= '0' && currentCharacter <= '9'))
//                {
//                    [hydrateSymbolsString appendFormat:@"%c", currentCharacter];
//                }
//                else if (currentCharacter == '(')
//                {
//                    [self performSelectorOnMainThread:@selector(displayErrorWithMessage:) withObject:@"Error: hydrates cannot have polyatomic ions." waitUntilDone:NO];
//                    return;
//                }
//                else if (currentCharacter == '*')
//                {
//                    [self performSelectorOnMainThread:@selector(displayErrorWithMessage:) withObject:@"Error: hydrates cannot have hydrates within them." waitUntilDone:NO];
//                    return;
//                }
//                else
//                {
//                    [self performSelectorOnMainThread:@selector(displayErrorWithMessage:) withObject:[NSString stringWithFormat:@"Error: unidentified character '%c' in hydrate formula.", currentCharacter] waitUntilDone:NO];
//                    return;
//                }
//            }
//            
//            BOOL succeeded;
//            
//            [self addMolarMassOfFormula:hydrateSymbolsString currentMass:&molarMass formulaCoefficient:coefficient polyatomicSubscript:hydrateCoefficient succeeded:&succeeded];
//            
//            if (!succeeded)
//            {
//                return;
//            }
//        }
//        else
//        {
//            [self performSelectorOnMainThread:@selector(displayErrorWithMessage:) withObject:[NSString stringWithFormat:@"Error: unidentified character '%c' in formula.", currentCharacter] waitUntilDone:NO];
//            return;
//        }
//    }
//    
//    [self performSelectorOnMainThread:@selector(displayMolarMass:) withObject:[NSNumber numberWithDouble:molarMass] waitUntilDone:NO];
//}
//
//- (void)addMolarMassOfFormula:(NSString *)formula currentMass:(double *)currentMolarMass formulaCoefficient:(NSUInteger)coefficient polyatomicSubscript:(NSUInteger)polyatomicSubscript succeeded:(BOOL *)succeeded
//{
//    for (NSUInteger currentPosition = 0; currentPosition < formula.length; currentPosition++)
//    {
//        unichar currentCharacter = [formula characterAtIndex:currentPosition];
//        if (currentCharacter == '(')
//        {
//            NSUInteger indexOfFirstParenthesis = currentPosition;
//            NSUInteger indexOfLastParenthesis = 0;
//            currentPosition++;
//            NSMutableString *polyatomicSymbolsString = [NSMutableString string];
//            NSUInteger nestedPolyatomicSubscript = 1;
//            BOOL hasClosingParenthesis = NO;
//            NSUInteger numberOfUnclosedParentheses = 1;
//            
//            for ( ; currentPosition < formula.length; currentPosition++)
//            {
//                currentCharacter = [formula characterAtIndex:currentPosition];
//                if ((currentCharacter >= 'A' && currentCharacter <= 'Z') || (currentCharacter >= 'a' && currentCharacter <= 'z') || (currentCharacter >= '0' && currentCharacter <= '9'))
//                {
//                    [polyatomicSymbolsString appendFormat:@"%c", currentCharacter];
//                }
//                else if (currentCharacter == '(')
//                {
//                    numberOfUnclosedParentheses++;
//                    [polyatomicSymbolsString appendFormat:@"%c", currentCharacter];
//                }
//                else if (currentCharacter == ')')
//                {
//                    numberOfUnclosedParentheses--;
//                    if (numberOfUnclosedParentheses > 0)
//                    {
//                        [polyatomicSymbolsString appendFormat:@"%c", currentCharacter];
//                    }
//                    else
//                    {
//                        hasClosingParenthesis = YES;
//                        currentPosition++;
//                        NSMutableString *polyatomicSubscriptString = [NSMutableString string];
//                        for ( ; currentPosition < formula.length; currentPosition++)
//                        {
//                            currentCharacter = [formula characterAtIndex:currentPosition];
//                            if (currentCharacter >= '0' && currentCharacter <= '9')
//                            {
//                                indexOfLastParenthesis = currentPosition+1;
//                                [polyatomicSubscriptString appendFormat:@"%c", currentCharacter];
//                            }
//                            else
//                            {
//                                indexOfLastParenthesis = currentPosition;
//                                currentPosition--;
//                                break;
//                            }
//                        }
//                        
//                        if (polyatomicSubscriptString.length == 0)
//                        {
//                            [self performSelectorOnMainThread:@selector(displayErrorWithMessage:) withObject:@"Error: no subscript after polyatomic ion." waitUntilDone:NO];
//                            *succeeded = NO;
//                            return;
//                        }
//                        else
//                        {
//                            nestedPolyatomicSubscript = polyatomicSubscriptString.integerValue;
//                        }
//                        break;
//                    }
//                }
//                else
//                {
//                    [self performSelectorOnMainThread:@selector(displayErrorWithMessage:) withObject:[NSString stringWithFormat:@"Error: unidentified character '%c' in formula.", currentCharacter] waitUntilDone:NO];
//                    *succeeded = NO;
//                    return;
//                }
//            }
//            
//            if (!hasClosingParenthesis)
//            {
//                [self performSelectorOnMainThread:@selector(displayErrorWithMessage:) withObject:@"Error: no closing parenthesis in polyatomic ion." waitUntilDone:NO];
//                *succeeded = NO;
//                return;
//            }
//            
//            BOOL newSucceeded = NO;
//            
//            [self addMolarMassOfFormula:polyatomicSymbolsString currentMass:currentMolarMass formulaCoefficient:coefficient polyatomicSubscript:polyatomicSubscript * nestedPolyatomicSubscript succeeded:&newSucceeded];
//            
//            if (!newSucceeded)
//            {
//                return;
//            }
//            else
//            {
//                NSString *toAddFormula = [NSString stringWithFormat:@"%@%@", [formula substringToIndex:indexOfFirstParenthesis], [formula substringFromIndex:indexOfLastParenthesis]];
//                
//                newSucceeded = NO;
//                
//                [self addMolarMassOfFormula:toAddFormula currentMass:currentMolarMass formulaCoefficient:coefficient polyatomicSubscript:polyatomicSubscript succeeded:&newSucceeded];
//                
//                if (!newSucceeded)
//                {
//                    return;
//                }
//                
//                *succeeded = YES;
//                
//                return;
//            }
//        }
//    }
//    
//    NSDictionary *elementsDictionary = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Chemical Symbols" ofType:@"plist"]];
//    
//    // Parses for elements
//    for (NSUInteger currentPosition = 0; currentPosition < formula.length; currentPosition++)
//    {
//        unichar currentCharacter = [formula characterAtIndex:currentPosition];
//        if (currentCharacter >= 'A' && currentCharacter <= 'Z')
//        {
//            NSMutableString *elementSymbol = [NSMutableString string];
//            [elementSymbol appendFormat:@"%c", currentCharacter];
//            
//            NSUInteger elementSubscript = 1;
//            
//            currentPosition++;
//            
//            // Finds the element symbol and its subscript (if it has one)
//            for ( ; currentPosition < formula.length; currentPosition++)
//            {
//                currentCharacter = [formula characterAtIndex:currentPosition];
//                if (currentCharacter >= 'a' && currentCharacter <= 'z')
//                {
//                    [elementSymbol appendFormat:@"%c", currentCharacter];
//                }
//                if (currentCharacter >= 'A' && currentCharacter <= 'Z')
//                {
//                    currentPosition--;
//                    break;
//                }
//                else if (currentCharacter >= '0' && currentCharacter <= '9')
//                {
//                    NSMutableString *elementSubscriptString = [NSMutableString string];
//                    for ( ; currentPosition < formula.length; currentPosition++)
//                    {
//                        currentCharacter = [formula characterAtIndex:currentPosition];
//                        if (currentCharacter >= '0' && currentCharacter <= '9')
//                        {
//                            [elementSubscriptString appendFormat:@"%c", currentCharacter];
//                        }
//                        else
//                        {
//                            currentPosition--;
//                            break;
//                        }
//                    }
//                    elementSubscript = elementSubscriptString.integerValue;
//                    break;
//                }
//            }
//            
//            // Checks if symbol exists and adds it if it does
//            NSDictionary *elementInfo = [elementsDictionary objectForKey:elementSymbol];
//            if (elementInfo)
//            {
//                // Adds the element name enough times as outlined by coefficient, elementSubscript, and polyatomicSubscript
//                for (NSInteger i = 0; i < elementSubscript * coefficient * polyatomicSubscript; i++)
//                {
//                    *currentMolarMass += [[elementInfo objectForKey:@"Mass"] doubleValue];
//                }
//            }
//            else
//            {
//                [self performSelectorOnMainThread:@selector(displayErrorWithMessage:) withObject:[NSString stringWithFormat:@"Error: element symbol %@ does not exist.", elementSymbol] waitUntilDone:NO];
//                *succeeded = NO;
//                return;
//            }
//        }
//        else
//        {
//            [self performSelectorOnMainThread:@selector(displayErrorWithMessage:) withObject:@"Error: unidentified element symbol. Check capitalization." waitUntilDone:NO];
//            *succeeded = NO;
//            return;
//        }
//    }
//    *succeeded = YES;
//}
//
//@end
