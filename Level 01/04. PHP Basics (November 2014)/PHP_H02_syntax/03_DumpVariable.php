<!--Write a PHP script DumpVariable.php that declares a variable.
If the variable is numeric, print it by the built-in function var_dump().
If the variable is not numeric, print its type at the input. Examples:
"hello"  ->	string
15	     -> int(15)
1.234	  -> double(1.234)
array(1,2,3)    ->	array
(object)[2,34]	->  object -->

<?php
    function printVar($input)
    {
        // if (gettype($input)==="integer" || gettype($input)==="double" || gettype($input)=== 'float' ) {
        if(is_numeric($input)){
            echo var_dump($input);
          }
        else {echo gettype($input) . "\n"; }
    }

    printVar ("hello");
    printVar (15);
    printVar (1.234);
    printVar (array(1,2,3) );
    printVar ((object)[2,34] );

?>