@import "CKCompositeMetric.j"

@import "CKClassesMetric.j"
@import "CKMethodsMetric.j"

@implementation CKMethodsPerClassMetric : CKCompositeMetric
{
}

- (void)reportMetricsForProject
{
    var classes = 0;
    var methods = 0;
    
    for (var i = 0; i < metrics.length; i++)
    {
        var metric = metrics[i];
        
        if ([metric isMemberOfClass:[CKClassesMetric class]])
        {
            classes = [metric totalNumberOfClasses];
        }
        else if ([metric isMemberOfClass:[CKMethodsMetric class]])
        {
            methods = [metric totalNumberOfMethods];
        }
    }
    
    print("Methods/Class:\t" + (methods / classes));
}

@end