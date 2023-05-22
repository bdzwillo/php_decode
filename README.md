php_decode
==========
The php_decode tool parses php code files and tries to apply all
possible static transformations for php variables and values defined
in the script. The decoded file is formatted and printed to stdout.
It includes a '$STDOUT' variable for any script output from echo or
print statements.

The decoder uses a custom php parser which does not depend on a special php
version. It supports most php syntax of interpreters from php5 to php8.
This is a pure perl implementation and requires no external php interpreter.

The tool was mainly written for for php malware analysis. It does
not implement php functions with any kind of side-effect.
```
To decode an obfuscated php script:
> php_decode <php-file>

To show warnings regarding partial execution:
> php_decode -w <php-file>
```
The parser assumes that the input file is a valid php script, and does
not enforce strict syntactic checks. Unrecognized tokens are simply passed
through.

The parser converts the php code into a unified form when the resulting
output is formatted (for example intermittent php-script-tags and variables
from string interpolation are removed and rewritten to php echo statements).

To show just the parsed output run:
```
> php_decode -p <php-file>
```
The transformer supports many of the pure php built-in functions, but not all
function parameters are supported. Function calls with unresolved parameters
are skipped and kept unmodified in the transformer output. In most cases the
resulting php code will be valid and produce the same results as the original
script.

Here is an example for a decoded malware file: [Decode example](docs/example.md)

PHP::Decode
-----------
The php_decode tool uses the PHP::Decode module, which is also available from
cpan at https://metacpan.org/pod/PHP::Decode. Here are links to the generated
perldoc files from the local repository:

- PHP decoder [PHP::Decode](docs/PHP::Decode.md)
- PHP code tokenizer [PHP::Decode::Tokenizer](docs/PHP::Decode::Tokenizer.md)
- PHP code parser [PHP::Decode::Parser](docs/PHP::Decode::Parser.md)
- PHP ordered arrays [PHP::Decode::Array](docs/PHP::Decode::Array.md)
- PHP operators [PHP::Decode::Op](docs/PHP::Decode::Op.md)
- PHP code transformer [PHP::Decode::Transformer](docs/PHP::Decode::Transformer.md)
- PHP built-in functions [PHP::Decode::Func](docs/PHP::Decode::Func.md)
