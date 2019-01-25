//
//  Person.h
//  PreferenceStoreDemo
//
//  Created by doxie on 1/15/19.
//  Copyright © 2019 Xie. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Person : NSObject<NSSecureCoding>
    @property NSString *name;
    @property NSInteger age;

@end

