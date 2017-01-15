use strict;
use warnings;

use ImagePhash qw(pdiff phash);

my $hash1 = phash("koala1.jpg");
my $hash2 = phash("koala2.jpg");
my $hash3 = phash("koala3.jpg");
my $hash4 = phash("koala4.jpg");
my $hash5 = phash("another_koala.jpg");
my $hash6 = phash("woman1.jpg");

comp($hash1, $hash2);
comp($hash1, $hash3);
comp($hash1, $hash4);
comp($hash1, $hash5);
comp($hash1, $hash6);

sub comp {
    my $hash1 = shift;
    my $hash2 = shift;
    print "$hash1, $hash2\n";
    my $diff = pdiff($hash1, $hash2);
    my $score = 1 - ($diff / 64.0);
    print "$hash1, $hash2 :", "diff: $diff, score: $score". "\n";
}

