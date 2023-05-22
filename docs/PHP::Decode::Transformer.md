# NAME

PHP::Decode::Transformer

# SYNOPSIS

    # Create an instance

    sub warn_cb {
          my ($ctx, $action, $stmt, $fmt) = (shift, shift, shift, shift);

          my $msg = sprintf $fmt, @_;
          print "WARN: [$ctx->{infunction}] $action $stmt", $msg, "\n";
    }
    my %strmap;
    my $parser = PHP::Decode::Parser->new(strmap => \%strmap);
    my $ctx = PHP::Decode::Transformer->new(parser => $parser, warn => \&warn_cb);

    # Parse and transform php code

    my $str = $parser->setstr('<?php echo "test"; ?>');
    my $blk = $ctx->parse_eval($str);
    my $stmt = $ctx->exec_eval($blk);

    # Expand to code again

    my $code = $parser->format_stmt($stmt);
    print $code;

    # Output: echo 'test' ; $STDOUT = 'test' ;

# DESCRIPTION

The PHP::Decode::Transformer Module applies static transformations to PHP statements
parsed by the PHP::Decode::Parser module.

# METHODS

## new

    $ctx = PHP::Decode::Transformer->new(parser => $parser);

Create a PHP::Decode::Transformer object. Arguments are passed in key => value pairs.

The only required argument is \`parser\`.

The new constructor dies when arguments are invalid, or if required
arguments are missing.

The accepted arguments are:

- warn: optional handler to log transformer warning messages
- log: optional handler to log transformer info messages
- debug: optional handler to log transformer debug messages
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

## parse\_eval

Parse a php code string.

    $stmt = $ctx->parse_eval($str);

The php code string is tokenized and converted to an internal representation
of php statements. If a script contains more than one top level statement,
the method returns block with a list of these statements.

For more information about the statement types, see the [PHP::Decode::Parser](https://metacpan.org/pod/PHP::Decode::Parser) Module.

## exec\_eval

Execute a php statement.

    $stmt = $ctx->exec_eval($stmt);

The exec method applies static transformations to the passed php statements,
and returns the resulting statements.

## subctx

Create sub-class of transformer referencing the global and local varmaps from parent.

    $ctx2 = $ctx->subctx(%args);

## exec\_statement

Execute a php statement and return the result or simplified statement if transformed.

    $stmt2 = $ctx->exec_statement($stmt, $in_block);

## resolve\_variable

Resolve an indexed variable to its basevar and index

    ($var, $has_idx, $idx) = $ctx->resolve_variable($stmt, $in_block);

    - var: resolved variable name (a.e: array name)
    - has_idx: is array dereference
    - idx: if is array: indexvalue of last index or undef if index is empty

## getvar

Get value of a variable

    $val = $ctx->getvar($var, $quiet);

## setvar

Set value of a variable

    $ctx->setvar($var, $val, $in_block);

## registerfun

Register a '#fun' definition as callable function

    $ctx->registerfun($name, $fun);

## getfun

Lookup a user defined function by name

    $fun = $ctx->getfun($name);

## registerclass

Register a '#class' definition as instantiatable class

    $ctx->registerclass($name, $class);

## getclass

Lookup a class by name

    $class = $ctx->getclass($name);

# SEE ALSO

Requires the [PHP::Decode::Parser](https://metacpan.org/pod/PHP::Decode::Parser), [PHP::Decode::Array](https://metacpan.org/pod/PHP::Decode::Array) and [PHP::Decode::Func](https://metacpan.org/pod/PHP::Decode::Func) Modules.

# AUTHORS

Barnim Dzwillo @ Strato AG
