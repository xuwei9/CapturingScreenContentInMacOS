//
//  vme_wraper.m
//  CaptureSample
//
//  Created by xuwei on 9/22/23.
//  Copyright © 2023 Apple. All rights reserved.
//


#import "CaptureSample-Bridging-Header.h"
#import "codec/XCodec.h"
#import <stdio.h>
#import "foundation/XLooper.h"


bool bInit = false;
FILE* file;
XCodec* codec;
long long pts = 0;
@implementation vme_test


- (void)inputData:(CVPixelBufferRef)data
{
    int width = (int)CVPixelBufferGetWidth(data);
    int height = (int)CVPixelBufferGetHeight(data);
    if(bInit == false)
    {
        xcodec_init();
        XCodecParam param = {};
        param.width = width;
        param.height = height;
        param.bitrate = -1;
        param.fps = 30;
        param.gop = 30;
        param.profile = 100;
        
        xcodec_create_encoder_by_id(27, X_MEDIA_TYPE_VIDEO, true, &codec);
        if(codec)
        {
            xcodec_open(codec, &param);
        }
        bInit = true;
    }
    XFrame frame;
    frame.width = width;
    frame.height = height;
    frame.hardwareBuffer = data;
    frame.pts =pts;
    pts+=33*1000;
    CFRetain(data);
    auto now = XLooper::GetNowUs();
    int ret =xcodec_send_frame(codec, &frame);
    if(ret== 0)
    {
        printf("xcodec_send_frame success!\n");
    }
    auto cost = XLooper::GetNowUs() - now;
    NSLog(@"xcodec xcodec_send_frame cost = %lld\n", cost/1000);
    //CFRetain(data);
    //CFRelease(data);
    
    XPacket packet;
    ret = xcodec_recv_packet(codec, &packet);
    if(ret == 0)
    {

        NSLog(@"xcodec packet size = %d, cost = %lld\n", packet.size, cost/1000);
        if(file == NULL)
        {
            file = fopen("xxx.h264","wb");
        }
        
        if(file != NULL)
        {
            fwrite(packet.data, packet.size, 1, file);
        }
    }

    
    
}
@end
