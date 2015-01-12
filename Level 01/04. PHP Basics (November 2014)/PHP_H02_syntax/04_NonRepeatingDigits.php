<?php
//Write a PHP script NonRepeatingDigits.php that declares an integer variable N,
//and then finds all 3-digit numbers that are less or equal than N (<= N) and consist of unique digits.
//Print "no" if no such numbers exist. Examples:
//Input	Output
//1234    -> 102, 103, 104, 105, 106, 107, 108, 109, 120, 123, 124, 125, 126, 127, 128, 129, 130, 132, 134, 135, …, 980, 981, 982, 983, 984, 985, 986, 987
//145    -> 102, 103, 104, 105, 106, 107, 108, 109, 120, 123, 124, 125, 126, 127, 128, 129, 130, 132, 134, 135, 136, 137, 138, 139, 140, 142, 143, 145
//15	   -> no
//

    function pritnNonRepeat($input){
        $res = array();
        for ($i = 102; $i <=  min($input, 987); $i++) {
          //  for ($i = 102; $i <= $input&& $i <  987; $i++) {
            $numStr = strval($i);
            if (($numStr[0] != $numStr[1]) &&($numStr[0] != $numStr[2]) &&($numStr[1] !=$numStr[2])) {
                   echo $numStr[0] . $numStr[1] . $numStr[2] . ' ';
                   $res[]=$i;
                }
        }
        if  ($res) {
           echo implode(", ", $res) . "\n" ; }
        else { echo"no" . "\n";}
    }
    pritnNonRepeat(1234);
    pritnNonRepeat(145);
    pritnNonRepeat (15);
    pritnNonRepeat (247);
?>