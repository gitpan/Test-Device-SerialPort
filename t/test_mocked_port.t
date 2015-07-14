#! /usr/bin/env perl

use strict;
use warnings;

use Test::More tests => 5;
BEGIN { use_ok('Test::Device::SerialPort') };

my $port = Test::Device::SerialPort->new;

$port->mock_port(1);
$port->mock_messages('abc', 'def');

is_deeply [$port->read(1)], [1,'a'],
    'Read one character off the mocked port';
is_deeply [$port->read(3)], [3,'bcd'],
    'Read three more characters';

is_deeply [$port->read(5)], [2,'ef'],
    'Read the rest of the characters';

is_deeply [$port->read(3)], [0, ''],
    'Empty buffer returns 0 bytes and a null character';

done_testing();
