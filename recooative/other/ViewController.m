//
//  ViewController.m
//  recooative
//
//  Created by 张闯闯 on 2019/3/14.
//  Copyright © 2019 张闯闯. All rights reserved.
//

#import "ViewController.h"
#import "testView.h"
@interface ViewController ()
@property (nonatomic,strong) testView *test_view;
@property (nonatomic,strong) UITextField *test_filed;//文本框
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self test];
    [self setUI];
    // Do any additional setup after loading the view, typically from a nib.
}
-(void)setUI{
    self.test_view = [[testView alloc]initWithFrame:CGRectMake(0, 30, SCREEN_WIDTH, 400)];
    [self.test_view setBackgroundColor:[UIColor yellowColor]];
    self.test_view.delegateSignal = [RACSubject subject];
    [self.test_view.delegateSignal subscribeNext:^(id  _Nullable x) {
        NSLog(@"点击了按钮，并受到的传值%@",x);
    }];
    [[self.test_view rac_signalForSelector:@selector(btnClick:)]subscribeNext:^(RACTuple * _Nullable x) {
        NSLog(@"点击了红色按钮%@",x);
    }];
    [self.view addSubview:self.test_view];
    [self test3];
}
-(void)test{
    RACSignal *siganl = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        [subscriber sendNext:@1];
        [subscriber sendCompleted];
        return [RACDisposable disposableWithBlock:^{
            NSLog(@"信号被销毁");
        }];
    }];
    [siganl subscribeNext:^(id  _Nullable x) {
        NSLog(@"接收到数据:%@",x);
    }];
    
}

//reasubscriber
-(void)test1{
    //创建信号
    RACSubject *subject = [RACSubject subject];
    //订阅信号
    [subject subscribeNext:^(id  _Nullable x) {
        NSLog(@"第一个订阅者%@",x);
    }];
    //发送信号
    [subject sendNext:@"1"];
    
}
//RACReplaySubject
-(void)test2{
    //创建信号
    RACReplaySubject *replaySubject = [RACReplaySubject subject];
    //发送信号
    [replaySubject sendNext:@1];
    [replaySubject sendNext:@2];
    
    //订阅信号
    [replaySubject subscribeNext:^(id  _Nullable x) {
        NSLog(@"第一个订阅者接收到的数据%@",x);
    }];
    
    [replaySubject subscribeNext:^(id  _Nullable x) {
        NSLog(@"第二个订阅者接收到的数据%@",x);
    }];
}
//RACSequence
-(void)test3{
    //遍历数组
    NSArray *nubers = @[@1,@2,@3];
    [nubers.rac_sequence.signal subscribeNext:^(id  _Nullable x) {
        NSLog(@"%@",x);
    }];
    //遍历字典
    NSDictionary *dictt = @{@"name":@"xmg",@"age":@18};
    [dictt.rac_sequence.signal subscribeNext:^(id  _Nullable x) {
        RACTupleUnpack(NSString *key,NSString *value) = x;
        NSLog(@"key==%@,value==%@",key,value);
    }];
    
}
//RACCommand
-(void)test4{
    RACCommand *command = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        NSLog(@"执行命令");
        return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
            [subscriber sendNext:@"请求数据"];
            //注意：数据传递完，最好调用sendcompleted,这时命令才执行完毕
            [subscriber sendCompleted];
            return nil;
        }];
    }];
    //强引用命令，不要被销毁，否则接受不到数据
    
    
}

-(void)test5{
    [self.test_filed.rac_textSignal bind:^RACSignalBindBlock _Nonnull{
        return ^RACStream *(id value,BOOL *stop){
            
        };
    }]
}
@end
