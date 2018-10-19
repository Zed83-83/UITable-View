//
//  ViewController.h
//  UITable View
//
//  Created by Zed Zezhenko on 30.08.2018.
//  Copyright © 2018 Zed Zezhenko. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import <UIKit/UISpringLoadedInteractionSupporting.h>
#import <UIKit/UIViewController.h>
#import "TableViewController.h"

@interface ViewController : UIViewController <UITextViewDelegate>


@property (strong, nonatomic) NSString *labelText;
@property (retain, nonatomic) IBOutlet UITextView *textView;
@property (retain, nonatomic) IBOutlet UILabel *label;






@end
