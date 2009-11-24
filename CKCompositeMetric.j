@import "CKMetricReporter.j"

@implementation CKCompositeMetric : CKMetricReporter
{
    CPArray metrics;
}

- (id)init
{
    return [self initWithMetrics:nil];
}

- (id)initWithMetrics:(CPArray)someMetrics
{
    if (self = [super init])
    {
        metrics = someMetrics;
        [self registerAsObserverOfMetrics];
    }
    
    return self;
}

- (void)registerAsObserverOfMetrics
{
    for (var i = 0; i < metrics.length; i++)
    {
        var metric = metrics[i];
        [metric addObserver:self forKeyPath:@"files" options:CPKeyValueChangeNewKey context:nil];
    }
}

- (void)observeValueForKeyPath:(CPString)keyPath ofObject:(id)object change:(CPDictionary)changes context:(id)aContext
{
    switch (keyPath)
    {
        case @"files":
            files = [object files];
            break;
        default:
            CPLog(@"%s: unexpected case in %s.", _cmd, [self className]);
            break;
    }
}

@end