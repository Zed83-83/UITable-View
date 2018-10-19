//
//  TableViewController.h
//  UITable View
//
//  Created by Zed Zezhenko on 28.08.2018.
//  Copyright © 2018 Zed Zezhenko. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import <UIKit/UISpringLoadedInteractionSupporting.h>
#import <UIKit/UIViewController.h>
#import "ViewController.h"

@interface TableViewController : UITableViewController

- (IBAction)edit:(id)sender;

- (IBAction)pushAddAction:(id)sender;

@property (weak, nonatomic) IBOutlet UITableView *table;
@property (strong, nonatomic) NSMutableArray *dataArray;
@property (strong, nonatomic) NSArray *array;
@property (strong, nonatomic) UITableViewCell *cell;

@end
