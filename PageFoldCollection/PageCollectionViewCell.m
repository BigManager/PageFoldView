//
//  PageCollectionViewCell.m
//  PageFoldCollection
//
//  Created by zangqilong on 14/11/24.
//  Copyright (c) 2014年 zangqilong. All rights reserved.
//

#import "PageCollectionViewCell.h"
#import "MacroDefinition.h"

typedef NS_ENUM(NSInteger, LayerSection) {
    LayerSectionTop,
    LayerSectionBottom
};

@interface PageCollectionViewCell ()
{
    UIImageView *leftImageView;
    UIImageView *rightImageView;
    
}
@end

@implementation PageCollectionViewCell

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    _numLabel = [[UILabel alloc] initWithFrame:self.contentView.bounds];
    _numLabel.textAlignment = NSTextAlignmentCenter;
    _numLabel.font = [UIFont systemFontOfSize:40];
    [self.contentView addSubview:_numLabel];
   
    leftImageView = [[UIImageView alloc] init];
     leftImageView.backgroundColor = [UIColor clearColor];
    leftImageView.layer.anchorPoint = CGPointMake(0.5, 1);
    leftImageView.layer.transform = [self transform3D];
    [self.contentView addSubview:leftImageView];
    
    
    rightImageView = [[UIImageView alloc] init];
    rightImageView.backgroundColor = [UIColor clearColor];
    rightImageView.layer.anchorPoint = CGPointMake(0.5, 0);
    rightImageView.layer.transform = [self transform3D];
    [self.contentView addSubview:rightImageView];

}

- (void)addGestureRecognizers
{
    UIPanGestureRecognizer *panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self
                                                                                           action:@selector(handlePan:)];
    
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                           action:@selector(poke)];
    
    [leftImageView addGestureRecognizer:panGestureRecognizer];
    [leftImageView addGestureRecognizer:tapGestureRecognizer];
}

- (CATransform3D)transform3D
{
    CATransform3D transform = CATransform3DIdentity;
    transform.m34 = 2.5 / -2000;
    return transform;
}


- (void)layoutSubviews
{
    [super layoutSubviews];

    
    _numLabel.frame = self.contentView.bounds;
    
    _numLabel.backgroundColor = [UIColor blueColor];
    
    leftImageView.layer.bounds = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT/2);
    leftImageView.layer.position = CGPointMake(CGRectGetMidX(self.contentView.frame), CGRectGetMidY(self.contentView.frame));
 
    rightImageView.layer.bounds = CGRectMake(0, SCREEN_HEIGHT/2, SCREEN_WIDTH, SCREEN_HEIGHT/2);
     rightImageView.layer.position = CGPointMake(CGRectGetMidX(self.contentView.frame), CGRectGetMidY(self.contentView.frame));
}

- (BOOL)isLocation:(CGPoint)location inView:(UIView *)view
{
    if ((location.x > 0 && location.x < CGRectGetWidth(self.bounds)) &&
        (location.y > 0 && location.y < CGRectGetHeight(self.bounds))) {
        return YES;
    }
    return NO;
}

- (UIImage *)imageForSection:(LayerSection)section withImage:(UIImage *)image
{
    CGRect rect = CGRectMake(0.f, 0.f, image.size.width, image.size.height / 2.f);
    if (section == LayerSectionBottom) {
        rect.origin.y = image.size.height / 2.f;
    }
    
    CGImageRef imgRef = CGImageCreateWithImageInRect(image.CGImage, rect);
    UIImage *imagePart = [UIImage imageWithCGImage:imgRef];
    CGImageRelease(imgRef);
    
    return imagePart;
}

- (CAShapeLayer *)maskForSection:(LayerSection)section withRect:(CGRect)rect
{
    CAShapeLayer *layerMask = [CAShapeLayer layer];
    UIRectCorner corners = (section == LayerSectionTop) ? 3 : 12;
    
    layerMask.path = [UIBezierPath bezierPathWithRoundedRect:rect
                                           byRoundingCorners:corners
                                                 cornerRadii:CGSizeMake(5, 5)].CGPath;
    return layerMask;
}

#pragma mark - POPAnimationDelegate

//- (void)pop_animationDidApply:(POPAnimation *)anim
//{
//    CGFloat currentValue = [[anim valueForKey:@"currentValue"] floatValue];
//    if (currentValue > -M_PI_2) {
//        self.backView.alpha = 0.f;
//        [CATransaction begin];
//        [CATransaction setValue:(id)kCFBooleanTrue
//                         forKey:kCATransactionDisableActions];
//        self.bottomShadowLayer.opacity = -currentValue/M_PI;
//        self.topShadowLayer.opacity = -currentValue/M_PI;
//        [CATransaction commit];
//    }
//}


@end
