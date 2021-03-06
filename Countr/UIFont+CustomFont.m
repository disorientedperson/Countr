//
//  UIFont+CustomFont.m
//  Countr
//
//  Created by Lukas Kollmer on 6/13/15.
//  Copyright (c) 2015 Lukas Kollmer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <objc/runtime.h>

/*
 NOTE:
 
 The sole purpose of this class extension is swizzling the [UIFont defaultFont] method. This is currently (as of 19/07/15) disabled.
 
 To re-enable this functionalily, just uncomment the last line of code in +load. (in the for loop)
 */

BOOL LKDeviceOSVersionIsUnder9() {
    NSOperatingSystemVersion osVersion = [[NSProcessInfo processInfo] operatingSystemVersion];
    
    return (osVersion.majorVersion < 9);
}

/*
 This is a class that is only used for storing the implementations of the methods that will be swizzled
 */
@interface LKSwizzledImplementationStorage : NSObject
@property (nonatomic) Method original;
@property (nonatomic) Method swizzled;
@end

@implementation LKSwizzledImplementationStorage
@end


/**
 Ignore the warnings for overriding the following methods
 
 The clang warning code is "[-Wobjc-protocol-method-implementation]"
 */


#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wunused-variable"
//#pragma clang diagnostic ignored "-Wobjc-protocol-method-implementation" // Ignore overridden system methods
//#pragma clang diagnostic ignored "-Wincomplete-implementation" // Ignore missing overridden system methods

@implementation UIFont (CustomSystemFont)

+ (void)load {
    [super load];
    
    //////////////////////////////
    // swizzle the font methods //
    //////////////////////////////
    
    
    LKSwizzledImplementationStorage *systemFontOfSizeImplementations       = [LKSwizzledImplementationStorage new];
    LKSwizzledImplementationStorage *boldSystemFontOfSizeImplementations   = [LKSwizzledImplementationStorage new];
    LKSwizzledImplementationStorage *italicSystemFontOfSizeImplementations = [LKSwizzledImplementationStorage new];
    LKSwizzledImplementationStorage *systemFontOfSizeWeightImplementations = [LKSwizzledImplementationStorage new];
    
    
    // -systemFontofSize
    
    systemFontOfSizeImplementations.original = class_getClassMethod(self, @selector(systemFontOfSize:));
    systemFontOfSizeImplementations.swizzled = class_getClassMethod(self, @selector(swizzledSystemFontOfSize:));
    
    
    // -boldSystemFontofSize
    
    boldSystemFontOfSizeImplementations.original = class_getClassMethod(self, @selector(boldSystemFontOfSize:));
    boldSystemFontOfSizeImplementations.swizzled = class_getClassMethod(self, @selector(swizzledBoldSystemFontOfSize:));
    
    
    // -italicSystemFontofSize
    
    italicSystemFontOfSizeImplementations.original = class_getClassMethod(self, @selector(italicSystemFontOfSize:));
    italicSystemFontOfSizeImplementations.swizzled = class_getClassMethod(self, @selector(swizzledItalicSystemFontOfSize:));
    
    
    // -systemFontofSizeWeight
    
    systemFontOfSizeWeightImplementations.original = class_getClassMethod(self, @selector(systemFontOfSize:weight:));
    systemFontOfSizeWeightImplementations.swizzled = class_getClassMethod(self, @selector(swizzledSystemFontOfSize:weight:));
    
    NSArray *implementations = @[systemFontOfSizeImplementations,
                                 boldSystemFontOfSizeImplementations,
                                 italicSystemFontOfSizeImplementations,
                                 systemFontOfSizeWeightImplementations
                                 ];
    
    for (LKSwizzledImplementationStorage *swizzledImplementation in implementations) {
        //method_exchangeImplementations(swizzledImplementation.original, swizzledImplementation.swizzled);
    }
    
}

// Swizzled methods

+ (UIFont *)swizzledSystemFontOfSize:(CGFloat)fontSize {
    
    if (LKDeviceOSVersionIsUnder9()) {
        return [UIFont fontWithName:@"Avenir-Book" size:fontSize];
    } else {
        return [self swizzledSystemFontOfSize:fontSize];
    }
}

+ (UIFont *)swizzledBoldSystemFontOfSize:(CGFloat)fontSize {

    if (LKDeviceOSVersionIsUnder9()) {
        return [self swizzledSystemFontOfSize:fontSize];
    } else {
        return [UIFont fontWithName:@"Avenir-Heavy" size:fontSize];
    }
}

+ (UIFont *)swizzledItalicSystemFontOfSize:(CGFloat)fontSize {
    
    if (LKDeviceOSVersionIsUnder9()) {
        return [self swizzledSystemFontOfSize:fontSize];
    } else {
        return [UIFont fontWithName:@"Avenir-BookOblique" size:fontSize];
    }
}

+ (UIFont *)swizzledSystemFontOfSize:(CGFloat)fontSize weight:(CGFloat)weight {
    
    if (LKDeviceOSVersionIsUnder9()) {
        return [self swizzledSystemFontOfSize:fontSize];
    } else {
        return [UIFont fontWithName:@"Avenir-Book" size:fontSize];
    }
}


@end
#pragma clang diagnostic pop
