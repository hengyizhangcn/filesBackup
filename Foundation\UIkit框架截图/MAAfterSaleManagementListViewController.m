//
//  MAAfterSaleManagementListViewController.m
//  MerchantAide
//
//  Created by zhy on 01/07/2017.
//  Copyright © 2017 UAMA. All rights reserved.
//

#import "MAAfterSaleManagementListViewController.h"
#import "MAAfterSaleManagementApplyInfoCell.h"
#import "MAAfterSaleManagementApplyReasonCell.h"

@interface MAAfterSaleManagementListViewController ()

@end

@implementation MAAfterSaleManagementListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.tableView registerNib:[UINib nibWithNibName:[MAAfterSaleManagementApplyInfoCell sc_className] bundle:nil] forCellReuseIdentifier:[MAAfterSaleManagementApplyInfoCell sc_className]];
    [self.tableView registerNib:[UINib nibWithNibName:[MAAfterSaleManagementApplyReasonCell sc_className] bundle:nil] forCellReuseIdentifier:[MAAfterSaleManagementApplyReasonCell sc_className]];
}

#pragma mark - UITableViewDelegate/UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        MAAfterSaleManagementApplyInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:[MAAfterSaleManagementApplyInfoCell sc_className] forIndexPath:indexPath];
        return cell;
    } else {
        MAAfterSaleManagementApplyReasonCell *cell = [tableView dequeueReusableCellWithIdentifier:[MAAfterSaleManagementApplyReasonCell sc_className] forIndexPath:indexPath];
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return 115;
    } else {
        return 35;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 8;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return CGFLOAT_MIN;
}

@end
