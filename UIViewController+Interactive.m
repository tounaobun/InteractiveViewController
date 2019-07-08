//
//  UIViewController+Interactive.m
//  woaoo-basketball
//
//  Created by Benson Tommy on 2019/7/4.
//

#import "UIViewController+Interactive.h"

static CGFloat minimumVelocitySpeed = 300.f;
static CGFloat animationDuration = 0.2f;

@implementation UIViewController (Interactive)

- (void)presentedToViewController:(UIViewController *)vc animated:(BOOL)animated completion:(void (^)(void))completion {
    // 防止底部黑屏出现
    self.modalPresentationStyle = UIModalPresentationOverFullScreen;
    [vc presentViewController:self animated:animated completion:completion];
}

- (void)addSlideDownGestureWithDirection:(UIInteractiveDirection)direction {
    if (direction == UIInteractiveDirectionHorizontal) {
        UIScreenEdgePanGestureRecognizer *edgePan = [[UIScreenEdgePanGestureRecognizer alloc] initWithTarget:self action:@selector(onEdgePan:)];
        edgePan.edges = UIRectEdgeLeft;
        [self.view addGestureRecognizer:edgePan];
    } else {
        UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(onDrag:)];
        [self.view addGestureRecognizer:pan];
    }
}

- (void)onEdgePan:(UIScreenEdgePanGestureRecognizer *)sender {

    CGFloat percentThreshold = 0.5f;
    CGPoint translation = [sender translationInView:self.view];
    
    CGFloat newY = self.view.y + (translation.x * self.view.height / self.view.width);
    if (newY < 0) {
        newY = 0;
    }
    
    self.view.y = newY;
    
    CGFloat progress = newY / self.view.height;
    
    if (sender.state == UIGestureRecognizerStateEnded) {
        
        CGPoint velocity = [sender velocityInView:self.view];
        if (velocity.x > minimumVelocitySpeed || progress > percentThreshold) {
            [self dismissViewControllerAnimated:YES completion:nil];
        } else {
            [UIView animateWithDuration:animationDuration animations:^{
                self.view.y = 0;
            }];
        }
        
    }
    [sender setTranslation:CGPointZero inView:self.view];
}

- (void)onDrag:(UIPanGestureRecognizer *)sender {

    CGFloat percentThreshold = 0.35f;
    CGPoint translation = [sender translationInView:self.view];
    
    CGFloat newY = self.view.y + translation.y;
    if (newY < 0) {
        newY = 0;
    }
    
    self.view.y = newY;
    
    CGFloat progress = newY / self.view.height;
    
    if (sender.state == UIGestureRecognizerStateEnded) {
        
        CGPoint velocity = [sender velocityInView:self.view];
        if (velocity.y > minimumVelocitySpeed || progress > percentThreshold) {
            [self dismissViewControllerAnimated:YES completion:nil];
        } else {
            [UIView animateWithDuration:animationDuration animations:^{
                self.view.y = 0;
            }];
        }
        
    }
    [sender setTranslation:CGPointZero inView:self.view];
    
}

@end
