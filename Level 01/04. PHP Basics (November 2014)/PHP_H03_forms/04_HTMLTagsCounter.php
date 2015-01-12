<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8" />
    <title>Print tags</title>
    <link rel="stylesheet" href="04_HTMLTagsCounter.css"/>
</head>
<body>
<form method="get" action="">
    <label for="text">Enter HTML Tags:</label>
    <input type="text" name="text" />
    <input type="submit" value="Submit"/>
</form>
</body>
</html>


<?php
session_start();
$tags = ['a', 'abbr', 'address', 'area', 'article', 'aside', 'audio', 'b', 'base', 'bdi', 'bdo',
    'blockquote', 'body', 'br', 'button', 'canvas', 'caption', 'cite', 'code', 'col', 'colgroup',
    'data', 'datalist', 'dd', 'del', 'details', 'dfn', 'dialog', 'div', 'dl', 'dt', 'em', 'embed',
    'fieldset', 'figcaption', 'figure', 'footer', 'form', 'h1', 'h2', 'h3', 'h4', 'h5', 'h6',
    'head', 'header', 'hgroup', 'hr', 'html', 'i', 'igrame', 'img', 'input', 'ins', 'kbd', 'keygen',
    'label', 'legend', 'li', 'link', 'main', 'map', 'mark', 'menu', 'menuitem', 'meta', 'meter',
    'nav', 'noscript', 'object', 'ol', 'optgroup', 'option', 'output', 'p', 'param', 'pre', 'small',
    'progress', 'q', 'rb', 'rp', 'rt', 'rtc', 'ruby', 's', 'samp', 'script', 'section', 'select',
    'source', 'span', 'strong', 'style', 'sub', 'summary', 'sup', 'table', 'tbody', 'td', 'template',
    'tfoot', 'th', 'thead', 'time', 'title', 'tr', 'track', 'u', 'ul', 'var', 'video', 'wbr'];
if (isset($_GET['text'])){
    if (!isset($_SESSION['count'])){
        $_SESSION['count'] = 0;
    }
    $score = 0;
    if ((in_array($_GET['text'], $tags))){
        $_SESSION['count']++;
        $score = $_SESSION['count'];
        echo "<p> Valid HTML tag! <br> Score: $score</p>";
    } else{
        $score = $_SESSION['count'];
        echo "<p> Invalid HTML tag! <br> Score: $score</p>";
    }
}
?>