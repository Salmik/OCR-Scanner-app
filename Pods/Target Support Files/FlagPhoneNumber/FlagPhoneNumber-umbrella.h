#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "NBRegExMatcher.h"
#import "NBRegularExpressionCache.h"
#import "NBAsYouTypeFormatter.h"
#import "NBGeneratedPhoneNumberMetaData.h"
#import "NBMetadataHelper.h"
#import "NBNumberFormat.h"
#import "NBPhoneMetaData.h"
#import "NBPhoneNumber.h"
#import "NBPhoneNumberDefines.h"
#import "NBPhoneNumberDesc.h"
#import "NBPhoneNumberUtil+ShortNumber.h"
#import "NBPhoneNumberUtil.h"
#import "NSArray+NBAdditions.h"

FOUNDATION_EXPORT double FlagPhoneNumberVersionNumber;
FOUNDATION_EXPORT const unsigned char FlagPhoneNumberVersionString[];

