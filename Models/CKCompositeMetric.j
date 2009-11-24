@import "CKMetric.j"

@implementation CKCompositeMetric : CKMetric
{
    CPArray metrics;
}

- (id)initWithName:(CPString)aName
{
    return [self initWithName:aName metrics:[CPArray array]];
}

- (id)initWithName:(CPString)aName metrics:(CPArray)someMetrics
{
    if (self = [super initWithName:aName])
    {
        metrics = someMetrics;
    }
    
    return self;
}

/*
 * Override default implementation to do nothing.
 */
- (void)updateMetricForFile:(id)file line:(CPString)line
{
}

- (id)metricForFile:(id)file
{
    if ([self isNewFile:file])
    {
        return nil;
    }
    
    var compositeMetric;
    for (var i = 0; i < [metrics count]; i++)
    {
        if (!compositeMetric)
        {
            compositeMetric = [[metrics objectAtIndex:i] metricForFile:file];
        }
        else
        {
            compositeMetric /= [[metrics objectAtIndex:i] metricForFile:file];
        }
    }
    
    return compositeMetric;
}

- (id)metricForProject
{
    var compositeMetric;
    for (var i = 0; i < [metrics count]; i++)
    {
        if (!compositeMetric)
        {
            compositeMetric = [[metrics objectAtIndex:i] metricForProject];
        }
        else
        {
            compositeMetric /= [[metrics objectAtIndex:i] metricForProject];
        }
    }
    
    return compositeMetric;
}

@end