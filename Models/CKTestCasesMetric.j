@import "CKMethodsMetric.j"

@implementation CKTestCasesMetric : CKMethodsMetric
{
}

- (BOOL)shouldUpdateMetricForFile:(id)file line:(CPString)line
{
    if ([self isFileATestFile:file])
    {
        if ([self isLineAMethod:line] && [self isMethodATestCase:line])
        {
            return YES;
        }
    }
    
    return NO;
}

@end