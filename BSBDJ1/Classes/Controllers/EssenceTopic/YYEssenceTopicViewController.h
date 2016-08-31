//
//  YYEssenceTopicViewController.h
//  BSBDJ1
//
//  Created by Yesi on 16/8/23.
//  Copyright © 2016年 Yesi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YYTopicModel.h"
@interface YYEssenceTopicViewController : UITableViewController

//- (YYTopicType)type;
/**
 *   *  交给子类去实现，由子类返回具体的值
 */
- (YYTopicType)type;

@end
