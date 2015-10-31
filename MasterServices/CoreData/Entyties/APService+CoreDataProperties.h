//
//  APService+CoreDataProperties.h
//  MasterServices
//
//  Created by Ivan Novikov on 31.10.15.
//  Copyright © 2015 inov. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "APService.h"

NS_ASSUME_NONNULL_BEGIN

@interface APService (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) NSString *coast;
@property (nullable, nonatomic, retain) NSString *time;
@property (nullable, nonatomic, retain) APMaster *master;

@end

NS_ASSUME_NONNULL_END
