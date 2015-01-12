<!--Problem 5. Lazy Sundays
Write a PHP script LazySundays.php which prints the dates of all Sundays in the current month. -->
<?php
    $year = date("Y");
    $month = date("F");
    $monthDays = date("t");
    $firstSunday = date("j", strtotime("Sunday"));

    for($day= 1; $day <= $monthDays; $day++) {
       $date = strtotime("$day $month $year");
       if(date("l", $date) == "Sunday") {
           echo date("jS F, Y", $date) . "\n";
       }
    }

?>