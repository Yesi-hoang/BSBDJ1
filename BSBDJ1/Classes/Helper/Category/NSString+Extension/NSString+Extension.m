//
//  NSString+Extension.m
//  BSBDJ1
//
//  Created by Yesi on 16/8/22.
//  Copyright © 2016年 Yesi. All rights reserved.
//

#import "NSString+Extension.h"

@implementation NSString (Extension)

- (unsigned long long)yy_fileSize{
   // File manager
    NSFileManager *mgr = [NSFileManager defaultManager];
    // File type
    NSDictionary *attr = [mgr attributesOfItemAtPath:self error:nil];
    ;

    NSString *fileType = attr.fileType;

    if ([fileType isEqualToString:NSFileTypeDirectory]) {
        // Get directory enumerator
        NSDirectoryEnumerator *enumerator = [mgr enumeratorAtPath:self];
        // total size
        unsigned long long fileSize = 0;
        // emerate all subdirectories
        for (NSString *subpath in enumerator) {
            // get full subpath
            NSString *subPath = [self stringByAppendingPathComponent:subpath];
            fileSize += [mgr attributesOfItemAtPath:subPath error:nil].fileSize;
        }
        return fileSize;
    }
    return attr.fileSize;
}

- (void)setButtonTitle:(UIButton *)button number:(NSInteger)number placeholder:(NSString *)placeholder{

    if(number >= 1000){
        [button setTitle:[NSString stringWithFormat:@"%.1f万",number/10000.0] forState:UIControlStateNormal];
    }else if (number > 0){
        [button setTitle:[NSString stringWithFormat:@"%zd",number] forState:UIControlStateNormal];
    }else{
        [button setTitle:placeholder forState:UIControlStateNormal];
    }
}
@end
