# NAME

PHP::Decode - Parse and transform obfuscated php code

# SYNOPSIS

    # Create an instance

    sub warn_msg {
          my ($action, $fmt) = (shift, shift);
          my $msg = sprintf $fmt, @_;
          print 'WARN: ', $action, ': ', $msg, "\n";
    }
    my $php = PHP::Decode->new(warn => \&warn_msg);

    # Parse and transform php code

    my $stmt = $php->eval('<?php echo "test"; ?>');

    # Expand to code again

    my $code = $php->format($stmt, {indent => 1});
    print $code;

    # Output: echo 'test' ; $STDOUT = 'test' ;

# DESCRIPTION

The PHP::Decode module applies static transformations to PHP statements parsed
by the [PHP::Decode::Parser](https://metacpan.org/pod/PHP::Decode::Parser) module and returns the transformed PHP code.

The decoder uses a custom php parser which does not depend on a special php
version. It supports most php syntax of interpreters from php5 to php8.
This is a pure perl implementation and requires no external php interpreter.

The parser assumes that the input file is a valid php script, and does
not enforce strict syntactic checks. Unrecognized tokens are simply passed
through.

The parser converts the php code into a unified form when the resulting
output is formatted (for example intermittent php-script-tags and variables
from string interpolation are removed and rewritten to php echo statements).
The parsed result is available before other transformations are applied.

The transformer is run by calling the exec-method on the parsed php statements,
and partially executes the php code. It tries to apply all possible static
code transformations based on php variables and values defined in the script.

The transformer does not implement php functions with any kind of side-effect
that require access to external resources like file-io or network-io. Statements
with references to unresolvable input values like cgi-variables or file-content
are skipped and corresponding variables are marked as unresolved.

The transformer supports many of the pure php built-in functions, but not all
function parameters are supported. Function calls with unresolved parameters
are skipped and kept unmodified in the transformer output. In most cases the
resulting php code will be valid and produce the same results as the original
script.

While the transformer executes, all script output to stdout (like echo or
print statements) is captured and appended as a '$STDOUT = <str>' statement
to the transformed code.

The format method converts the resulting php statements to php code again,
and allows to output the code in indented form or as a single line.

## Malware analysis

The php decoder was mainly developed on a case-by-case basis to support
malware analysis. It proved to be useful when applied to many obfuscated
malware scipts found in the wild.

One aim is to expose the active parts of malware scripts. For example
statements which try to execute arbitrary code passed via cgi-variables
might be visible after a script was decoded.

Since newer php versions are adding new syntax and deprecating older syntax,
there is always room for improvement of the decoder.

Newer php versions started to deprecate some features like obscure variants
of the eval call used by malware scripts. So older malware might be rendered
invalid when executed by more recent interpreters.

Here is an example for a decoded malware file: [https://github.com/bdzwillo/php\_decode/blob/master/docs/example.md](https://github.com/bdzwillo/php_decode/blob/master/docs/example.md)

## php\_decode

The php\_decode tool included in the distribution, is a command line client
for the [PHP::Decode](https://metacpan.org/pod/PHP::Decode) module and allows to select most of the features
via command line options when run on a php script:

    Decode an obfuscated php script:
    > php_decode <php-file>

    Just Show the parsed output:
    > php_decode -p <php-file>

# METHODS

## new

    $php = PHP::Decode->new(%args);

The new contructor returns a PHP::Decode object.
Arguments are passed in key => value pairs.

The new constructor dies when arguments are invalid.

The accepted arguments are:

- inscript: set to indicate that paser starts inside of script
- filename: optional script filename (if not stdin or textstr)
- max\_strlen: max strlen for debug strings
- warn: optional handler to log warning messages
- log: optional handler to log info messages
- debug: optional handler to log debug messages
- max\_loop: optional max iterations for php loop execution (default: 10000)
- skip: optional transformer features to skip on execution
- $skip->{call}: skip function calls
- $skip->{loop}: skip loop execution
- $skip->{null}: dont' assume null for undefined vars
- $skip->{stdout}: don't include STDOUT
- with: optional transformer features to use for execution
- $with->{getenv}: eval getenv() for passed enviroment hash
- $with->{translate}: translate self-contained funcs to native code (experimental)
- $with->{optimize\_block\_vars}: remove intermediate block vars on toplevel
- $with->{invalidate\_tainted\_vars}: invalidate vars after tainted calls

## parse

Parse a php code string.

    $stmt = $php->parse($str);

The php code is tokenized and converted to an internal representation of php
statements. In most cases the result will be a tree starting with a block ('#blk')
which contains a list of the toplevel statements from the php script.

For more information about the statement types, see the [PHP::Decode::Parser](https://metacpan.org/pod/PHP::Decode::Parser) Module.

## exec

Execute a php statement.

    $stmt = $php->exec($stmt);

The exec method applies static transformations to the passed php statements,
and returns the resulting statements. Examples for transformations are:

\- calculation of expressions with constant values, arrays and strings.

\- execution of built-in php functions (see: [PHP::Decode::Func](https://metacpan.org/pod/PHP::Decode::Func) Module).

The accepted arguments are:

- stmt: the toplevel php statement to execute

## eval

Parse and Execute a php code string.

    $stmt = $php->eval($str);

The eval() method combines the parse() and exec() methods.

## format

Format a php statement to a php code string.

    $code = $php->format($stmt, $fmt);

The accepted arguments are:

- stmt: the toplevel php statement to format
- fmt: optional format flags
- $fmt->{indent}: output indented multiline code
- $fmt->{unified}: unified #str/#num output
- $fmt->{mask\_eval}: mask eval in strings with pattern
- $fmt->{escape\_ctrl}: escape control characters in output strings
- $fmt->{avoid\_semicolon}: avoid semicolons after braces
- $fmt->{max\_strlen}: max length for strings in output

# SEE ALSO

The git repository for PHP::Decode on cpan is [https://github.com/bdzwillo/php\_decode](https://github.com/bdzwillo/php_decode).

- PHP code parser [PHP::Decode::Parser](https://metacpan.org/pod/PHP::Decode::Parser)
- PHP ordered arrays [PHP::Decode::Array](https://metacpan.org/pod/PHP::Decode::Array)
- PHP code transformer [PHP::Decode::Transformer](https://metacpan.org/pod/PHP::Decode::Transformer)
- php\_decode client [php\_decode](https://metacpan.org/pod/php_decode)

Required by PHP::Decode::Array:
Ordered Hash [Tie::IxHash](https://metacpan.org/pod/Tie::IxHash)

Required by PHP::Decode::Transformer:

- Base64 encode/decode [MIME::Base64](https://metacpan.org/pod/MIME::Base64)
- Zlib compress/decompress [Compress::Zlib](https://metacpan.org/pod/Compress::Zlib)
- MD5 hash [Digest::MD5](https://metacpan.org/pod/Digest::MD5)
- SHA1 hash [Digest::SHA1](https://metacpan.org/pod/Digest::SHA1)
- HTML text encode/decode [HTML::Entities](https://metacpan.org/pod/HTML::Entities)
- URL encode/decode [URI::Escape](https://metacpan.org/pod/URI::Escape)

Since many built-in PHP functions relate directly to their perl
counterparts, perl is a good match for php emulation. (see for example
the PHP string functions: [https://php.net/manual/en/ref.strings.php](https://php.net/manual/en/ref.strings.php))

# AUTHORS

Barnim Dzwillo @ Strato AG

# COPYRIGHT AND LICENSE

Copyright (C) 2014-2023 by Barnim Dzwillo

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.
