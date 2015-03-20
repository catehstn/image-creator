#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface CHImageTestAsserts : NSObject

extern void ICAssertEqualColorArrayByHue(NSArray *array, NSArray *expected, CGFloat accuracy);
extern void ICAssertEqualColorArrayByRGB(NSArray *array, NSArray *expected, CGFloat accuracy);
extern void ICAssertEqualFloatArray(NSArray *array, NSArray *expected, CGFloat accuracy);
extern void ICAssertEqualCFloatArraysWithAccuracy(CGFloat *array,
                                                  CGFloat *expected,
                                                  NSInteger length,
                                                  CGFloat accuracy);

@end
