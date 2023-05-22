# NAME

PHP::Decode::Array - php ordered arrays

# SYNOPSIS

    # Create an array

    my $a = PHP::Decode::Array->new();

    $a->set(undef, 'a');
    $a->set(undef, 'b');
    $a->set('x', 'c');
    $a->set('y', PHP::Decode::Array->new());

    # Copy array recursively

    my $a2 = $a->copy();

    # Convert to string

    printf "$a->{name} = %s\n", $a->to_str();

# DESCRIPTION

The PHP::Decode::Array Module implements php compatible arrays

To track the order of insertions of key-value pairs, the internal represention
uses an ordered hashmap.

As long as a php array is used as a classic array, where only values without
a key are appended, the internal representation uses a simple hashmap.

The performance of the ordered hashmap is 3 times slower than the simple map.

As soon as the array switches to an ordered hashmap, the $array->{ordered}
flag will be set.

# METHODS

## new

    my $array = PHP::Decode::Array->new();

Create a new php array.
The $array->{name} field is generated as increasing '#arr<N>' value.

The PHP::Decode::Array module is designed to work together with PHP::Decode::Parser.
If the $PHP::Decode::Array::class\_strmap is initialized with a perl hashmap, than
this hashmap is used to track array-names and array-key names other than
numeric values.

    my %strmap;
    $PHP::Decode::Array::class_strmap = \%strmap;

If no class\_strmap is set and no 'strmap' option is passed as argument,
then the PHP::Decode::Array module will store the array values directly.

## set

    $array->set(undef, $value);
    $array->set($key, $value);

Set Array entry to value.
If key is omitted, then use max integer key or 0 as next key.

## get

    my $value = $array->get($key);

Get Array entry.

## delete

    my $value = $array->delete($key);

Delete Array entry and return deleted value.

## copy

    $array2 = $array->copy();
    $array2 = $array->copy(\@keys);

Copy array recursively.
Optionally pass a list of toplevel keys to copy (default is all keys).

## get\_keys / val

    $keys = $array->get_keys();
    foreach my $key (@$keys) {
          my $val = $array->val($key);
    }

Get list of array keys in insertion order. The val() function returns
the entry stored for a key. The val() function is meant to work on the
list returned by get\_keys() - other than get() it does not check for
the validity of the passed index.

## empty

    $is_empty = $array->empty();

Check if array is empty.

## get\_pos

    $pos = $array->get_pos();

Get internal array pointer.

## set\_pos

    $array->set_pos($pos);

Set internal array pointer.

## to\_str

    printf "$array->{name} = %s\n", $array->to_str();

Dump array contents recursively.

# Dependencies

Requires the Tie::IxHash Module.

# AUTHORS

Barnim Dzwillo @ Strato AG
