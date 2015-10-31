//
//  APNewService.h
//  MasterServices
//
//  Created by Ivan Novikov on 31.10.15.
//  Copyright © 2015 inov. All rights reserved.
//

#import <UIKit/UIKit.h>

@class APNewServiceModel;

@protocol SaveServiceDelegate <NSObject>

@required

- (void)saveNewServiceWithParams:(NSDictionary *)params;

@end

@interface APNewService : UIViewController

@property (nonatomic, strong) APNewServiceModel *model;
@property (nonatomic, weak) id<SaveServiceDelegate> delegate;
@end
