<!DOCTYPE html>
<html>
<head>
    <title>Word Mapping</title>
</head>
<body>
<form action="" method="post">
    <textarea name="input"></textarea>
    <input type="submit" name="submit" value="Count words"/>
</form>

<?php
if (isset($_POST['submit']) && !empty($_POST['input'])):
    $text = strtolower($_POST['input']);
    $words = [];
    $pattern = "/\W/";
    $text = preg_split($pattern, $text, -1, PREG_SPLIT_NO_EMPTY);
    for ($i = 0; $i < count($text); $i++) {
        $currWord = $text[$i];
        if (isset($words[$currWord])) {
            $words[$currWord]++;
        } else {
            $words[$currWord] = 1;
        }
    }
    ?>
    <table>
        <tbody>
        <?php foreach ($words as $word => $occurs): ?>
            <tr>
                <td><?php echo htmlspecialchars($word) ?></td>
                <td><?php echo htmlspecialchars($occurs) ?></td>
            </tr>
        <?php endforeach ?>
        </tbody>
    </table>

<?php endif ?>
</body>
</html>