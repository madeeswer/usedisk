#!/usr/local/bin/ruby
#
# You may specify the path to the FastCGI crash log (a log of unhandled
# exceptions which forced the FastCGI instance to exit, great for debugging)
# and the number of requests to process before running garbage collection.
#
# By default, the FastCGI crash log is RAILS_ROOT/log/fastcgi.crash.log
# and the GC period is nil (turned off).  A reasonable number of requests
# could range from 10-100 depending on the memory footprint of your app.
#
# Example:
#   # Default log path, normal GC behavior.
#   RailsFCGIHandler.process!
#
#   # Default log path, 50 requests between GC.
#   RailsFCGIHandler.process! nil, 50
#
#   # Custom log path, normal GC behavior.
#   RailsFCGIHandler.process! '/var/log/myapp_fcgi_crash.log'
#
ENV = Hash.new
ENV['RUBY_HEAP_MIN_SLOTS']=600000
ENV['RUBY_HEAP_SLOTS_INCREMENT']=100000
ENV['RUBY_HEAP_SLOTS_GROWTH_FACTOR']=1
ENV['RUBY_GC_MALLOC_LIMIT']=59000000
ENV['RUBY_HEAP_FREE_MIN']=100000


require File.dirname(__FILE__) + "/../config/environment"
require 'fcgi_handler'
#ENV['RUBY_HEAP_MIN_SLOTS']=600000


RailsFCGIHandler.process!
