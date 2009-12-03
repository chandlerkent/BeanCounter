@import <Foundation/CPObject.j>

@implementation CKMetric : CPObject
{
    CPString    name        @accessors;
    CPArray     metric      @accessors;
    CPArray     files       @accessors;
    id          totalMetric @accessors;
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
        files = [CPArray array];
        metric = [CPArray array];
    }
    
    return self;
}

/*
 * Checks if we have seen this file before.
 */
- (BOOL)isNewFile:(id)file
{
    if ([files indexOfObject:file] == CPNotFound)
    {
        return YES;
    }
    
    return NO;
}

/*
 * Returns the starting value for each metric for a file. Defaults to 0. Override for different functionality.
 */
- (id)defaultFileMetric
{
    return 0;
}

/*
 * Returns the starting value for each metric for a project. Defaults to 0. Override for different functionality.
 */
- (id)defaultProjectMetric
{
    return 0;
}

/*
 * Called for each line of every file. Overrides should call this implementation first and then provide custom functionality
 * unless you understand the consequences. This implementation assumes files will be accessed in an order and only one time.
 */
- (void)updateMetricForFile:(id)file line:(CPString)line
{
    // These should use KVC methods for future utility
    if ([self isNewFile:file])
    {
        [files addObject:file];
        [metric addObject:[self defaultFileMetric]];  
    }
}

/*
 * Called once for each metric to calculate the total metric for the project. The default simply adds the metrics.
 */
- (id)calculateTotalMetricWithStartingMetric:(id)startingMetric andNewMetric:(id)newMetric
{
    return startingMetric + newMetric;
}

- (id)metricForFile:(id)file
{
    if ([self isNewFile:file])
    {
        return nil;
    }
    
    return [metric objectAtIndex:[files indexOfObject:file]];
}

- (id)metricForProject
{
    var totalMetric = [self defaultProjectMetric];
    
    for (var i = 0; i < [metric count]; i++)
    {
        totalMetric = [self calculateTotalMetricWithStartingMetric:totalMetric andNewMetric:[metric objectAtIndex:i]];
    }
    
    return totalMetric;
}

@end