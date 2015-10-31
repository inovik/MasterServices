//
//  APServiceListCell.m
//  MasterServices
//
//  Created by Ivan Novikov on 31.10.15.
//  Copyright © 2015 inov. All rights reserved.
//

#import "APServiceListCell.h"
#import "APService.h"

@interface APServiceListCell ()

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *infoLabel;

@end

@implementation APServiceListCell

- (IBAction)deleteServiceButton:(id)sender {
    [self.delegate deleteCell:self];
}

- (void)configureCelWithService:(APService *)service{
    self.service = service;
    self.nameLabel.text = service.name;
    self.infoLabel.text = [NSString stringWithFormat:@"%@, %@ руб.", service.time, service.coast];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
