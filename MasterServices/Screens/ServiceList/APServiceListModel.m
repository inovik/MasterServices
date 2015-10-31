//
//  APServiceListModel.m
//  MasterServices
//
//  Created by Ivan Novikov on 31.10.15.
//  Copyright © 2015 inov. All rights reserved.
//

#import "APServiceListModel.h"
#import "APMaster.h"

@implementation APServiceListModel

- (instancetype)initWithMaster:(APMaster *)master{
    self = [super init];
    if (self) {
        self.master = master;
        [self loadServices];
    }
    
    return self;
}

- (void)loadServices{
     self.dataArray = [NSMutableArray arrayWithArray:[self.master.services allObjects]];
}

- (void)saveNewServiceWithParams:(NSDictionary *)params{
    [CoreData addNewServiceWithParams:params toMaster:self.master];
}

- (void)deleteService:(APService *)service{
    [self.dataArray removeObject:service];
    [CoreData deleteService:service];
}
@end
