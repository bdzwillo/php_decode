# NAME

PHP::Decode::Parser

# SYNOPSIS

    # Create an instance

    sub warn_msg {
          my ($action, $fmt) = (shift, shift);
          my $msg = sprintf $fmt, @_;
          print 'WARN: ', $action, ': ', $msg, "\n";
    }
    my %strmap;
    my $parser = PHP::Decode::Parser->new(strmap => \%strmap, filename => 'test', warn => \&warn_msg);

    # Parse php token list

    my $line = '<?php echo "test"; ?>';
    my $quote = $parser->tokenize_line($line);
    my $tokens = $parser->tokens();
    my $stmt = $parser->read_code($tokens);

    # Expand to code again

    my $code = $parser->format_stmt($stmt, {format => 1});
    print $code;

# DESCRIPTION

The PHP::Decode::Parser Module tokenizes and parses php code strings. The parser
does not depend on a special php version. It supports most php syntax of
interpreters from php5 to php8.

The parser assumes that the input file is a valid php script, and does
not enforce strict syntactic checks. Unrecognized tokens are simply passed
through.

The parser converts the php code into a unified form when the resulting
output is formatted (for example intermittent php-script-tags and variables
from string interpolation are removed and rewritten to php echo statements).

# METHODS

## new

    $parser = PHP::Decode::Parser->new(%args);

Create a PHP::Decode::Parser object. Arguments are passed in key => value pairs.

The only required argument is \`strmap\`.

The new constructor dies when arguments are invalid, or if required
arguments are missing.

The accepted arguments are:

- strmap: hashmap for parsed php statements
- inscript: set to indicate that paser starts inside of script
- filename: optional script filename (if not stdin or textstr)
- max\_strlen: max strlen for debug strings
- warn: optional handler to log warning messages
- log: optional handler to log info messages
- debug: optional handler to log debug messages

## tokenize\_line

Tokenize a php code string

    quote = $parser->tokenize_line($line);

See the description of the [PHP::Decode::Tokenizer](https://metacpan.org/pod/PHP::Decode::Tokenizer) module for the token types.

## read\_code

Parse a token list

    <tok> php token list

      $stmt = $parser->read_code($tokens);

The read\_code method converts the token list to an internal representation
of php statements. If a script contains more than one top level statement,
the method returns block with a list of these statements.

The following types are used to represent php statements:

- #null: null value
- #num: unquoted integer or float
- #str: quoted string
- #const: unquoted symbol
- $var: variable
- #arr: ordered array (see: [PHP::Decode::Array](https://metacpan.org/pod/PHP::Decode::Array))
- #blk: block of statements
- #fun: function definition
- #call: function call
- #elem: indexed elem access
- #expr: unary or binary expression
- #ns: namespace prefix
- #class: class definition
- #scope: class property dereference
- #inst: class instance
- #obj: obj property dereference
- #ref: reference to variable
- #trait: class trait
- #fh: file handle (limited to \_\_FILE\_\_)
- #stmt: remaining php statements (like if, while, echo, global, ..)

Each of of these statements is uniquely numbered and stored in the
strmap of the parser.

## format\_stmt

Format a php statement to a php code string.

    $code = $parser->format_stmt($stmt, $fmt);

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

Requires the [PHP::Decode::Tokenizer](https://metacpan.org/pod/PHP::Decode::Tokenizer) Module.

# AUTHORS

Barnim Dzwillo @ Strato AG
