@import "CKCompositeMetric.j"

@import "../Metrics/CKTestCasesMetric.j"
@import "../Metrics/CKMethodsMetric.j"

@implementation CKTestCasesPerMethodMetric : CKCompositeMetric
{
}

- (void)reportMetricsForProject
{
    var testCases = 0;
    var methods = 0;
    
    for (var i = 0; i < metrics.length; i++)
    {
        var metric = metrics[i];
        
        if ([metric isMemberOfClass:[CKTestCasesMetric class]])
        {
            testCases = [metric totalNumberOfTestCases];
        }
        else if ([metric isMemberOfClass:[CKMethodsMetric class]])
        {
            methods = [metric totalNumberOfMethods];
        }
    }
    
    print("Tests/Method:\t" + (testCases / methods));
}

@end