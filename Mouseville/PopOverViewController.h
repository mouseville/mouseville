//
//  PopOverViewController.h
//  Mouseville
//
//  Created by Abhang Sonawane on 3/29/14.
//  Copyright (c) 2014 CapstoneProject. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol DropDownDelegate
-(void)didClickDropdown:(NSString*)string  ;
@end

@interface PopOverViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, copy) NSArray * arrData;
@property (nonatomic, copy) NSString* identifier;
@property (nonatomic, assign) id<DropDownDelegate> delegate;
@end
