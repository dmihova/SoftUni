<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8" />
    <title>Print tags</title>
</head>
<body>
<p>Enter Tags:</p>
<form method="get" action="01_PrintTags.php">
    <input type="text" name="input" />
    <input type="submit" />
</form>
</body>
</html>

<?php
if (isset($_GET['input'])) {
    $wordsArr = explode(', ', $_GET['input']);
    foreach ($wordsArr as $key => $word) {
        echo "$key: $word <br>";
    }
}
?>