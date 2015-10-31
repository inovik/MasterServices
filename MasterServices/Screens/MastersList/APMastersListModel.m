//
//  APMastersListModel.m
//  MasterServices
//
//  Created by Ivan Novikov on 31.10.15.
//  Copyright © 2015 inov. All rights reserved.
//

#import "APMastersListModel.h"

@implementation APMastersListModel

-(instancetype)init{
    self = [super init];
    if (self) {
        [self loadMastersData];
    }
    return self;
}

- (NSArray *)loadMastersData{
    self.dataArray = [NSMutableArray arrayWithArray:[CoreData loadMasters]];
    return self.dataArray;
}

- (void)addNewMasterWithParam:(NSDictionary *)params{
    [CoreData addNewMasterWithParams:params];
}

- (void)deleteMaster:(APMaster *)master{
    [CoreData deleteMaster:master];
}

@end
