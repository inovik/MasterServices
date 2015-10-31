//
//  APServiceListModel.h
//  MasterServices
//
//  Created by Ivan Novikov on 31.10.15.
//  Copyright © 2015 inov. All rights reserved.
//

#import <Foundation/Foundation.h>

@class APMaster;

@interface APServiceListModel : NSObject

@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) APMaster *master;

- (instancetype)initWithMaster:(APMaster *)master;

- (void)loadServices;
- (void)saveNewServiceWithParams:(NSDictionary *)params;
- (void)deleteService:(APService *)service;

@end
