@import "CKMetricReporter.j"

@implementation CKMetric : CKMetricReporter
{
    CPString    name    @accessors;
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

- (BOOL)addFileIfNew:(id)file
{
    if ([self isNewFile:file])
    {
        [self willChangeValueForKey:@"files"];
        files.push(file);
        [self didChangeValueForKey:@"files"];
        return YES;
    }
    
    return NO;
}

- (void)updateMetricForFile:(id)file line:(CPString)line
{
    CPLog(@"%@: not yet implemented.", [self className]);
}

@end