@import <Foundation/CPObject.j>

@implementation CKMetric : CPObject
{
    CPString name @accessors;
    CPArray files;
}

- (id)init
{
    return [self initWithName:nil];
}

- (id)initWithName:(CPString)aName
{
    if (self = [super init])
    {
        name = aName;
        files = [];
    }
    
    return self;
}

- (BOOL)isNewFile:(id)file
{
    if ([files indexOfObject:file] == CPNotFound)
    {
        return YES;
    }
    
    return NO;
}

- (void)updateMetricForFile:(id)file line:(CPString)line
{
    CPLog(@"%@: not yet implemented.", [self className]);
}

- (void)reportMetricForFile:(id)file
{
    CPLog(@"%@: not yet implemented.", [self className]);
}

- (void)reportMetricsForProject
{
    CPLog(@"%s not yet implemented.", _cmd);
}

@end