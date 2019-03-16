//
//  testView.h
//  recooative
//
//  Created by 张闯闯 on 2019/3/15.
//  Copyright © 2019 张闯闯. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface testView : UIView
@property (nonatomic, strong) RACSubject *delegateSignal;
@end

NS_ASSUME_NONNULL_END
