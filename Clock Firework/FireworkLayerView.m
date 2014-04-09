//
//  FireworkLayerView.m
//  Clock Firework
//
//  Created by HIROKI on 2014/03/18.
//  Copyright (c) 2014年 HIROKI. All rights reserved.
//

#import "FireworkLayerView.h"


#define FIRE_COUNT 24 //  花火1つの火の玉の数

/**
 *  花火ひとつ分のレイヤー定義
 */
@interface starLayer : CALayer {
    @private
    CALayer *layerList[FIRE_COUNT]; // bang(アクション）メソッドでの火の玉レイヤーアクセス用
}

@end

/**
 *  花火ひとつ分のレイヤー実装
 */
@implementation starLayer
/**
 *  火の玉のインディックスをもらい、対応するラジアン度を返す
 */
- (float)indexToRadian : (int)index
{
    return ((float)index / (float)FIRE_COUNT) * 2.0 * 3.14;
}
/**
 *  火の玉のインディックスをもらい、対応するCGColorRefを返す。α値指定可能
 */
-(CGColorRef)indexToColor:(int)index alpha:(float)alpha
{
    return [UIColor colorWithHue:(float)index / (float)FIRE_COUNT
                      saturation:1
                      brightness:1
                           alpha:alpha].CGColor;
}
/**
 *  花火の初期位置設定。この時に火の玉用サブレイヤーを追加
 */
-(void)setpos:(CGPoint)pos
{
    //初期位置設定
    CGRect frame = self.frame;
    frame.origin = pos;
    self.frame = frame;
    
    //  火の玉用サブレイヤーを自身のレイヤーに追加
    for (int i = 0; i < FIRE_COUNT; i++) {
        //  addSubLayerでretainされるのでretainはしない
        CALayer* layer = [CALayer layer];
        layer.frame = CGRectMake(0, 0, 30, 30);
        //layer.contents = (id)[UIImage imageNamed:@"test.jpg"].CGImage;
        layer.cornerRadius = 15.0f;
        layer.masksToBounds = YES;
        float angle = [self indexToRadian:i];
        layer.position = CGPointMake(cos(angle), sin(angle));
        layer.backgroundColor = [self indexToColor:i alpha:1];
        [self addSublayer:layer];
        layerList[i] = layer;
    }

}

/**
 *  火の玉を拡散させる。広がり終わった時点でレイヤーはリリースされる
 */
-(void)bang
{
    float radius = (rand() % 5 + 1) * 50; //  拡散半径をランダムに設定
    float duration = radius / 40.0; //  広がるスピードは一定にする。
    [CATransaction begin];
    [CATransaction setAnimationDuration:duration];
    //  広がり終わった時点で自身を親レーヤーから取り外す。
    //  retainしていないので、この処理でリリースとなる。
    [CATransaction setCompletionBlock:^(void){
        [self removeFromSuperlayer];
    }];
    //  火の玉拡散位置設定
    for (int i = 0; i < FIRE_COUNT; i++) {
        float angle = [self indexToRadian:i];
        layerList[i].position = CGPointMake(cos(angle) * radius, sin(angle) * radius);
        layerList[i].backgroundColor = [self indexToColor:i alpha:0];
    }
    [CATransaction commit];
}

/**
 *  花火発射。破裂する位置を50…300の高さをランダムに設定
 */
-(void)launch
{
    CGPoint pt = self.position;
    //float height = (rand() % 5 + 1) * 50 + 50;
    //50…300の高さをランダムに設定
    float height = (arc4random() % 5 + 1) * 50 + 50;
    pt.y -= height;
    [CATransaction begin];
    [CATransaction setAnimationDuration:1.0 * height / 300.0]; //300/1秒で移動
    self.position = pt;
    [CATransaction commit];
    [self performSelector:@selector(bang) withObject:nil afterDelay:0.5];
}





@end




@implementation FireworkLayerView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/**
 *  10ポイント以上指の移動があれば1発、花火を打ち上げる。
 */

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    CGPoint pos = [(UITouch*)[touches anyObject] locationInView:self];
    float dx = pos.x - lastPos.x;
    float dy = pos.y - lastPos.y;
    if ((dx * dx + dy * dy) < 10 *10) {
        return;
    }
    lastPos = pos;
    starLayer* star = [starLayer layer];
    [star setpos:pos];
    [self.layer addSublayer:star];
    //  直に呼ぶとアニメーションがかからないのでこのようにする。ただし間をあける必要は無いので　afterDelay:0 とする
    [star performSelector:@selector(launch) withObject:nil afterDelay:0];
    
}


/**
 *  時間が毎時丁度になったら1発、花火を打ち上げる。
 */
- (void) fireWork
{
    CGPoint pos = CGPointMake(380, 100);
    starLayer* star = [starLayer layer];
    [star setpos:pos];
    [self.layer addSublayer:star];
    //  直に呼ぶとアニメーションがかからないのでこのようにする。ただし間をあける必要は無いので　afterDelay:0 とする
    [star performSelector:@selector(launch) withObject:nil afterDelay:0];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
