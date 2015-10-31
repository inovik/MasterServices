//
//  CoreDataManager.h
//  MasterServices
//
//  Created by Ivan Novikov on 31.10.15.
//  Copyright © 2015 inov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class APMaster;
@class APService;

#define CoreData [CoreDataManager sharedInstance]
@interface CoreDataManager : NSObject

+(instancetype) sharedInstance;

+(instancetype) alloc __attribute__((unavailable("alloc not available, call sharedInstance instead")));
-(instancetype) init __attribute__((unavailable("init not available, call sharedInstance instead")));
+(instancetype) new __attribute__((unavailable("new not available, call sharedInstance instead")));

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

- (NSArray *)loadMasters;
- (void)addNewMasterWithParams:(NSDictionary *)params;
- (void)deleteMaster:(APMaster *)master;

- (void)addNewServiceWithParams:(NSDictionary *)params toMaster:(APMaster *)master;
- (void)deleteService:(APService *)service;

@end
