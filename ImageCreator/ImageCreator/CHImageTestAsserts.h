#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface CHImageTestAsserts : NSObject

extern void ICAssertEqualColorArrayByHue(NSArray *array, NSArray *expected, CGFloat accuracy);
extern void ICAssertEqualColorArrayByRGB(NSArray *array, NSArray *expected, CGFloat accuracy);

@end
