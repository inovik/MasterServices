//
//  APNewService.m
//  MasterServices
//
//  Created by Ivan Novikov on 31.10.15.
//  Copyright © 2015 inov. All rights reserved.
//

#import "APNewService.h"
#import "APNewServiceCell.h"

@interface APNewService ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, copy) NSArray *contentArray;

@property (nonatomic, strong) UITextField *nameServiceTextField;
@property (nonatomic, strong) UITextField *timeServiceTextField;
@property (nonatomic, strong) UITextField *coastServiceTextField;

- (IBAction)saveServiceButton:(id)sender;

@end

@implementation APNewService

- (void)viewDidLoad {
    [super viewDidLoad];
    self.contentArray = @[@"Название", @"Продолжительность", @"Стоимость"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.contentArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    APNewServiceCell *cell = [tableView dequeueReusableCellWithIdentifier:NewServiceCellID];
    cell.textInputField.placeholder = self.contentArray[indexPath.row];
    
    switch (indexPath.row) {
        case 0:
            cell.textInputField.keyboardType = UIKeyboardTypeASCIICapable;
            self.nameServiceTextField = cell.textInputField;
            break;
        
        case 1:
        {
            UIDatePicker *datePicker = [[UIDatePicker alloc]init];
            datePicker.datePickerMode = UIDatePickerModeTime;

            [datePicker addTarget:self action:@selector(dateValueChanged:) forControlEvents:UIControlEventValueChanged];
            cell.textInputField.inputView = datePicker;
            self.timeServiceTextField = cell.textInputField;
            
            break;
        }
            
        case 2:
        {
            cell.textInputField.keyboardType = UIKeyboardTypeDecimalPad;
            self.coastServiceTextField = cell.textInputField;
            
            break;
        }
            
        default:
            break;
    }
    
    return cell;
}

- (void)dateValueChanged:(id) sender{
    UIDatePicker *datePicker = sender;
    NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];

    [outputFormatter setDateFormat:@"HH"];
    NSInteger hours = [[outputFormatter stringFromDate:datePicker.date] integerValue];
    
    [outputFormatter setDateFormat:@"mm"];
    NSInteger minutes = [[outputFormatter stringFromDate:datePicker.date] integerValue];
    
    NSMutableString *dateString = [[NSMutableString alloc] init];
    if(hours > 0)
        [dateString appendFormat:@"%lu ч. ", (long)hours];
    
    if(minutes > 0)
        [dateString appendFormat:@"%lu мин.", (long)minutes];

    self.timeServiceTextField.text = dateString;
}

- (IBAction)saveServiceButton:(id)sender {
    
    if([self validateInputInfo]){
        NSDictionary *params = @{@"name"  : self.nameServiceTextField.text,
                                 @"time"  : self.timeServiceTextField.text,
                                 @"coast" : self.coastServiceTextField.text};
        [self.delegate saveNewServiceWithParams:params];
        
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (BOOL)validateInputInfo{
    if ([self.nameServiceTextField.text isEqualToString:@""])
        return NO;
    
    if ([self.coastServiceTextField.text isEqualToString:@""])
        return NO;
    
    if ([self.timeServiceTextField.text isEqualToString:@""])
        return NO;
    
    return YES;
}
@end
