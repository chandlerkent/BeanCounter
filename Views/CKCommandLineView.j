@import <Foundation/CPObject.j>

@implementation CKCommandLineView : CPObject
{
    CPArray metrics;
}

- (id)init
{
    return [self initWithMetrics:[CPArray array]];
}

- (id)initWithMetrics:(CPArray)someMetrics
{
    if (self = [super init])
    {
        metrics = someMetrics;
    }
    
    return self;
}

- (void)reportMetrics
{
    print("Name\t\tMetric");
    
    for (var i = 0; i < [metrics count]; i++)
    {
        var metric = [metrics objectAtIndex:i];
        var name = [metric name];
        var tabs = (name.length < 6) ? "\t\t" : "\t";
        print(name + ":" + tabs + [metric metricForProject]);
    }
}

@end