package ImagePhash;

use 5.018002;
use strict;
use warnings;

require Exporter;

our @ISA = qw(Exporter);

# Items to export into callers namespace by default. Note: do not export
# names by default without a very good reason. Use EXPORT_OK instead.
# Do not simply export all your public functions/methods/constants.

# This allows declaration	use ImagePhash ':all';
# If you do not need this, moving things directly into @EXPORT or @EXPORT_OK
# will save memory.
our %EXPORT_TAGS = ( 'all' => [ qw(
                                phash
                                pdiff
) ] );

our @EXPORT_OK = ( @{ $EXPORT_TAGS{'all'} } );

our @EXPORT = qw(
	
);

our $VERSION = '0.01';

require XSLoader;
XSLoader::load('ImagePhash', $VERSION);

# Preloaded methods go here.

1;
__END__

=head1 ImagePhash

ImagePhash - Perl binding for pHash (http://phash.org)

=head1 SYNOPSIS

  use ImagePhash qw(pdiff phash);

  my $hash1 = phash("img1.jpg");
  my $hash2 = phash("img1.png");

  my $diff = pdiff($hash1, $hash2);

=head1 DESCRIPTION

Measure similarity between images.

=head2 EXPORT

None by default.

  phash($img)

Calculate a perceptual hash for an image and returns a 16-byte long lowercase hex string
which itself represents a 64bit unsinged integer.

  pdiff($hash1, $hash2)

Calculate the hamming distance between the two image hashes and returns a positive integer less than 64.
A small value means that the two images look similar to each other.

=head1 INSTALL

=over 4

=item *
For linux, libjpeg-dev and libpng-dev are requried.

=item *
For Mac, ImageMagic and libjpeg are required.

=item *
Windows is not supported.

=back

  perl Makefile.PL
  make
  make test
  make install

=head1 SEE ALSO

=over 4

=item *

http://phash.org

=item *

phash bindings for other languages https://github.com/clearscene/pHash/tree/master/bindings

=item *

How to automatically identify similar images using phash http://cloudinary.com/blog/how_to_automatically_identify_similar_images_using_phash

=back

=head1 AUTHOR

Wenjun Yan, E<lt>wenjun.yan.dev@gmail.comE<gt>

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2017 by Wenjun Yan

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself, either Perl version 5.18.2 or,
at your option, any later version of Perl 5 you may have available.

