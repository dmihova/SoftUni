<!DOCTYPE html>
<html>
<head>
    <title>Annual Exprenses</title>
    <link rel="stylesheet" href="styles.css"/>
</head>
<body>
<form action="AnnualExpenses.php" method="post">
    <label for="inputYears">Enter number of years</label>
    <input type="text" id="inputYears" name="input"/>
    <input type="submit" name="submit" value="Show costs"/>
</form>

<?php
function getMonth($num)
{
    return date("F", mktime(0, 0, 0, $num, 1, 2000));
}
if (isset($_POST['submit']) && !empty($_POST["input"])):
$yearsNum = $_POST['input'];
$currYear = date("Y");
?>

<table>
    <thead>
    <tr>
        <th>Year</th>
        <?php for ($i = 1; $i <= 12; $i++) : ?>
            <th><?php echo getMonth($i) ?></th>
        <?php endfor; ?>
        <th>Total:</th>
    </tr>
    <?php
    for ($i = $yearsNum; $i > 0; $i--):
        $sum = 0;
        ?>
        <tr>
            <td><?php
                echo $currYear;
                $currYear--;
                ?>
            </td>
            <?php for ($j = 0; $j < 12; $j++): ?>
                <td>
                    <?php
                    $num = rand(0, 999);
                    $sum += $num;
                    echo $num;
                    ?>
                </td>
            <?php endfor ?>
            <td><?php echo $sum ?></td>
        </tr>
    <?php
    endfor;
    endif;
    ?>
</body>
</html>