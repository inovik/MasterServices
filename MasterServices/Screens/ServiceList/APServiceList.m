//
//  APServiceList.m
//  MasterServices
//
//  Created by Ivan Novikov on 31.10.15.
//  Copyright © 2015 inov. All rights reserved.
//

#import "APServiceList.h"
#import "APServiceListModel.h"
#import "APServiceListCell.h"
#import "APNewService.h"
#import "APMaster.h"

@interface APServiceList () <UITableViewDataSource, UITableViewDelegate, SaveServiceDelegate, DeleteService>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UILabel *masterNameLabel;


@end

@implementation APServiceList

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.model addObserver:self forKeyPath:@"dataArray" options:NSKeyValueObservingOptionNew  context:nil];
    
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.model loadServices];
    self.masterNameLabel.text = [NSString stringWithFormat:@"%@ %@", self.model.master.name, self.model.master.surname];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return @"Услуги";
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 36;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return (self.model.dataArray.count) ? 0 : 44;
    }
    
    return tableView.rowHeight;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.model.dataArray.count+1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (self.model.dataArray.count && indexPath.row != 0) {
        APServiceListCell *cell = [tableView dequeueReusableCellWithIdentifier: ServiceCellID];
        [cell configureCelWithService:self.model.dataArray[indexPath.row - 1]];
        cell.delegate = self;
        return cell;
    }
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:EmptyServiceListCellID];
    cell.textLabel.text = @"Нет ни одной услуги";
    cell.userInteractionEnabled = NO;
    
    return cell;
}

-(void)saveNewServiceWithParams:(NSDictionary *)params{
    [self.model saveNewServiceWithParams:params];
}

-(void)deleteCell:(id)cell {
    
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    [self.model deleteService:self.model.dataArray[indexPath.row -1]];
    
    [self.tableView beginUpdates];
    [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    [self.tableView endUpdates];
    
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if([keyPath isEqualToString:@"dataArray"]){
        [self.tableView reloadData];
    }
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:NewServiceSegueID]) {
        APNewService *vc = segue.destinationViewController;
        vc.delegate = self;
    }
}

-(void)dealloc{
    [self.model removeObserver:self forKeyPath:@"dataArray"];
}
@end
