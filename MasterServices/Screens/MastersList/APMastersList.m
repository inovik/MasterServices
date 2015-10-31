//
//  APMastersList.m
//  MasterServices
//
//  Created by Ivan Novikov on 31.10.15.
//  Copyright © 2015 inov. All rights reserved.
//

#import "APMastersList.h"
#import "APMastersListModel.h"
#import "APMaster.h"
#import "APServiceList.h"
#import "APServiceListModel.h"

@interface APMastersList () <UITableViewDelegate, UITableViewDataSource>

- (IBAction)addMasterButtonPressed:(id)sender;
@property (nonatomic, strong) APMastersListModel *model;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UILabel *emptyTableInfoLabel;

@end

@implementation APMastersList

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.model = [[APMastersListModel alloc] init];
    [self.model addObserver:self forKeyPath:@"dataArray" options:NSKeyValueObservingOptionNew context:nil];
}

#pragma mark TableView delegates methods
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    [self showEmptyTablePlaceHolder:!self.model.dataArray.count];
    return self.model.dataArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: MasterCellID];
    APMaster *master = self.model.dataArray[indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"%@ %@", master.name, master.surname];
    return cell;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        APMaster *master = [self.model.dataArray objectAtIndex:indexPath.row];
        [self.model.dataArray removeObject:master];
        [self.model deleteMaster:master];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        [self showEmptyTablePlaceHolder:!self.model.dataArray.count];
    }
}

- (void)showEmptyTablePlaceHolder:(BOOL) value{
    NSInteger valueForTable = (value) ? 0 : 1;
    NSInteger valueForPlaceHolder = (value) ? 1 : 0;
    self.emptyTableInfoLabel.hidden = !value;
    float duringTime = (value) ? 1.f : 0.3f;
    
    [UIView animateWithDuration:duringTime animations:^{
        self.tableView.alpha = valueForTable;
        self.emptyTableInfoLabel.alpha = valueForPlaceHolder;
    }];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"dataArray"]) {
        [self.tableView reloadData];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)addMasterButtonPressed:(id)sender {
    
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    [dict setObject:@"Ivan" forKey:@"name"];
    [dict setObject:@"Novikov  " forKey:@"surname"];
    [self.model addNewMasterWithParam:dict];
    
    [dict setObject:@"Dmitriy" forKey:@"name"];
    [dict setObject:@"Busov  " forKey:@"surname"];
    [self.model addNewMasterWithParam:dict];
    
    [dict setObject:@"Igor" forKey:@"name"];
    [dict setObject:@"Juk  " forKey:@"surname"];
    [self.model addNewMasterWithParam:dict];
    
    [self.model loadMastersData];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    
    APServiceList *vc = segue.destinationViewController;
    vc.model = [[APServiceListModel alloc] initWithMaster:self.model.dataArray[indexPath.row]];
}

-(void)dealloc{
    [self.model removeObserver:self forKeyPath:@"dataArray"];
}

@end
