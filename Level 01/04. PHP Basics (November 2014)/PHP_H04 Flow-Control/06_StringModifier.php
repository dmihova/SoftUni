<!DOCTYPE html>
<html>
<head>
    <title>Sum of Digits</title>
</head>
<body>
<form action="" method="post">
    <label for="input">Input string</label>
    <input type="text" id="input" name="input"/><br/>

    <input type="radio" name="radioType" id="palindrome" value="palindrome"/>
    <label for="palindrome">Check Palindrome</label><br/>

    <input type="radio" name="radioType" id="reverseStr" value="reverse"/>
    <label for="reverseStr">Reverse String</label><br/>

    <input type="radio" name="radioType" id="split" value="split"/>
    <label for="split">Split</label><br/>

    <input type="radio" name="radioType" id="hashStr" value="hash"/>
    <label for="hashStr">Hash String</label><br/>

    <input type="radio" name="radioType" id="shuffleStr" value="shuffle"/>
    <label for="shuffleStr">Shuffle String</label><br/>

    <input type="submit" name="submit" value="Submit"/>
</form>

<section>
    <?php
    if (isset($_POST['submit']) && !empty($_POST["input"]) && isset($_POST["radioType"])){
        $typeRequest = $_POST['radioType'];
        $word = $_POST["input"];
        switch($typeRequest){
            case 'palindrome':
                $reversedWord = strrev($word);
                if ($reversedWord == $word){
                    echo "<p>$word is a palindrome!</p>";
                }else{
                    echo "<p>$word is not a palindrome!</p>";
                }
                break;
            case 'reverse':
                $reversedWord = strrev($word);
                echo "<p>$reversedWord</p>";
                break;
            case 'split':
                $arrSplit = str_split($word);
                echo "<p>";
                foreach ($arrSplit as $letter) {
                    echo $letter . ' ';
                }
                echo "</p>";
                break;
            case 'hash':
                $hashed = crypt($word, 'hardPass');
                echo "<p>$hashed</p>";
                break;
            case 'shuffle':
                $shuffled = str_shuffle($word);
                echo "<p>$shuffled</p>";
                break;
        }
    }
    ?>
</section>
</body>
</html>