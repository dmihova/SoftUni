<!DOCTYPE html>
<html>
<head>
    <title>Primes in Range</title>
    <style>
        form{ margin: 0 auto; margin-top: 2%;width: 550px;}
        input{margin-right: 30px;}
        label{margin-right: 6px;}
        input[type='submit']{display: block; margin: 0 auto; margin-top: 15px; }
        #contentBox{width: 90%;margin: 0 auto; margin-top: 2%;text-align: left;font-size: 16px;line-height: 21px; }
        p{ display: inline-block; padding: 0 4px; margin-right: 2px;}
        .prime{ background-color: #585858;  color: white;}
    </style>
</head>
<body>
<form action="" method="post">
    <label for="inputYears">Starting index</label>
    <input type="text" id="inputYears" name="start"/>
    <label for="inputYears">End</label>
    <input type="text" id="inputYears" name="end"/>
    <input type="submit" name="submit" value="Show costs"/>
</form>

<?php
function isPrime($num){
    if ($num <= 3) {
        return $num > 1;
    } else if ($num % 2 == 0 || $num % 3 == 0) {
        return false;
    } else {
        for ($i = 5; $i * $i <= $num; $i += 6) {
            if ($num % $i == 0 || $num % ($i + 2) == 0) {
                return false;
            }
        }
        return true;
    }
}
if (isset($_POST['submit']) && !empty($_POST["start"]) && !empty($_POST["end"])){
$startNum = $_POST['start'];
$endNum = $_POST['end'];
?>
<div id="contentBox">
    <?php for ($i = $startNum; $i <= $endNum; $i++) {
        if (isPrime($i)){
            echo '<p class="prime">' . $i . '</p>';
        } else{
            echo '<p>' . $i . '</p>';
        }
    }
    }
    ?>
</div>
</body>
</html>