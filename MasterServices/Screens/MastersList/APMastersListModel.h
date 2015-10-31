//
//  APMastersListModel.h
//  MasterServices
//
//  Created by Ivan Novikov on 31.10.15.
//  Copyright © 2015 inov. All rights reserved.
//

#import <Foundation/Foundation.h>

@class APMaster;

@interface APMastersListModel : NSObject

@property (nonatomic, strong) NSMutableArray *dataArray;

- (NSArray *)loadMastersData;
- (void)addNewMasterWithParam:(NSDictionary *)params;
- (void)deleteMaster:(APMaster *)master;

@end
