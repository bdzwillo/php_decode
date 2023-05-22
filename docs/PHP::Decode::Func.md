# NAME

PHP::Decode::Func

# SYNOPSIS

    # Creating an instance

    my %strmap;
    my $parser = PHP::Decode::Parser->new(strmap => \%strmap);
    my $ctx = PHP::Decode::Transformer->new(parser => $parser);

    # Exec func

    my $str = $parser->setstr('test');
    my $res = PHP::Decode::Func::exec_cmd($ctx, 'strlen', [$str]);

    if (defined $res) {
        my $code = $parser->format_stmt($res);
        print $code;
    }

# DESCRIPTION

The PHP::Decode::Func Module contains implementations of php builtin-functions
without external side-effects.

# METHODS

## exec\_cmd

Execute a php built-in function.

    $res = PHP::Decode::Func::exec_cmd($ctx, $cmd, $args);

## Dependencies

Requires the PHP::Decode::Parser, PHP::Decode::Transformer and PHP::Decode::Array Modules.

Some other Modules are required to implement the php functions:
List::Util, Compress::Zlib, Digest::MD5, Digest::SHA1, HTML::Entities, URI::Escape, File::Basename.

# AUTHORS

Barnim Dzwillo @ Strato AG
