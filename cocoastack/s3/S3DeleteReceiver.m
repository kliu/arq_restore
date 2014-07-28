/*
 Copyright (c) 2009-2011, Stefan Reitshamer http://www.haystacksoftware.com
 
 All rights reserved.
 
 Redistribution and use in source and binary forms, with or without
 modification, are permitted provided that the following conditions are met:
 
 * Redistributions of source code must retain the above copyright
 notice, this list of conditions and the following disclaimer.
 
 * Redistributions in binary form must reproduce the above copyright
 notice, this list of conditions and the following disclaimer in the
 documentation and/or other materials provided with the distribution.
 
 * Neither the names of PhotoMinds LLC or Haystack Software, nor the names of 
 their contributors may be used to endorse or promote products derived from
 this software without specific prior written permission.
 
 THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
 "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
 LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
 A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
 OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
 SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED
 TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
 PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
 LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
 NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
 SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */ 

#import "S3DeleteReceiver.h"
#import "S3Service.h"

@implementation S3DeleteReceiver
- (id)init {
    @throw [NSException exceptionWithName:@"InvalidInitializerException" reason:@"wrong S3DeleteReceiver initializer called" userInfo:nil];
}
- (id)initWithS3Service:(S3Service *)theS3 {
	if (self = [super init]) {
        s3 = [theS3 retain];
	}
	return self;
}
- (void)dealloc {
	[s3 release];
	[super dealloc];
}
- (BOOL)receiveS3ObjectMetadata:(S3ObjectMetadata *)metadata error:(NSError **)error {
    if (error != NULL) {
        *error = nil;
    }
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
    BOOL ret = [s3 deletePath:[metadata path] targetConnectionDelegate:nil error:error];
	if (error != NULL) {
		[*error retain];
	}
    [pool drain];
	if (error != NULL) {
		[*error autorelease];
	}
    return ret;
}
@end