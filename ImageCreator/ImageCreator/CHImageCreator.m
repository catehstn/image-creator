#import "CHImageCreator.h"

@implementation CHImageCreator

UIImage* createTestImage(CGFloat width, CGFloat height, UIColor *color) {
  CGRect rect = CGRectMake(0, 0, width, height);
  UIGraphicsBeginImageContext(rect.size);
  [color set];
  UIRectFill(rect);
  UIImage *testImage = UIGraphicsGetImageFromCurrentImageContext();
  UIGraphicsEndImageContext();
  return testImage;
}

UIImage* createTestImageNineQuadrants(UIColor *color1, UIColor *color2) {
  // Create a 3x3 image with alternating colors.
  CGRect rect = CGRectMake(0, 0, 3.0, 3.0);
  UIGraphicsBeginImageContext(rect.size);
  [color1 set];
  UIRectFill(CGRectMake(0, 0, 1, 1));
  UIRectFill(CGRectMake(2, 0, 1, 1));
  UIRectFill(CGRectMake(1, 1, 1, 1));
  UIRectFill(CGRectMake(0, 2, 1, 1));
  UIRectFill(CGRectMake(2, 2, 1, 1));

  [color2 set];
  UIRectFill(CGRectMake(1, 0, 1, 1));
  UIRectFill(CGRectMake(0, 1, 1, 1));
  UIRectFill(CGRectMake(2, 1, 1, 1));
  UIRectFill(CGRectMake(1, 2, 1, 1));
  UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
  UIGraphicsEndImageContext();
  return image;
}

UIImage* createTestImageWithFourColors() {
  // Create an image with 4 quadrants of color.
  CGRect rect = CGRectMake(0, 0, 2.0, 2.0);
  UIGraphicsBeginImageContext(rect.size);
  [[UIColor redColor] set];
  UIRectFill(CGRectMake(0, 0, 1, 1));
  [[UIColor greenColor] set];
  UIRectFill(CGRectMake(1, 0, 1, 1));
  [[UIColor blueColor] set];
  UIRectFill(CGRectMake(0, 1, 1, 1));
  [[UIColor blackColor] set];
  UIRectFill(CGRectMake(1, 1, 1, 1));
  UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
  UIGraphicsEndImageContext();
  return image;
}

UIImage* createTestImageWithColors(NSArray *pixelData, NSInteger width, NSInteger height) {
  CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();

  // Add 1 for the alpha channel
  size_t numberOfComponents = CGColorSpaceGetNumberOfComponents(colorSpace) + 1;
  size_t bitsPerComponent = 8;
  size_t bytesPerPixel = (bitsPerComponent * numberOfComponents) / 8;
  size_t bytesPerRow = bytesPerPixel * width;
  uint8_t *rawData = (uint8_t*)calloc([pixelData count] * numberOfComponents, sizeof(uint8_t));

  CGContextRef context = CGBitmapContextCreate(rawData,
                                               width,
                                               height,
                                               bitsPerComponent,
                                               bytesPerRow,
                                               colorSpace,
                                               (CGBitmapInfo) kCGImageAlphaPremultipliedLast);

  CGColorSpaceRelease(colorSpace);

  NSInteger byteIndex = 0;
  for (NSInteger index = 0; index < [pixelData count]; index += 1) {
    CGFloat r, g, b, a;
    BOOL convert = [pixelData[index] getRed:&r green:&g blue:&b alpha:&a];
    if (!convert) {
      // TODO(cate): Handle this.
      NSLog(@"Failed, continue");
    }
    rawData[byteIndex] = r * 255;
    rawData[byteIndex + 1] = g * 255;
    rawData[byteIndex + 2] = b * 255;
    rawData[byteIndex + 3] = a * 255;
    byteIndex += 4;
  }

  CGImageRef imageRef = CGBitmapContextCreateImage(context);
  UIImage *newImage = [UIImage imageWithCGImage:imageRef];
  CGContextRelease(context);
  CGImageRelease(imageRef);
  return newImage;
}

NSArray* pixelsForImage(UIImage *image) {
  NSInteger width = [image size].width;
  NSInteger height = [image size].height;
  NSInteger count = width * height;
  NSMutableArray *result = [NSMutableArray arrayWithCapacity:count];

  CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();

  // Add 1 for the alpha channel
  size_t numberOfComponents = CGColorSpaceGetNumberOfComponents(colorSpace) + 1;
  size_t bitsPerComponent = 8;
  size_t bytesPerPixel = (bitsPerComponent * numberOfComponents) / 8;
  size_t bytesPerRow = bytesPerPixel * width;

  uint8_t *rawData = (uint8_t*)calloc(count * numberOfComponents, sizeof(uint8_t));

  CGContextRef context = CGBitmapContextCreate(rawData,
                                               width,
                                               height,
                                               bitsPerComponent,
                                               bytesPerRow,
                                               colorSpace,
                                               (CGBitmapInfo) kCGImageAlphaPremultipliedLast);

  CGColorSpaceRelease(colorSpace);

  CGImageRef cgImage = [image CGImage];
  CGContextDrawImage(context, CGRectMake(0, 0, width, height), cgImage);

  NSInteger byteIndex = 0;
  for (NSInteger i = 0 ; i < count ; ++i) {
    CGFloat red   = (rawData[byteIndex] * 1.0) / 255.0;
    CGFloat green = (rawData[byteIndex + 1] * 1.0) / 255.0;
    CGFloat blue  = (rawData[byteIndex + 2] * 1.0) / 255.0;
    CGFloat alpha = (rawData[byteIndex + 3] * 1.0) / 255.0;
    byteIndex += 4;

    UIColor *color = [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
    [result addObject:color];
  }

  CGContextRelease(context);
  free(rawData);
  
  return result;
}

@end
