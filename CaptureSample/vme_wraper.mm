//
//  vme_wraper.m
//  CaptureSample
//
//  Created by xuwei on 9/22/23.
//  Copyright © 2023 Apple. All rights reserved.
//


#import "CaptureSample-Bridging-Header.h"
#import "XCodec.h"


bool bInit = false;
XCodec* codec;
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
        
        xcodec_create_encoder_by_id(27, X_MEDIA_TYPE_VIDEO, true, &codec);
        if(codec)
        {
            xcodec_open(codec, &param);
        }
    }
    
    
    
}
@end
