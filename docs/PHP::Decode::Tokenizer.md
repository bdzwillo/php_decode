# NAME

PHP::Decode::Tokenizer

# SYNOPSIS

    # Create an instance

    package SymTokenizer;
    use base 'PHP::Decode::Tokenizer';

    my @tok;

    sub new {
          my ($class, %args) = @_;
          return $class->SUPER::new(%args);
    }

    sub add {
          my ($tab, $sym) = @_;
          push(@tok, $sym);
    }

    package main;

    my $parser = SymTokenizer->new();

    # Tokenize functions

    my $line = '<?php echo "test"; ?>';
    my $quote = $parser->tokenize_line($line);

    printf "tokens: %s\n", join(' ', @$tok);

# DESCRIPTION

The PHP::Decode::Tokenizer module is the tokenizer base class for a php parser.

# METHODS

## new

Create a PHP::Decode::Tokenizer object. Arguments are passed in key => value pairs.

    $parser = PHP::Decode::Tokenizer->new(%args)

The tokenizer class is designed to be used as base class for a parser which
overrides at least the basic add() method.

The accepted arguments are:

- inscript: set to indicate that paser starts inside of script
- warn: optional handler to log warning messages

## tokenize\_line

Tokenize a php code string.

    my $quote = $parser->tokenize_line($line, $quote);

- quote: optional opening quote if line starts in quoted mode.

The tokenize\_line method can be called once for a complete php code string,
or incremental for consecutive parts of a script. Internally the tokenizer
keeps the 'inscript' and 'quote' state between subsequent calls. The initial
'inscript state can be set when 'new' is called. If the tokenizer should
start in quoted mode, an optional opening 'quote' can be passed to the call.

The tokenize\_line method returns undef if not in quoted mode after the input
was processed, or the type of 'quote' to indicate quoted mode.

The tokenizer will call the add() methods of the parser sub-class for each
token. If one of the following add-methods is not overridden, the tokenizer
will call $self->add($sym) as a default:

- add\_open: opening bracket
- add\_close: closing bracket
- add\_white: white space
- add\_comment: php comment
- add\_sym: php symbol like function name or const
- add\_var: php variable name (without leading '$')
- add\_str: php quoted string (without quotes)
- add\_num: php unquoted int number or float
- add\_script\_start: script start tag
- add\_script\_end: script end tag
- add\_noscript: text outside of script tags
- add\_bad\_open: bad start script tag

# AUTHORS

Barnim Dzwillo @ Strato AG
