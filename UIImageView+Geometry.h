//
//  UIImageView+Geometry.h
//  NerdWiki
//
//  Created by Jean Raphael Bordet on 02/11/2016.
//  Copyright © 2016 Jean Raphael Bordet. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (Geometry)

- (void)rounded;
- (void)imageWithWithImageName:(NSString *)imageName height:(int)height;
- (void)centerWithSize:(CGSize)frame;

@end
