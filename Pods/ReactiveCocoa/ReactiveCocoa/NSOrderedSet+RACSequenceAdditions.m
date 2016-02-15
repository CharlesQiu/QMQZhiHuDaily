//
//  NSOrderedSet+RACSequenceAdditions.m
//  ReactiveCocoa
//
//  Created by Justin Spahr-Summers on 2012-10-29.
//  Copyright (c) 2012 GitHub. All rights reserved.
//

#import "NSOrderedSet+RACSequenceAdditions.h"
#import "NSArray+RACSequenceAdditions.h"

@implementation NSOrderedSet (RACSequenceAdditions)

- (RACSequence *)rac_sequence {

    return self.array.rac_sequence;
}

@end
