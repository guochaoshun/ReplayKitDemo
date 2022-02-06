//
//  ViewController.m
//  测试刷新冲突
//
//  Created by 郭朝顺 on 2021/9/24.
//

#import "ViewController.h"
#import <ReplayKit/ReplayKit.h>

@interface ViewController ()<RPScreenRecorderDelegate,RPPreviewViewControllerDelegate>


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];



}

- (IBAction)startRecordAction:(UIButton *)sender {

    if ([RPScreenRecorder sharedRecorder].isAvailable) {

        NSLog(@"[RPScreenRecorder sharedRecorder].isAvailable支持录屏,准备开始录屏");
        [RPScreenRecorder sharedRecorder].delegate = self;
        [RPScreenRecorder sharedRecorder].microphoneEnabled = YES;
        [[RPScreenRecorder sharedRecorder] startRecordingWithHandler:^(NSError * _Nullable error) {
            if (error) {
                NSLog(@"录屏初始化失败, %@",error);
                /*
                 开发中遇到了一个错误, 低版本的系统解决方案看起来只有重启,可以做个提示给用户
                 com.apple.ReplayKit.rprecordingerrodomain代码=-5807 “录制被多任务和内容大小调整中断” UserInfo={NSLocalizedDescription=录制被多任务中断 和内容大小调整})

                 我遇到这个问题因为Extension启动失败导致上一个Extension没有关闭没办法重新打开，关机重启手机可以解决，
                 根本解决办法还是在Extension上，找到Extension崩溃的原因才能根治
                 链接：https://www.jianshu.com/p/0d3840463c56

                 在iOS 12.0之前一切正常.从更新我得到上面的错误.出于同样的原因,我的应用程序已被App Store拒绝.到目前为止,唯一的解决方法是重启设备.
                 https://www.codercto.com/a/51450.html

                 我遇到了同样的问题,我的设备甚至完全无法再录制屏幕。更新设备到iOS13.1.3修复了所有问题。
                 http://ask.sov5.cn/q/M67Qqiz5Hb
                 */

            } else {
                NSLog(@"录屏初始化成功,真正开始录屏");
            }
        }];

    } else {
        NSLog(@"[RPScreenRecorder sharedRecorder].isAvailable不支持录屏");
    }


}

- (IBAction)endRecordAction:(UIButton *)sender {

    [[RPScreenRecorder sharedRecorder] stopRecordingWithHandler:^(RPPreviewViewController * _Nullable previewViewController, NSError * _Nullable error) {

        previewViewController.previewControllerDelegate = self;
        // 录屏结束,调用显示预览,根据自己的需求来处理,也可以不显示预览,直接存相册,让用户到相册里编辑
        [self presentViewController:previewViewController animated:YES completion:^{

        }];

    }];

    // 这个是iOS14之后可用,可以把录屏的视频导入到自己的app沙盒中
//    - (void)stopRecordingWithOutputURL:(NSURL *)url completionHandler:(nullable void (^)(NSError *_Nullable error))completionHandler


}


#pragma mark - 录制事件回调
// 录屏结束, 显示出预览画面
- (void)screenRecorder:(RPScreenRecorder *)screenRecorder didStopRecordingWithPreviewViewController:(nullable RPPreviewViewController *)previewViewController error:(nullable NSError *)error {



}

// [RPScreenRecorder sharedRecorder].isAvailable, 状态变化会抛这个回调
- (void)screenRecorderDidChangeAvailability:(RPScreenRecorder *)screenRecorder {

}


#pragma mark - 预览视图回调
// 预览视图编辑结束
- (void)previewControllerDidFinish:(RPPreviewViewController *)previewController {
    [previewController dismissViewControllerAnimated:YES completion:^{

    }];
}

- (void)previewController:(RPPreviewViewController *)previewController didFinishWithActivityTypes:(NSSet <NSString *> *)activityTypes {

}


@end
