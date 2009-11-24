BeanCounter is a metrics suite for Cappuccino projects. Currently, BeanCounter has support for calculating the following metrics:

* Lines of Code
* Number of Classes
* Number of Files
* Number of Methods
* Lines of Code Per Class
* Methods per Class

Contributing
============
It is very easy to add a new type of metric to BeanCounter (it will be much easier in the future, possibly using a plug-in architecture). If you wish to create a base metric (a metric that does not depend on any other metric), subclass CKMetric and implement:
    - (void)updateMetricForFile:(id)file line:(CPString)line
    - (void)reportMetricForFile:(id)file
    - (void)reportMetricsForProject
See some of the current metrics in Metrics/ for an example.

If you wish to create a composite metric (a metric which depends on one or more metric), subclass CKCompositeMetric and implement:
    - (void)reportMetricsForProject
See some examples in CompositeMetrics/.

Composite metrics are still fairly experiment, so the API may change in the near future.

To have your new metric be run with the rest of the metrics, add an @import statement to CKMetricSuite.j and add your new metric to the metrics array in that class. See all the examples. (Again, this is an area that is still very experimental. I want this to be much easier so you won't have to do this in the future. But for now, this is how it needs to be done.)

Installation Instructions
=========================
Simply clone or download BeanCounter to any directory you wish. If you want to have BeanCounter available quickly from any location, add this to your bash profile:
    export PATH="/path/to/BeanCounterInstallation:PATH"

Usage Instructions
==================
From the top-level directory of your Cappuccino project, run /path/to/BeanCounterInstallation/BeanCounter.j on the command line. If you don't have a Cappuccino project and would like to try BeanCounter, you can run BeanCounter on itself by running ./BeanCounter.j from the command line in the top-level directory of your BeanCounter download.

If you have optionally put BeanCounter on your path, you can run BeanCounter.j from any Cappuccino Project.

Dependencies
============
Currently, BeanCounter depends on [Narwhal](http://github.com/tlrobinson/narwhal).