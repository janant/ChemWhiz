//
//  MolarMassCalculator.m
//  ChemWhiz
//
//  Created by Anant Jain on 11/26/15.
//  Copyright © 2015 Anant Jain. All rights reserved.
//

#import "MolarMassCalculator.h"

@implementation MolarMassCalculator

+ (NSDictionary<NSString *, id> * _Nonnull)elementsFromFormula:(NSString * _Nonnull)formula
{
    // Removes whitespace from formula.
    formula = [formula stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    // Returns error message if empty formula is given.
    if (formula.length == 0)
    {
        return [NSDictionary dictionaryWithObject:@"Error: please enter a chemical formula." forKey:@"Error"];
    }
    
    NSUInteger currentPosition = 0;
    
    NSMutableDictionary *currentElements = [NSMutableDictionary dictionary];
    
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
        return [NSDictionary dictionaryWithObject:@"Error: please enter a chemical formula." forKey:@"Error"];
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
            
            NSDictionary *error = [self addMolarMassOfFormula:symbolsString currentElements:currentElements formulaCoefficient:coefficient polyatomicSubscript:1];
            
            if (error[@"Error"] != nil) return error;
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
                            return [NSDictionary dictionaryWithObject:@"Error: no subscript after polyatomic ion." forKey:@"Error"];
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
                    return [NSDictionary dictionaryWithObject:[NSString stringWithFormat:@"Error: unidentified character '%c' in formula.", currentCharacter] forKey:@"Error"];
                }
            }
            
            if (!hasClosingParenthesis)
            {
                return [NSDictionary dictionaryWithObject:@"Error: no closing parenthesis in polyatomic ion." forKey:@"Error"];
            }
            
            NSDictionary *error = [self addMolarMassOfFormula:polyatomicSymbolsString currentElements:currentElements formulaCoefficient:coefficient polyatomicSubscript:polyatomicSubscript];
            
            if (error[@"Error"] != nil) return error;
        }
        else if (currentCharacter == '*' || currentCharacter == 0x00B7)
        {
            currentPosition++;
            if (currentPosition == formula.length)
            {
                return [NSDictionary dictionaryWithObject:@"Error: no formula for hydrate." forKey:@"Error"];
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
                return [NSDictionary dictionaryWithObject:@"Error: no formula after hydrate coefficient." forKey:@"Error"];
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
                    return [NSDictionary dictionaryWithObject:@"Error: hydrates cannot have polyatomic ions." forKey:@"Error"];
                }
                else if (currentCharacter == '*' || currentCharacter == 0x00B7)
                {
                    return [NSDictionary dictionaryWithObject:@"Error: hydrates cannot have hydrates within them." forKey:@"Error"];
                }
                else
                {
                    return [NSDictionary dictionaryWithObject:[NSString stringWithFormat:@"Error: unidentified character '%c' in hydrate formula.", currentCharacter] forKey:@"Error"];
                }
            }
            
            NSDictionary *error = [self addMolarMassOfFormula:hydrateSymbolsString currentElements:currentElements formulaCoefficient:coefficient polyatomicSubscript:hydrateCoefficient];
            
            if (error[@"Error"] != nil) return error;
        }
        else
        {
            return [NSDictionary dictionaryWithObject:[NSString stringWithFormat:@"Error: unidentified character '%c' in formula.", currentCharacter] forKey:@"Error"];
        }
    }
    
    currentElements[@"Formula"] = formula;
    return currentElements;
}

+ (double)molarMassFromElements:(NSDictionary<NSString *, id> *)elements {
    NSArray *allSymbols = elements.allKeys;
    double molarMass = 0.0;
    
    NSDictionary *elementsDictionary = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Chemical Symbols" ofType:@"plist"]];
    
    for (NSString *symbol in allSymbols) {
        if ([symbol isEqualToString:@"Formula"]) continue;
        else {
            molarMass += [[[elementsDictionary objectForKey:symbol] objectForKey:@"Mass"] doubleValue] * [elements[symbol] doubleValue];
        }
    }
    
    return molarMass;
}

+ (double)molarMassFromFormula:(NSString *)formula {
    return [self molarMassFromElements:[self elementsFromFormula:formula]];
}

+ (NSDictionary<NSString *, id> * _Nonnull)addMolarMassOfFormula:(NSString * _Nonnull)formula currentElements:(NSMutableDictionary<NSString *, id> * _Nonnull)currentElements formulaCoefficient:(NSUInteger)coefficient polyatomicSubscript:(NSUInteger)polyatomicSubscript
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
                            return [NSDictionary dictionaryWithObject:@"Error: no subscript after polyatomic ion." forKey:@"Error"];
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
                    return [NSDictionary dictionaryWithObject:[NSString stringWithFormat:@"Error: unidentified character '%c' in formula.", currentCharacter] forKey:@"Error"];
                }
            }
            
            if (!hasClosingParenthesis)
            {
                return [NSDictionary dictionaryWithObject:@"Error: no closing parenthesis in polyatomic ion." forKey:@"Error"];
            }
            
            NSDictionary *error = [self addMolarMassOfFormula:polyatomicSymbolsString currentElements:currentElements formulaCoefficient:coefficient polyatomicSubscript:polyatomicSubscript * nestedPolyatomicSubscript];
            
            if (error[@"Error"] != nil) return error;
            else
            {
                NSString *toAddFormula = [NSString stringWithFormat:@"%@%@", [formula substringToIndex:indexOfFirstParenthesis], [formula substringFromIndex:indexOfLastParenthesis]];
                
                NSDictionary *error = [self addMolarMassOfFormula:toAddFormula currentElements:currentElements formulaCoefficient:coefficient polyatomicSubscript:polyatomicSubscript];
                if (error[@"Error"] != nil) return error;
                
                return currentElements;
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
                if (currentElements[elementSymbol] == nil) {
                    [currentElements setObject:[NSNumber numberWithInt:(int)(elementSubscript * coefficient * polyatomicSubscript)] forKey:elementSymbol];
                }
                else {
                    int current = ((NSNumber *)currentElements[elementSymbol]).intValue;
                    int new = current + (int)(elementSubscript * coefficient * polyatomicSubscript);
                    
                    currentElements[elementSymbol] = [NSNumber numberWithInt:new];
                }
            }
            else
            {
                return [NSDictionary dictionaryWithObject:[NSString stringWithFormat:@"Error: element symbol %@ does not exist.", elementSymbol] forKey:@"Error"];
            }
        }
        else
        {
            return [NSDictionary dictionaryWithObject:@"Error: unidentified element symbol. Check capitalization." forKey:@"Error"];
        }
    }
    return currentElements;
}

@end
