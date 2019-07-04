//
//  UIViewController+Interactive.m
//  woaoo-basketball
//
//  Created by Benson Tommy on 2019/7/4.
//

#import "UIViewController+Interactive.h"

@implementation UIViewController (Interactive)

- (void)presentedToViewController:(UIViewController *)vc animated:(BOOL)animated completion:(void (^)(void))completion {
    // 防止底部黑屏出现
    self.modalPresentationStyle = UIModalPresentationOverFullScreen;
    [vc presentViewController:self animated:animated completion:completion];
}

- (void)addSlideDownGesture {
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(onDrag:)];
    [self.view addGestureRecognizer:pan];
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
        if (velocity.y > 300 || progress > percentThreshold) {
            [self dismissViewControllerAnimated:YES completion:nil];
        } else {
            [UIView animateWithDuration:0.2 animations:^{
                self.view.y = 0;
            }];
        }
        
    }
    [sender setTranslation:CGPointZero inView:self.view];
    
}

@end
