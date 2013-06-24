//
//  ModelBase.h
//  Steinlogic
//
//  Created by Mugunth Kumar on 26-Jul-10.
//  Copyright 2011 Steinlogic All rights reserved.
//
//  所有Model的父类, 主要是封装了KVC, 通过入参 : 数据字典 来直接反射成业务Bean
//

#import <Foundation/Foundation.h>

@interface BaseModel : NSObject <NSCoding, NSCopying, NSMutableCopying> {
  
}

-(id) initWithDictionary:(NSDictionary *)dictionaryObject;

@end
