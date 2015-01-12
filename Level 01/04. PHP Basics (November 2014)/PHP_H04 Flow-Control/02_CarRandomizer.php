<!DOCTYPE html>
<html>
<head>
    <title>Rich People’s Problems</title>
    <style>
        table  {  margin: 0 auto;        }
        table * { border: 1px solid black;        }
        form {   text-align: center;  }
        p {    background-color: red; color: white; font-weight: bold;            font-size: 18px;            width: 400px;            margin: 0 auto;
            margin-top: 1%;  text-align: center;  border: 2px solid black;            border-radius: 10px;      }
    </style>
</head>
<body>
<form action="" method="post">
    <label for="inputCars">Enter cars</label>
    <input type="text" id="inputCars" name="input"/>
    <input type="submit" name="submit" value="Show cars"/>
</form>
<?php
if (isset($_POST['submit'])&& !empty($_POST["input"])):
    $arrCars = explode(", ", $_POST['input']);
    $colors = ["black", "white", "orange", "red", "green", "blue", "silver", "yellow", "pink"];?>

    <table>
        <thead>
        <tr>
            <th>Car</th>
            <th>Color</th>
            <th>Count</th>
        </tr>
        </thead>
        <tbody>
        <?php for ($i = 0; $i < count($arrCars); $i++) :?>
            <tr>
                <td><?php echo $arrCars[$i]?></td>
                <td><?php echo $colors[array_rand($colors)] ?></td>
                <td><?php echo rand(1, 5)?></td>
            </tr>
        <?php endfor?>
        </tbody>
    </table>
<?php endif?>

</body>
</html>