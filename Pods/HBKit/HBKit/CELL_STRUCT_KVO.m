//
//  CELL_STRUCT_KVO.m
//  PENG
//
//  Created by 跑酷 on 15/6/15.
//  Copyright (c) 2015年 nonato. All rights reserved.
//

#import "CELL_STRUCT_KVO.h"
#import "CELL_STRUCT.h"
#import <objc/runtime.h>

@implementation UIViewController(CELL_STRUCT_KVO)

static char cellstruct_OperationKey;

-(void)setObservedKeyPaths:(id)paths
{
    objc_setAssociatedObject(self, &cellstruct_OperationKey,paths, OBJC_ASSOCIATION_RETAIN);
}

-(id)getObservedKeyPaths
{
    return objc_getAssociatedObject(self, &cellstruct_OperationKey);
}

- (NSSet *)cellstruct_observedKeyPaths {
    
    unsigned int outCount = 0;
    NSMutableArray * propertlist = [self getObservedKeyPaths];
    if (!propertlist) {
        propertlist = [NSMutableArray new];
        objc_property_t *properties = class_copyPropertyList([CELL_STRUCT class], &outCount);
        for (int i = 0; i < outCount; i++) {
            
            objc_property_t property = properties[i];
            NSString *key=[[NSString alloc] initWithCString:property_getName(property)
                                                   encoding:NSUTF8StringEncoding];
            [propertlist addObject:key];
        }
        [self setObservedKeyPaths:propertlist];
    }
    return [NSSet setWithArray:propertlist];
}

- (NSKeyValueObservingOptions) cellstruct_observationOptions {
    return (NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld);
}

- (void) beginObservingValuesForKeyPaths:(id<NSFastEnumeration>)keyPaths options:(NSKeyValueObservingOptions)options cellstructs:(NSArray *)array {
    for (NSString *keyPath in keyPaths){
        for (CELL_STRUCT * cellstruct in array) {
            [cellstruct addObserver:self forKeyPath:keyPath options:options context:(void *)self];
        }
    }
}

- (void) endObservingValuesForKeysPaths:(id<NSFastEnumeration>)keyPaths cellstructs:(NSArray *)array {
    for (NSString *keyPath in keyPaths){
         for (CELL_STRUCT * cellstruct in array) {
             [cellstruct removeObserver:self forKeyPath:keyPath context:(void *)self];
         }
    }
}

- (void) observeValueForKeyPath:(NSString *) keyPath ofObject: (id) object change: (NSDictionary *) change context: (void *) context {
    if (context == (__bridge void *)self){
        if ([[self cellstruct_observedKeyPaths] containsObject:keyPath]){
            [self handle_cell_struct_datachange:keyPath];
            [self handle_cell_struct_datachange:(CELL_STRUCT *)object keypath:keyPath];
            //TODO:相应的变化
        }
    } else {
        [super observeValueForKeyPath: keyPath ofObject: object change: change context: context];
    }
}

-(void)handle_cell_struct_datachange:(NSString *) keyPath
{
    
}
-(void)handle_cell_struct_datachange:(CELL_STRUCT *)cellstruct keypath:(NSString *) keyPath
{
    
}
@end
