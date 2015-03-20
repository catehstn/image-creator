#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>

#import "CHImageCreator.h"
#import "CHImageTestAsserts.h"

@interface ImageCreatorTests : XCTestCase

@end

@implementation ImageCreatorTests

static const CGFloat kAccuracy = 0.005;

- (void)testCreateImageFromImageConsistentPixelDataOneColor {
  UIColor *color = [UIColor yellowColor];
  NSArray *pixelData = @[color, color, color, color];
  UIImage *image = createTestImageWithColors(pixelData, 2, 2);

  XCTAssertEqual([image size].width, 2);
  XCTAssertEqual([image size].height, 2);
}

- (void)testCreateImageFromImageConsistentPixelData {
  NSArray *pixelData =
      @[[UIColor redColor], [UIColor greenColor], [UIColor blueColor], [UIColor blackColor]];
  UIImage *image = createTestImageWithColors(pixelData, 2, 2);

  XCTAssertEqual([image size].width, 2);
  XCTAssertEqual([image size].height, 2);
}

- (void)testCreateImageAndUnpackFromImageConsistentPixelDataOneColor {
  UIColor *color = [UIColor purpleColor];
  NSArray *pixelData = @[color, color, color, color];
  UIImage *image = createTestImageWithColors(pixelData, 2, 2);

  XCTAssertEqual([image size].width, 2);
  XCTAssertEqual([image size].height, 2);
  NSArray *colorArray = pixelsForImage(image);
  assertEqualColorArrayByRGB(colorArray, pixelData, kAccuracy);
}

- (void)testCreateImageAndUnpackFromImageConsistentPixelData {
  NSArray *pixelData =
      @[[UIColor redColor], [UIColor greenColor], [UIColor blueColor], [UIColor blackColor]];
  UIImage *image = createTestImageWithColors(pixelData, 2, 2);
  XCTAssertEqual([image size].width, 2);
  XCTAssertEqual([image size].height, 2);

  NSArray *colorArray = pixelsForImage(image);
  assertEqualColorArrayByRGB(colorArray, pixelData, kAccuracy);
}

#pragma mark pixels for image

- (void)testPixelsForImageAllBlack {
  UIColor *color  = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:1.0];
  UIImage *testImage = createTestImage(2.0, 2.0, color);

  NSArray *result = pixelsForImage(testImage);
  XCTAssertEqual(4, [result count]);
  NSArray *expected = @[color, color, color, color];
  assertEqualColorArrayByRGB(result, expected, kAccuracy);
}

- (void)testPixelsForImageAllRed {
  UIColor *color  = [UIColor colorWithRed:0.9 green:0.0 blue:0.0 alpha:1.0];
  UIImage *testImage = createTestImage(2.0, 2.0, color);

  NSArray *result = pixelsForImage(testImage);
  XCTAssertEqual(4, [result count]);
  NSArray *expected = @[color, color, color, color];
  assertEqualColorArrayByRGB(result, expected, kAccuracy);
}

- (void)testPixelsForImageAllGreen {
  UIColor *color = [UIColor colorWithRed:0.0 green:0.9 blue:0.0 alpha:1.0];
  UIImage *testImage = createTestImage(2.0, 2.0, color);

  NSArray *result = pixelsForImage(testImage);
  XCTAssertEqual(4, [result count]);
  NSArray *expected = @[color, color, color, color];
  assertEqualColorArrayByRGB(result, expected, kAccuracy);
}

- (void)testPixelsForImageAllBlue {
  UIColor *color = [UIColor colorWithRed:0.0 green:0.0 blue:0.9 alpha:1.0];
  UIImage *testImage = createTestImage(2.0, 2.0, color);

  NSArray *result = pixelsForImage(testImage);
  XCTAssertEqual(4, [result count]);
  NSArray *expected = @[color, color, color, color];
  assertEqualColorArrayByRGB(result, expected, kAccuracy);
}

- (void)testPixelsForImageMulticolor {
  UIImage *testImage = createTestImageWithFourColors();

  NSArray *result = pixelsForImage(testImage);
  XCTAssertEqual(4, [result count]);
  NSArray *expected =
  @[[UIColor redColor], [UIColor greenColor], [UIColor blueColor], [UIColor blackColor]];
  assertEqualColorArrayByRGB(result, expected, kAccuracy);
}

@end
