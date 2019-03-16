//
//  testView.m
//  recooative
//
//  Created by 张闯闯 on 2019/3/15.
//  Copyright © 2019 张闯闯. All rights reserved.
//

#import "testView.h"
@interface testView()

@end
@implementation testView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUI];
    }
    return self;
}
-(void)setUI{
    UIButton *btn  =[UIButton buttonWithType:UIButtonTypeCustom];
    [btn setFrame:CGRectMake(40, 40, 100, 40)];
    [btn setTitle:@"点击我进行传值" forState:UIControlStateNormal];
    [btn setBackgroundColor:[UIColor redColor]];
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:btn];
}
-(void)setBtn{
    
}

-(void)btnClick:(UIButton *)senter{
    if (self.delegateSignal) {
        [self.delegateSignal sendNext:@"3000"];
    }
}
@end
