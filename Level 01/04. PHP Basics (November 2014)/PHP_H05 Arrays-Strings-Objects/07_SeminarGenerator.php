<?php
date_default_timezone_set('Europe/Sofia');
if (isset($_POST['text'], $_POST['sort'], $_POST['order'])) {
    $text = $_POST['text'];
    $sort = $_POST['sort'];
    $order = $_POST['order'];

    $pattern = '/(.+?)-(.+?)-([\d\-\: ]+)(.+)/';
    preg_match_all($pattern, $text, $data);

    $seminars = array();
    for ($i = 0; $i < count($data[0]); $i++) {
        $seminars[] = array('seminarName' => $data[1][$i], 'lecturerName' => $data[2][$i],
            'dateTime' => strtotime($data[3][$i]), 'info' => $data[4][$i]);
    }
    // Obtain a list of columns
    foreach ($seminars as $key => $row) {
        $sortKey[$key]  = $row[$sort];
    }
    // Sort the data
    if ($order == 'ascending') {
        array_multisort($sortKey, SORT_ASC, $seminars);
    } else {
        array_multisort($sortKey, SORT_DESC, $seminars);
    }

    $seminars = (object)$seminars;
    //var_dump($seminars);
}
?>
<?php include( '07_SeminarGeneratorSeminar.php' ); ?>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>SoftUni Seminar Generator</title>
    <link rel="stylesheet" href="07_SeminarGenerator.css">
</head>
<body>
<main style="width:700px;margin:auto;">
    <form method="post">
        <textarea name="text"></textarea>
        <label for="orderBy">Sort by:</label>
        <select name="orderBy" id="orderBy">
            <option value="date">Date</option>
            <option value="date">Name</option>
        </select>
        <label for="order">Order:</label>
        <select name="order" id="order">
            <option value="ascending">Ascending</option>
            <option value="descending">Descending</option>
        </select>
        <input type="submit">
    </form>
    <?php if(isset( $seminars )): ?>
        <table id="main-table">
            <thead>
            <tr>
                <th>Seminar name</th>
                <th>Date</th>
                <th>Participate</th>
            </tr>
            </thead>
            <tbody>
            <?php foreach ($seminars as $seminar): ?>
                <tr>
                    <td>
                        <a href=""><?= htmlspecialchars( $seminar->name ) ?></a>
                        <div class="details-box">
                            <p>
                                <span class="details-info">Lecturer:</span>
                                <?= htmlspecialchars( $seminar->lecturer ); ?>
                            </p>
                            <p>
                                <span class="details-info">Details:</span>
                                <?= htmlspecialchars( $seminar->details ); ?>
                            </p>
                        </div>
                    </td>
                    <td><?= htmlspecialchars( $seminar->date ) ?></td>
                    <td>
                        <button type="button">Sign Up</button>
                    </td>
                </tr>
            <?php endforeach; ?>
            </tbody>
        </table>
    <?php endif; ?>
</main>
<script src="07_SeminarGenerator.js"></script>
</body>
</html>