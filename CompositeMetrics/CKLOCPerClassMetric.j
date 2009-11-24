@import "CKCompositeMetric.j"

@import "../Metrics/CKClassesMetric.j"
@import "../Metrics/CKLOCMetric.j"

@implementation CKLOCPerClassMetric : CKCompositeMetric
{
}

- (void)reportMetricsForProject
{
    var classes = 0;
    var loc = 0;
    
    for (var i = 0; i < metrics.length; i++)
    {
        var metric = metrics[i];
        
        if ([metric isMemberOfClass:[CKClassesMetric class]])
        {
            classes = [metric totalNumberOfClasses];
        }
        else if ([metric isMemberOfClass:[CKLOCMetric class]])
        {
            loc = [metric totalNumberOfLines];
        }
    }
    
    print("LOC/Class:\t" + (loc / classes));
}

@end