//
//  Person.m
//  PreferenceStoreDemo
//
//  Created by doxie on 1/15/19.
//  Copyright © 2019 Xie. All rights reserved.
//

#import "Person.h"

@implementation Person


- (void)encodeWithCoder:(nonnull NSCoder *)aCoder {
    [aCoder encodeObject:self.name forKey:@"name"];
    [aCoder encodeInteger:self.age forKey:@"age"];
}

- (nullable instancetype)initWithCoder:(nonnull NSCoder *)aDecoder {
    self = [super init];
    if(self) {
        self.name = [aDecoder decodeObjectForKey:@"name"];
        self.age = [aDecoder decodeIntegerForKey:@"age"];
    }

    return self;
}

    @end
