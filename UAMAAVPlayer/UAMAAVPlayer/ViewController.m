//
//  ViewController.m
//  UAMAAVPlayer
//
//  Created by zhanghengyi on 12/10/2017.
//  Copyright © 2017 zhanghengyi. All rights reserved.
//

#import "ViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "MQEncodeAudio.h"
#import "AMRPlayer.h"

@interface ViewController () <AVAudioPlayerDelegate>


@property (nonatomic,strong) AVAudioPlayer *player;

@property (nonatomic) AMRPlayer *amrPlayer;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    AVAudioSession *session = [AVAudioSession sharedInstance];
//    [session setActive:YES error:nil];
//    [session setCategory:AVAudioSessionCategoryPlayback error:nil];
//
//    // Do any additional setup after loading the view, typically from a nib.
//
  NSString *filePath = [[NSBundle mainBundle] pathForResource:@"uama_record" ofType:@"amr"];
////    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"BestRegards" ofType:@"mp3"];
//
//    NSData *audio = [NSData dataWithContentsOfFile:filePath];
//
//    NSData *armAudio = [MQEncodeAudio convertAmrToWavFile:audio];
//
//    NSFileManager *fileManager = [NSFileManager defaultManager];
//
//    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
//    NSString *documentsDirectory = [paths objectAtIndex:0];
//
//    NSString *armFilePath = [documentsDirectory stringByAppendingString:@"/uama_record.wav"];
//
//    [fileManager createFileAtPath:armFilePath contents:armAudio attributes:nil];
//
//    NSError *error = NULL;
//
//    self.player = [[AVAudioPlayer alloc] initWithData:audio error:&error];
//    self.player.delegate = self;
//
//    NSLog(@"error:%@", error);
//
//    [self.player play];
    
    self.amrPlayer = [[AMRPlayer alloc] init];
    [self.amrPlayer startPlay:[filePath UTF8String]];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
