//
//  Use this file to import your target's public headers that you would like to expose to Swift.
//
#import <Foundation/Foundation.h>
#include <CoreFoundation/CoreFoundation.h>
#include <VideoToolbox/VideoToolbox.h>
#include <VideoToolbox/VTVideoEncoderList.h>
#include <CoreMedia/CoreMedia.h>
#include <CoreVideo/CoreVideo.h>
@interface vme_test : NSObject
- (void)inputData:(nonnull  CVPixelBufferRef)data;
@end

