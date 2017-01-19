//
//  UIImageView+Geometry.m
//  NerdWiki
//
//  Created by Jean Raphael Bordet on 02/11/2016.
//  Copyright © 2016 Jean Raphael Bordet. All rights reserved.
//

#import "UIImageView+Geometry.h"

@implementation UIImageView (Geometry)

- (void)rounded {
    self.layer.cornerRadius = self.frame.size.height / 2;
    self.layer.masksToBounds = YES;
    self.layer.borderWidth = 0;
}

- (void)imageWithWithImageName:(NSString *)imageName height:(int)height {
    UIImage *image = [UIImage imageWithContentsOfFile:imageName];
    
    if (image.size.height > height) {
        NSData *imageData = UIImagePNGRepresentation(image);
        
        self.image = [UIImage imageWithData:imageData
                                scale:[self scaleFactor:imageData
                                                 height:height]];
    }
}

- (float)scaleFactor:(NSData *)imageData height:(int)height {
    UIImage *image = [UIImage imageWithData:imageData];
    
    float widthScaled = (image.size.width / image.size.height) * (height);
    
    float scaleFactor = (image.size.width / (widthScaled));
    return scaleFactor;
}

- (void)centerWithSize:(CGSize)frame {
     self.center = CGPointMake(frame.width / 2, frame.height / 2);
}

@end
