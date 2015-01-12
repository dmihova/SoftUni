<!--Write a PHP script SumTwoNumbers.php that decleares two variables,
firstNumber and secondNumber. They should hold integer or floating-point numbers (hard-coded values).
Print their sum in the output in the format shown in the examples below.
The numbers should be rounded to the second number after the decimal point.
Find in Internet how to round a given number in PHP.
Output
2 + 5   =7.00
1.567808 + 0.356  = 1.92
1234.5678+333 = 1567.57
-->

<?php
    function printSum($firstNumber, $secondNumber)
    {

        $sumNumber =$firstNumber + $secondNumber;
        $commonMsg = '$firstNumber + $secondNumber = ' . "$firstNumber + $secondNumber" . " = ";
        echo $commonMsg . number_format($sumNumber, 2, '.', '') . "<br/>";
        // printf('$firstNumber + $secondNumber = %.2f + %.2f = %.2f' . "<br>", $firstNumber, $secondNumber, $sumNumber);
       //  echo sprintf($commonMsg . "%1\$.2f <br>", $sumNumber);

        }

    printSum(2,5);
    printSum(1.567808, 0.356);
    printSum(1234.5678, 333);
 ?>
