//
//  MolarMassCalculator.h
//  ChemWhiz
//
//  Created by Anant Jain on 11/26/15.
//  Copyright © 2015 Anant Jain. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MolarMassCalculator : NSObject

+ (NSDictionary<NSString *, id> * _Nonnull)elementsFromFormula:(NSString * _Nonnull)formula;
+ (double)molarMassFromElements:(NSDictionary<NSString *, id> * _Nonnull)elements;
+ (double)molarMassFromFormula:(NSString * _Nonnull)formula;

+ (NSDictionary<NSString *, id> * _Nonnull)addMolarMassOfFormula:(NSString * _Nonnull)formula currentElements:(NSMutableDictionary<NSString *, id> * _Nonnull)currentElements formulaCoefficient:(NSUInteger)coefficient polyatomicSubscript:(NSUInteger)polyatomicSubscript;

@end
