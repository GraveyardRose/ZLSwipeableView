//
//  DefaultViewAnimator.m
//  ZLSwipeableViewDemo
//
//  Created by Zhixuan Lai on 10/25/15.
//  Copyright © 2015 Zhixuan Lai. All rights reserved.
//

#import "DefaultViewAnimator.h"
#import "ZLSwipeableView.h"

@implementation DefaultViewAnimator

- (CGFloat)degreesToRadians:(CGFloat)degrees {
    return degrees * M_PI / 180;
}

- (CGFloat)radiansToDegrees:(CGFloat)radians {
    return radians * 180 / M_PI;
}

- (void)rotateView:(UIView *)view
         forDegree:(float)degree
          duration:(NSTimeInterval)duration
atOffsetFromCenter:(CGPoint)offset
     swipeableView:(ZLSwipeableView *)swipeableView {
    float rotationRadian = [self degreesToRadians:degree];
    [UIView animateWithDuration:duration
                          delay:0
                        options:UIViewAnimationOptionAllowUserInteraction
                     animations:^{
                       view.center = [swipeableView convertPoint:swipeableView.center
                                                        fromView:swipeableView.superview];
                         
                       CGAffineTransform transform = CGAffineTransformMakeTranslation(offset.x, offset.y);
                         transform = CGAffineTransformScale(transform, degree, degree);
#warning disabling rotation to instead translate
//                       transform = CGAffineTransformRotate(transform, rotationRadian);
//                       transform = CGAffineTransformTranslate(transform, -offset.x, -offset.y);
                       view.transform = transform;
                     }
                     completion:nil];
}

- (void)animateView:(UIView *)view
              index:(NSUInteger)index
              views:(NSArray<UIView *> *)views
      swipeableView:(ZLSwipeableView *)swipeableView {
#warning Change stationary angle
    CGFloat degree = 1;
    if ([swipeableView.delegate respondsToSelector:@selector(fanningAngle)]) {
        degree = [swipeableView.delegate fanningAngle];
    }
    NSTimeInterval duration = 0.4;
    //CGPoint offset = CGPointMake(0, CGRectGetHeight(swipeableView.bounds) * 0.3);
    CGPoint offset = CGPointMake(16, 0);
    switch (index) {
    case 0:
        [self rotateView:view
                     forDegree:1
                      duration:duration
            atOffsetFromCenter:CGPointMake(offset.x*index, offset.y*index)
                 swipeableView:swipeableView];
        break;
    case 1:
        [self rotateView:view
                     forDegree:0.95
                      duration:duration
            atOffsetFromCenter:CGPointMake(offset.x*index, offset.y*index)
                 swipeableView:swipeableView];
        break;
    case 2:
        [self rotateView:view
                     forDegree:0.9
                      duration:duration
            atOffsetFromCenter:CGPointMake(offset.x*index, offset.y*index)
                 swipeableView:swipeableView];
        break;
    case 3:
        [self rotateView:view
                     forDegree:0.85
                      duration:duration
            atOffsetFromCenter:CGPointMake(offset.x*index, offset.y*index)
                 swipeableView:swipeableView];
        break;
    default:
        break;
    }
}

@end
