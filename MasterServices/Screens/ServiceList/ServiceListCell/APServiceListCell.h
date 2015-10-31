//
//  APServiceListCell.h
//  MasterServices
//
//  Created by Ivan Novikov on 31.10.15.
//  Copyright © 2015 inov. All rights reserved.
//

#import <UIKit/UIKit.h>

@class APService;

@protocol DeleteService <NSObject>

@required
- (void)deleteCell:(id)cell;
@end

@interface APServiceListCell : UITableViewCell

@property (strong, nonatomic) APService *service;
@property (nonatomic, weak) id<DeleteService> delegate;

- (IBAction)deleteServiceButton:(id)sender;
- (void)configureCelWithService:(APService *)service;

@end
