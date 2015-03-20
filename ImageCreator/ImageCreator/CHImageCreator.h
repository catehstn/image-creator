#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface CHImageCreator : NSObject

/**
 * Creates a one color test image with the given width and height.
 */
extern UIImage* createTestImage(CGFloat width, CGFloat height, UIColor *color);

/**
 * Creates a 3x3 2-color alternating image.
 */
extern UIImage* createTestImageNineQuadrants(UIColor *color1, UIColor *color2);

/**
 * Creates a 2x2 4-color image: red, green, blue, black.
 */
extern UIImage* createTestImageWithFourColors();

/**
 * Create a test image from a given array of colors, with the given width and height.
 */
extern UIImage* createTestImageWithColors(NSArray *pixelData, NSInteger width, NSInteger height);

/**
 * Extract an array of UIColors from the given image.
 */
extern NSArray* pixelsForImage(UIImage *image);

@end
