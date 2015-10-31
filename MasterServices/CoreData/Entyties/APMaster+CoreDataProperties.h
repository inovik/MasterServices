//
//  APMaster+CoreDataProperties.h
//  MasterServices
//
//  Created by Ivan Novikov on 31.10.15.
//  Copyright © 2015 inov. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "APMaster.h"

NS_ASSUME_NONNULL_BEGIN

@interface APMaster (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) NSString *surname;
@property (nullable, nonatomic, retain) NSSet<APService *> *services;

@end

@interface APMaster (CoreDataGeneratedAccessors)

- (void)addServicesObject:(APService *)value;
- (void)removeServicesObject:(APService *)value;
- (void)addServices:(NSSet<APService *> *)values;
- (void)removeServices:(NSSet<APService *> *)values;

@end

NS_ASSUME_NONNULL_END
