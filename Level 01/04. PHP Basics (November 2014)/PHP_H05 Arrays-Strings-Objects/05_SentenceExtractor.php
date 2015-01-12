<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>Sentence Extractor</title>
    <link rel="stylesheet" href="styles.css"/>
</head>
<body>
<form action="" method="post">
    <label for="inputText">Text:</label>
    <textarea name="inputText" id="inputText"></textarea>

    <label for="wantedWord">Word:</label>
    <textarea name="wantedWord" id="wantedWord"></textarea>

    <input type="submit" name="submit" value="Submit"/>
</form>

<?php
if (isset($_POST['submit']) && !empty($_POST['inputText']) && !empty($_POST['wantedWord'])) {
    $text = $_POST['inputText'];
    preg_match_all('/([A-Z].[^.!?]+)[.?!]/', $text, $sentence);
    $word = $_POST['wantedWord'];
    for ($i = 0; $i < count($sentence[0]); $i++) {
        $currSentence = $sentence[0][$i];
        if (preg_match('/\b.' . $word . '.\b/i', $currSentence)) {
            echo "<p>" . htmlspecialchars($currSentence) . "</p>";
        }
    }
}
?>

</body>
</html>