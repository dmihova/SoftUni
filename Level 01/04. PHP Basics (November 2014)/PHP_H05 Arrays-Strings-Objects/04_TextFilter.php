<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>Text Filter</title>
    <link rel="stylesheet" href="styles.css"/>
</head>
<body>
<form action="" method="post">
    <label for="inputText">Text:</label>
    <textarea name="inputText" id="inputText"></textarea>

    <label for="banList">Banlist:</label>
    <textarea name="banList" id="banList"></textarea>

    <input type="submit" name="submit" value="Submit"/>
</form>

<?php
if (isset($_POST['submit']) && !empty($_POST['inputText']) && !empty($_POST['banList'])){
    $text = $_POST['inputText'];
    $banList = $_POST['banList'];
    $pattern = "/[, ]+/";
    $banList = preg_split($pattern, $banList, -1, PREG_SPLIT_NO_EMPTY);
    for ($i = 0; $i < count($banList); $i++) {
        $currBanWord = $banList[$i];
        $stars = str_pad('*', strlen($currBanWord), '*');
        $text = preg_replace('/' . $currBanWord . '/', $stars, $text);
    }
    echo "<p>" . htmlspecialchars($text) .  "</p>";
}
?>