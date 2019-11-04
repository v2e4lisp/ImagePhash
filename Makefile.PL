use 5.018002;
use File::Basename;
use File::Spec;
use ExtUtils::MakeMaker;

my $basedir = File::Spec->rel2abs(dirname(__FILE__));

my $deps_dir = "$basedir/deps";
my $include_dir = "$basedir/deps/include";
my $phash_src_dir = "$deps_dir/pHash-0.9.6";

# See lib/ExtUtils/MakeMaker.pm for details of how to influence
# the contents of the Makefile that is written.
WriteMakefile(
    NAME              => 'ImagePhash',
    VERSION_FROM      => 'lib/ImagePhash.pm', # finds $VERSION
    PREREQ_PM         => {}, # e.g., Module::Name => 1.1
    ($] >= 5.005 ?     ## Add these new keywords supported since 5.005
      (ABSTRACT_FROM  => 'lib/ImagePhash.pm', # retrieve abstract from module
       AUTHOR         => 'Wenjun Yan <wenjunyan.dev@google.com>') : ()),
    LIBS              => ["-lstdc++ -ljpeg -lpng -lmvec -lm"], # e.g., '-lm'
    DEFINE            => '', # e.g., '-DHAVE_SOMETHING'
    INC               => "-I. -I$include_dir", # e.g., '-I. -I/usr/include/other'
    MYEXTLIB          => "$deps_dir/lib/libpHash.a",
    CCFLAGS           => '-x c++',
	# Un-comment this if you add C files to link with later:
    # OBJECT            => '$(O_FILES)', # link all the C files too
);

sub MY::postamble {
<<"END_MAKE";
\$(MYEXTLIB):
	cd $deps_dir && tar xzfv pHash-0.9.6.tar.gz
	cd $phash_src_dir && env CPPFLAGS='-I$include_dir' CFLAGS='-x c++' ./configure --prefix=$deps_dir --disable-audio-hash --disable-video-hash --disable-shared --with-pic --disable-pthread && make && make install
END_MAKE
}

