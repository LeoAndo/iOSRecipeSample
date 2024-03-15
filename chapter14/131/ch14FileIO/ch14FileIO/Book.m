//
//  Book.m
//  ch14FileIO
//
//  Created by HU QIAO on 2014/01/23.
//  Copyright (c) 2014年 shoeisha. All rights reserved.
//

#import "Book.h"

@implementation Book

- (id)initWithCoder:(NSCoder *)decoder {
    self = [super init];
    if (!self) {
        return nil;
    }
    
    self.title = [decoder decodeObjectForKey:@"title"];
    self.author = [decoder decodeObjectForKey:@"author"];
    
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeObject:self.title forKey:@"title"];
    [encoder encodeObject:self.author forKey:@"author"];

}

@end

