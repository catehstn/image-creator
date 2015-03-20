#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface CHImageTestAsserts : NSObject

/**
 * Asserts two color arrays equal: same number of colors, compares R, G, B, and A values for each.
 */
extern void ICAssertEqualColorArrayByHue(NSArray *array, NSArray *expected, CGFloat accuracy);

/**
 * Asserts two color arrays equal: same number of colors, compares H, S, B, and A values for each.
 */
extern void ICAssertEqualColorArrayByRGB(NSArray *array, NSArray *expected, CGFloat accuracy);

@end
