//
//  GrowAnimatedTransition.h
//  ChemWhiz
//
//  Created by Anant Jain on 4/18/14.
//  Copyright (c) 2014 Anant Jain. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GrowAnimatedTransition : NSObject <UIViewControllerAnimatedTransitioning>

@property BOOL presenting;
@property CGRect backgroundRectFrame;

@end
