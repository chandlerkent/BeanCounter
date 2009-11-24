#!/usr/bin/env objj
 
@import <Foundation/Foundation.j>

@import "Controllers/CKMetricSuite.j"

var metricSuite = [[CKMetricSuite alloc] init];
[metricSuite startWithArguments:args];