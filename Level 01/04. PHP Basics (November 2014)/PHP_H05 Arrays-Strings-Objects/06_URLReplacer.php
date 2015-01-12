<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>url replacer</title>
</head>
<body>
<form action="" method="post">
    <label for="inputText">Text:</label>
    <textarea name="inputText" id="inputText"></textarea>

    <input type="submit" name="submit" value="Transform"/>
</form>

<?php
if (isset($_POST['submit']) && !empty($_POST['inputText'])) {
    $text = $_POST['inputText'];
    $replaceable = ["/<\s*a\s+href\s*=\s*\"/", "/<\s*\/a\s*>/", "/\"+\s*>/"];
    $replacements = ["[URL=", "[/URL]", "]"];
    $text = preg_replace($replaceable, $replacements, $text);
    echo "<p>" . htmlspecialchars($text) . "</p>";
}
?>

</body>
</html>