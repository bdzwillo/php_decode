use strict;
use warnings;

use 5.016;
use ExtUtils::MakeMaker;

WriteMakefile(
	NAME             => 'PHP::Decode',
	AUTHOR           => 'Barnim Dzwillo @ Strato AG',
	VERSION_FROM     => 'lib/PHP/Decode.pm',
	ABSTRACT_FROM    => 'lib/PHP/Decode.pm',
	MIN_PERL_VERSION => "5.016",
	PREREQ_PM => {
		'Tie::IxHash' => 1,
		'Compress::Zlib' => 1,
		'Digest::MD5' => 1,
		'Digest::SHA1' => 1,
		'MIME::Base64' => 1,
		'URI::Escape' => 1,
		'HTML::Entities' => 1,
	},
	EXE_FILES        => [ 'php_decode' ],
	TEST_REQUIRES    => {
		'Test::More' => 1, # should be in core but is seperately packaged by RH
	},
);

# create rpm via 'make rpm'
#
sub MY::postamble {
return <<'MAKE_DOCS';
MARKDOWNPAGES = $(foreach manpage, ${MAN3PODS},docs/$(subst /,::,$(patsubst lib/%.pm,%,${manpage})).md)

docs/%.md:
	pod2markdown lib/$(subst ::,/,$*).pm $@

.PHONY: docs
docs:
	-rm -f $(MARKDOWNPAGES)
	make $(MARKDOWNPAGES)
MAKE_DOCS
}
