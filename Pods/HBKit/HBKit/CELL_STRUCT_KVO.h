//
//  CELL_STRUCT_KVO.h
//  PENG
//
//  Created by 跑酷 on 15/6/15.
//  Copyright (c) 2015年 nonato. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CELL_STRUCT.h"
#define ADD_CELLSTRUCT_KVO(CELLSTRUCTARRAY) [self beginObservingValuesForKeyPaths:[self  cellstruct_observedKeyPaths] options:[self cellstruct_observationOptions] cellstructs:CELLSTRUCTARRAY];

#define REMOVE_CELLSTRUCT_KVO(CELLSTRUCTARRAY) [self endObservingValuesForKeysPaths:[self cellstruct_observedKeyPaths] cellstructs:CELLSTRUCTARRAY];

#define ON_CELLSTRUCT_HANDEL_KVO(KEYPATH) -(void)handle_cell_struct_datachange:(NSString *)KEYPATH

#define ON_CELLSTRUCT_HANDEL_KVO_CELLSTRUCT_KEYPATH(CELLSTRUCT,KEYPATH) -(void)handle_cell_struct_datachange:(CELL_STRUCT *)CELLSTRUCT  keypath:(NSString *)KEYPATH
@interface UIViewController(CELL_STRUCT_KVO)

- (NSSet *)cellstruct_observedKeyPaths;
- (NSKeyValueObservingOptions)cellstruct_observationOptions;

- (void) beginObservingValuesForKeyPaths:(id<NSFastEnumeration>)keyPaths options:(NSKeyValueObservingOptions)options cellstructs:(NSArray *)array;
- (void) endObservingValuesForKeysPaths:(id<NSFastEnumeration>)keyPaths cellstructs:(NSArray *)array;

/**
 * 可能执行多次
 */
-(void)handle_cell_struct_datachange:(NSString *) keyPath;
-(void)handle_cell_struct_datachange:(CELL_STRUCT *)cellstruct keypath:(NSString *) keyPath;
@end
