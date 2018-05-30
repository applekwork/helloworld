//
//  ViewController.m
//  WebScoketTest
//
//  Created by 涂耀辉 on 16/12/28.
//  Copyright © 2016年 涂耀辉. All rights reserved.
//

#import "ViewController.h"
#import "TYHSocketManager.h"
#import "GVoice.h"
@interface ViewController () <GVGCloudVoiceDelegate>

@property (weak, nonatomic) IBOutlet UITextField *sendFiled;

@property (weak, nonatomic) IBOutlet UIButton *sendBtn;


@property (weak, nonatomic) IBOutlet UIButton *connectBtn;

@property (weak, nonatomic) IBOutlet UIButton *disConnectBtn;

@property (weak, nonatomic) IBOutlet UIButton *pingBtn;

@property (nonatomic, strong) NSTimer *pollTimer;


@end


@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [TYHSocketManager share];
    
    [_connectBtn addTarget:self action:@selector(connectAction) forControlEvents:UIControlEventTouchUpInside];
    
    [_disConnectBtn addTarget:self action:@selector(disConnectAction) forControlEvents:UIControlEventTouchUpInside];
    
    [_sendBtn addTarget:self action:@selector(sendAction) forControlEvents:UIControlEventTouchUpInside];
    [_pingBtn addTarget:self action:@selector(pingAction) forControlEvents:UIControlEventTouchUpInside];
    
    [GVGCloudVoice sharedInstance].delegate = self;
    [[GVGCloudVoice sharedInstance] setAppInfo:"1882451525" withKey:"7415f1a8a65d8a6d7643c5a939db81a6" andOpenID:[@"abc123" cStringUsingEncoding:NSUTF8StringEncoding]];
    [[GVGCloudVoice sharedInstance] initEngine];
    [[GVGCloudVoice sharedInstance] setServerInfo:"udp://cn.voice.gcloudcs.com:10001"];
}
- (IBAction)joinRoom:(id)sender {
    [[GVGCloudVoice sharedInstance] setAppInfo:"1882451525" withKey:"7415f1a8a65d8a6d7643c5a939db81a6" andOpenID:[@"abc123" cStringUsingEncoding:NSUTF8StringEncoding]];
    [[GVGCloudVoice sharedInstance] setMode:RealTime];
    [[GVGCloudVoice sharedInstance] joinTeamRoom:[@"110aaa" cStringUsingEncoding:NSUTF8StringEncoding] timeout:18000];
    _pollTimer = [NSTimer scheduledTimerWithTimeInterval:1.000/15 repeats:YES block:^(NSTimer * _Nonnull timer) {
        [[GVGCloudVoice sharedInstance] poll];
    }];
}
- (IBAction)quitRoom:(id)sender {
    [[GVGCloudVoice sharedInstance] quitRoom:[@"110aaa" cStringUsingEncoding:NSUTF8StringEncoding] timeout:18000];
}

//连接
- (void)connectAction
{
    [[TYHSocketManager share] connect];
    
}
//断开连接
- (void)disConnectAction
{
    [[TYHSocketManager share] disConnect];
}

//发送消息
- (void)sendAction
{
    if (_sendFiled.text.length == 0) {
        return;
    }
    [[TYHSocketManager share]sendMsg:_sendFiled.text];
}


- (void)pingAction
{
    [[TYHSocketManager share]ping];

}
- (void)onOpenMic {
    static BOOL once = YES;
    if (once) {
//        [_OpenMicBtn setTitle:@"CloseMic" forState:UIControlStateNormal];
        once = NO;
        [[GVGCloudVoice sharedInstance] openMic];
        
    } else {
//        [_OpenMicBtn setTitle:@"OpenMic" forState:UIControlStateNormal];
        once = YES;
        [[GVGCloudVoice sharedInstance] closeMic];
    }
}

- (void)onOpenSpeaker {
    static BOOL once = YES;
    if (once) {
//        [_OpenSpeakerBtn setTitle:@"CloseSpeaker" forState:UIControlStateNormal];
        once = NO;
        [[GVGCloudVoice sharedInstance] openSpeaker];
    } else {
//        [_OpenSpeakerBtn setTitle:@"OpenSpeaker" forState:UIControlStateNormal];
        once = YES;
        [[GVGCloudVoice sharedInstance] closeSpeaker];
    }
}
- (void) warnning: (NSString *) msg {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"WARNING" message:msg preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //
    }]];
    [self presentViewController:alert animated:YES completion:^{
        //
    }];
}

#pragma mark delegate
//加入房间
- (void)onJoinRoom:(enum GCloudVoiceCompleteCode) code withRoomName: (const char * _Nullable)roomName andMemberID:(int) memberID {
    NSString *msg;
    if (GV_ON_JOINROOM_SUCC == code) {
        msg = [NSString stringWithFormat:@"Join Room Success"];
    } else {
        msg = [NSString stringWithFormat:@"Join Room Failed with code: %d", code];
    }
    [self warnning:msg];
}
//成功进入房间
- (void) onStatusUpdate:(enum GCloudVoiceCompleteCode) status withRoomName: (const char * _Nullable)roomName andMemberID:(int) memberID {
    [[GVGCloudVoice sharedInstance] openSpeaker];
}

- (void) onQuitRoom:(enum GCloudVoiceCompleteCode) code withRoomName: (const char * _Nullable)roomName {
      [_pollTimer invalidate];
}

- (void) onMemberVoice:    (const unsigned int * _Nullable)members withCount: (int) count {
    for (int i=0; i<count; i++) {
        NSLog(@"Member %d status %d", *((int*)members+2*i), *((int *)members+2*i+1));
    }
}

- (void) onUploadFile: (enum GCloudVoiceCompleteCode) code withFilePath: (const char * _Nullable)filePath andFileID:(const char * _Nullable)fileID  {
    
}

- (void) onDownloadFile: (enum GCloudVoiceCompleteCode) code  withFilePath: (const char * _Nullable)filePath andFileID:(const char * _Nullable)fileID {
    
}

- (void) onPlayRecordedFile:(enum GCloudVoiceCompleteCode) code withFilePath: (const char * _Nullable)filePath {
    
}

- (void) onApplyMessageKey:(enum GCloudVoiceCompleteCode) code {
    
}

- (void) onSpeechToText:(enum GCloudVoiceCompleteCode) code withFileID:(const char * _Nullable)fileID andResult:( const char * _Nullable)result {
    
}

- (void) onRecording:(const unsigned char* _Nullable) pAudioData withLength: (unsigned int) nDataLength {
    
}

@end
