//
//  NSDictionary+Extension.h
//  SomeFunction
//
//  Created by 李震 on 16/8/5.
//  Copyright © 2016年 lizhen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (Extension)

- (id)getValue:(NSString *)key as:(Class)type;

- (id)getValue:(NSString *)key as:(Class)type defaultValue:(id)defaultValue;



@end
