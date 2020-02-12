#import <Foundation/Foundation.h>

// test "instancetype"
@protocol ConvenienceConstructor
+(instancetype)defaultObject;
@end

@interface MyClass : NSObject <ConvenienceConstructor>
// test @property
@property NSInteger value;
@end

@implementation MyClass
+(instancetype)defaultObject
{
	// test "new"
	return [MyClass new];
}
-(instancetype)init
{
	if (self = [super init]) {
		self.value = 42;
	}
	return self;
}
@end 


int main(int argc, char *argv[]) {
	// test @autoreleasepool
	@autoreleasepool {
		MyClass *obj = [MyClass defaultObject];
		NSLog(@"%ld", obj.value); // => 42
		
		obj.value++;
		NSLog(@"%ld", obj.value); // => 43
		
		// test Object Literal and Lightweight Generics
		NSMutableArray<NSNumber*> *array = [NSMutableArray arrayWithArray:@[@100, @200, @300, @YES, @NO]];;
		NSMutableDictionary<NSString*, NSNumber*> *dict = [NSMutableDictionary dictionaryWithDictionary:@{@"hoge": @42, @"fuga": @57}];
		
		// test Object Subscripting  and Dot Notation
		array[0] = @(array[0].integerValue + 1);
		NSLog(@"%ld", array[0].integerValue); // => 101
		dict[@"piyo"] = @(dict[@"hoge"].integerValue + 1);
		NSLog(@"%ld", dict[@"piyo"].integerValue); // => 43
		
		// test Blocks
		NSArray<NSArray<NSNumber*>*> *unsortedArray = @[@[@8,@5], @[@5,@4], @[@5,@1], @[@5,@5], @[@5,@1]];

		NSArray<NSArray<NSNumber*>*> *sortedArray = [unsortedArray sortedArrayUsingComparator:^NSComparisonResult(NSArray<NSNumber*> *p, NSArray<NSNumber*> *q) {
			NSInteger a = p[0].integerValue;
			NSInteger b = p[1].integerValue;
			NSInteger c = q[0].integerValue;
			NSInteger d = q[1].integerValue;
			if (a < c) {
					return NSOrderedAscending;
			} else if (a > c) {
					return NSOrderedDescending;
			} else {
					if (b < d) {
							return NSOrderedAscending;
					} else if (b > d) {
							return NSOrderedDescending;
					} else {
							return NSOrderedSame;
					}
			}
		}];

		NSLog(@"%@", [sortedArray description]); // => ((5,1),(5,1),(5,4),(5,5),(8,5))
		
		// test NSRegularExpression
		NSError *error = nil;
		NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"([a-zA-Z]+)(\\d+)" options:0 error:&error];
		if (!error) {
			NSString *str = @"012ABC345abc678";
			NSArray<NSTextCheckingResult*> *matches = [regex matchesInString:str options:0 range:NSMakeRange(0, str.length)];
			for (NSTextCheckingResult *match in matches) {
				NSLog(@"$1 => %@", [str substringWithRange:[match rangeAtIndex:1]]);
				NSLog(@"$2 => %@", [str substringWithRange:[match rangeAtIndex:2]]);
			}
		}
	}
}