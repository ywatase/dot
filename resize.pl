#!/usr/bin/env perl
my $resize = shift @ARGV;
while(<>){ next if $i++ % $resize; s/(.){$resize}/\1/g; print}
