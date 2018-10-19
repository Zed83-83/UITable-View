//
//  TableViewController.m
//  UITable View
//
//  Created by Zed Zezhenko on 28.08.2018.
//  Copyright © 2018 Zed Zezhenko. All rights reserved.
//

#import "TableViewController.h"
#import "ViewController.h"

@interface TableViewController  ()
<
UITableViewDataSource,
UITabBarDelegate
> 

@end

@implementation TableViewController



- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.table.delegate = self;
    self.table.dataSource=self;
    self.title = @"List";
    
    self.dataArray = [[NSMutableArray alloc]initWithObjects:@"машина", @"самолет",@"велосипед",@" самокат",@"ролики",nil];
  
    
    NSArray *array = [[NSUserDefaults standardUserDefaults] objectForKey:@"yourUniqueKey"];
    
    if (array)
    {
        self.dataArray = [array mutableCopy];
    }
    else
    {
        self.dataArray = [[NSMutableArray alloc]initWithObjects:@"машина", @"самолет",@"велосипед",@" самокат",@"ролики",nil];
    }
    
   

    [self arraysFunction:array mutArray:nil];
    [self arraysFunction:nil mutArray:_dataArray];
}
        
        

        
-(void)arraysFunction:(NSArray*)array  mutArray:(NSMutableArray*)dataArray{
        
        if (array == nil || [array count] == 0)  {
            
            [[NSUserDefaults standardUserDefaults] setObject:dataArray forKey:@"mutableArray"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            
            NSLog(@"Mutable Array: %@",[[NSUserDefaults standardUserDefaults] objectForKey:@"mutableArray"]);
            
            NSArray * simpleArray = [ NSArray arrayWithArray:[[NSUserDefaults standardUserDefaults] objectForKey:@"mutableArray"]];
            
            NSLog(@"Simple Array: %@", simpleArray);
        }
        else{
            
            [[NSUserDefaults standardUserDefaults] setObject:array forKey:@"array"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            
            NSLog(@"Simple Array: %@",[[NSUserDefaults standardUserDefaults] objectForKey:@"array"]);
            
            NSMutableArray * mutableArray = [NSMutableArray arrayWithArray:[[[NSUserDefaults standardUserDefaults] objectForKey:@"array"] mutableCopy]];
            
            NSLog(@"Mutable Array: %@", mutableArray);
            
            

        }
    }

- (void)didReceiveMemoryWarning
    
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

// количество секций
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

//колисчество строк в секции
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return[self.dataArray count];
}

//создаем ячейку
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell";
    UITableViewCell *cell;
    cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if(cell == nil)
    {
        cell = [[ UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.textLabel.text = [self.dataArray objectAtIndex:indexPath.row];
    
    return cell ;
}

// удаляем строки
- (void)tableView:(UITableView *)tableView
commitEditingStyle:(UITableViewCellEditingStyle)editingStyle
forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        [self.dataArray removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath]
                         withRowAnimation:UITableViewRowAnimationFade];
    }
}
//перемешаем Строки
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}
//перемешаем строки в архиве
- (void)tableView:(UITableView *)tableView
moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath
      toIndexPath:(NSIndexPath *)destinationIndexPath
{
    [self.dataArray exchangeObjectAtIndex:sourceIndexPath.row withObjectAtIndex:destinationIndexPath.row];
}

#pragma mark - Teble View Deligate

//обрабатываем нажатие на ячейку и переходим в следуюший контролер

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    TableViewController * controller = [self.storyboard instantiateViewControllerWithIdentifier:@"ViewController"];
    
  //  ViewController.labelText = [_dataArray objectAtIndex:indexPath.row];
    
    [self.navigationController pushViewController:controller animated:YES];
    
}


#pragma mark - Action

// редактирование полей 
- (IBAction)edit:(id)sender
{
    [self.tableView setEditing:!self.tableView.editing animated:YES];
}

//  по нажатю на кнопку добавляем поле
- (IBAction)pushAddAction:(id)sender
{
    // создали Alert контролер с сторокой заполнения
    UIAlertController *alertController = [UIAlertController
                                          alertControllerWithTitle:@"Enter Text"
                                          message:@""
                                          preferredStyle:UIAlertControllerStyleAlert];
    
    [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField)
     {
         textField.placeholder = NSLocalizedString(@"TEXT", );
         textField.keyboardType = UIKeyboardTypeDefault;
     }];
    UIAlertAction *cancelAction = [UIAlertAction
                                   actionWithTitle:NSLocalizedString(@"Cancel", @"Cancel action")
                                   style:UIAlertActionStyleCancel
                                   handler:^(UIAlertAction *action)
                                   {
                                       NSLog(@"Cancel action");
                                   }];
    
    UIAlertAction *okAction = [UIAlertAction
                               actionWithTitle:NSLocalizedString(@"OK", @"OK action")
                               style:UIAlertActionStyleDefault
                               handler:^(UIAlertAction *action)
                               {
                                   UITextField *textField = alertController.textFields[0];
                                   NSLog(@"text was %@", textField.text);
                                   [self.dataArray addObject:textField.text];
                                   [[NSUserDefaults standardUserDefaults] setObject:self.dataArray forKey:@"yourUniqueKey"];
                                   [[NSUserDefaults standardUserDefaults] synchronize];
                                   [self.table reloadData];
                                   
                               }];
    
    [alertController addAction:cancelAction];
    [alertController addAction:okAction];

    [self presentViewController:alertController animated:YES completion:nil];
    
}
@end
