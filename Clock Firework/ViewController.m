//
//  ViewController.m
//  Clock Firework
//
//  Created by HIROKI on 2014/03/18.
//  Copyright (c) 2014年 HIROKI. All rights reserved.
//

#import "ViewController.h"
#import "FireworkLayerView.h"


@interface ViewController ()

//@property (nonatomic, assign) NSTimer *loadTimer;
@property (nonatomic, weak) NSTimer *t1;
@property (nonatomic, weak) NSTimer *t2;
@property (nonatomic, weak) NSTimer *t3;
@property (nonatomic, weak) NSTimer *t4;
@property (nonatomic, weak) NSTimer *t5;
@property (nonatomic, weak) NSTimer *t6;

@end

@implementation ViewController



- (void)viewDidLoad
//時刻を出すためのタイマーを稼働
//花火のレイヤーFireworkLayerViewクラスを作って初期化。
{
    [super viewDidLoad];
    
    //時刻の取得　driveClock:メソッドを発動
    [NSTimer scheduledTimerWithTimeInterval:1.0
                                     target:self
                                   selector:@selector(driveClock:)
                                   userInfo:nil repeats:YES];

	//FireworkLayerViewクラスを作って初期化、バックグラウンドカラーを設定してaddSubviewする
    FireworkLayerView *v = [[FireworkLayerView alloc] initWithFrame:self.view.bounds];
    v.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:v];
    
        
}

    //時刻を読み出す
- (void) driveClock:(NSTimer *)timer
{
    //現在時刻を取得
    NSDate *now = [NSDate date];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSUInteger flags;
    NSDateComponents *comps;
    
    // 時・分・秒を取得
    flags = NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    comps = [calendar components:flags fromDate:now];
    
    NSInteger hour = comps.hour;
    NSInteger minute = comps.minute;
    NSInteger second = comps.second;
    
    NSLog(@"%02d時 %02d分 %02d秒", hour, minute, second);
    
    if (minute == 00 && second == 00) {
        NSLog(@"時刻はちょうどになりました。");
        [self fire]; //時間ちょうどになったら、発動されるメソッド。
        }else{
            NSLog(@"時刻はちょうどではありません。");
        
        }
    
}

/*
- (void) setLoadTimer:(NSTimer *)newTimer
{
    [_loadTimer invalidate]; //invalidateというのは発動待ち状態のタイマーを止める命令
    _loadTimer = newTimer;
}

 
 NSInteger loopCount; //ループのカウントをとる変数
*/

- (void) fire //timeを使って花火をうつタイミングを作る
{
    self.t1 = [NSTimer scheduledTimerWithTimeInterval:0.5
                                                   target:self
                                                 selector:@selector(timerFireMethod:)
                                                 userInfo:nil
                                                  repeats:NO];
    
    self.t2 = [NSTimer scheduledTimerWithTimeInterval:0.5 + 1.0
                                                   target:self
                                                 selector:@selector(timerFireMethod:)
                                                 userInfo:nil
                                                  repeats:NO];
    
    self.t3 = [NSTimer scheduledTimerWithTimeInterval:0.5 + 1.0 + 0.5
                                                   target:self
                                                 selector:@selector(timerFireMethod:)
                                                 userInfo:nil
                                                  repeats:NO];
    
    self.t4 = [NSTimer scheduledTimerWithTimeInterval:0.5 + 1.0 + 0.5 + 0.5
                                                   target:self
                                                 selector:@selector(timerFireMethod:)
                                                 userInfo:nil
                                                  repeats:NO];
    self.t5 = [NSTimer scheduledTimerWithTimeInterval:0.5 + 1.0 + 0.5 + 0.5 + 0.8
                                                   target:self
                                                 selector:@selector(timerFireMethod:)
                                                 userInfo:nil
                                                  repeats:NO];
    
    self.t6 = [NSTimer scheduledTimerWithTimeInterval:0.5 + 1.0 + 0.5 + 0.5 + 0.8 + 0.2
                                                   target:self
                                                 selector:@selector(timerFireMethod:)
                                                 userInfo:nil
                                                  repeats:NO];
}

- (void)timerFireMethod:(NSTimer *)timer
{
    if (_t1 == timer) {
        //t1での花火打ち上げ
        _t1 = nil;
        //呼び出されたメソッドではインスタンス変数にnilを入れるようにしておけば、未実行のNSTimerの判別もできるでしょう。
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
