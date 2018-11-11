#！/usr/bin/perl -w
use strict;
use DBIx::Simple;

my $db = DBIx::Simple->connect('dbi:SQLite:dbname=file.dat')
         or die DBIx::Simple->error;

