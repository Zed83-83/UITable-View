//
//  ViewController.m
//  UITable View
//
//  Created by Zed Zezhenko on 30.08.2018.
//  Copyright © 2018 Zed Zezhenko. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()


@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
     self.title = @"";
    
  // сохраняем текс
    NSString *stringKey = [[NSUserDefaults standardUserDefaults] stringForKey:@"key"];
    self.textView.text = stringKey;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


// сварачиваем клавиатуру по кнопке ввод
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"])
    {
        [textView resignFirstResponder];
        
        //сохраняем текст по шажатию на кнопку готово
        NSString *textToSave = textView.text;
        [[NSUserDefaults standardUserDefaults] setObject:textToSave forKey:@"key"];
        [[NSUserDefaults standardUserDefaults] synchronize];
         
        return NO;
    }
    return YES;
}



@end 
