# 越界类型

### NSString

https://developer.apple.com/library/content/documentation/Cocoa/Conceptual/Strings/Articles/CreatingStrings.html#//apple_ref/doc/uid/20000148-CJBCJHHI

Objective-C string constant is created at compile time and exists throughout your program’s execution. The compiler makes such object constants unique on a per-module basis, and they’re never deallocated.

```
- (unichar)characterAtIndex:(NSUInteger)index;
- (NSString *)substringFromIndex:(NSUInteger)from;
- (NSString *)substringToIndex:(NSUInteger)to;
- (NSString *)substringWithRange:(NSRange)range;
- (void)getCharacters:(unichar *)buffer range:(NSRange)range;
- (NSComparisonResult)compare:(NSString *)string options:(NSStringCompareOptions)mask range:(NSRange)rangeOfReceiverToCompare;
- (NSComparisonResult)compare:(NSString *)string options:(NSStringCompareOptions)mask range:(NSRange)rangeOfReceiverToCompare
```



