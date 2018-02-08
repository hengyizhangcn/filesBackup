require("UITableViewCell");

defineClass("SCTechnologyPreResearchTableViewController", {
            viewDidLoad: function() {
            self.super().viewDidLoad();
            self.setTitle("热修复技术预研");
            self.setDataSourceArray([ "页面缓存", "SVProgressHUD显示动图", "热修复" ]);
            self.tableView().registerClass_forCellReuseIdentifier(UITableViewCell.class(), "SCTechnologyPreResearchCellIdentifier");
            self.tableView().setDelegate(self);
            self.tableView().setDataSource(self);
            }
            }, {});
