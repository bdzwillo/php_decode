# NAME

PHP::Decode::Op

# SYNOPSIS

    # PHP operations on parsed objects

    my $val1 = $parser->setnum('2');
    my $val2 = $parser->setnum('3');
    my $res = PHP::Decode::Op::binary($parser, $val1, '+', $val2);

    $res = PHP::Decode::Op::unary($parser, '-', $parser->set_num($res));

    my $arr1 = $parser->newarr();
    my $arr2 = $parser->newarr();
    $arr1->set(undef, $val1);
    $arr2->set(undef, $val2);
    $res = PHP::Decode::Op::array_compare($parser, $arr1->{name}, $arr2->{name});

    $res = PHP::Decode::Op::array_is_const($parser, $arr1->{name});

    my $num = PHP::Decode::Op::to_num('-6');

# DESCRIPTION

The PHP::Decode::Op Module implements php operators on PHP::Decode::Parser objects

# METHODS

## binary

    $res = PHP::Decode::Op::binary($parser, $val1, $op, $val2);

Exec binary Operator.

## unary

    $res = PHP::Decode::Op::unary($parser, $op, $val);

Exec unary Operator.

## array\_compare

    $res = PHP::Decode::Op::array_compare($parser, $array1, $array2, $check_types);

Compare two arrays.

# SEE ALSO

Requires the [PHP::Decode::Parser](https://metacpan.org/pod/PHP::Decode::Parser) & [PHP::Decode::Array](https://metacpan.org/pod/PHP::Decode::Array) Module.

# AUTHORS

Barnim Dzwillo @ Strato AG
