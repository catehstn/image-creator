#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface CHImageTestAsserts : NSObject

extern void assertEqualColorArrayByHue(NSArray *array, NSArray *expected, CGFloat accuracy);
extern void assertEqualColorArrayByRGB(NSArray *array, NSArray *expected, CGFloat accuracy);
extern void assertEqualFloatArray(NSArray *array, NSArray *expected, CGFloat accuracy);
extern void assertEqualCFloatArraysWithAccuracy(CGFloat *array,
                                                CGFloat *expected,
                                                NSInteger length,
                                                CGFloat accuracy);

@end
