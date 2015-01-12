<!--Write a PHP script InformationTable.php which generates an HTML table by given information
// about a person (name, phone number, age, address). Styling the table is optional.
// Semantic HTML is required.-->
<!DOCTYPE html>
<html>
<head>
    <title>Table</title>
    <style type="text/css">
    table {border-collapse: collapse;}
    table tr td { border: 1px solid black; padding: 5px; }
    td:first-child { background-color: orange; font-weight: bold; width: 110px; }
    td:last-child {text-align: right; width: 100px; }
    </style>
</head>
<body>
<?php display_table("Gosho", "0882-321-423",24,"Hadji Dimitar") ?> <br/>
<?php display_table("Pesho", "0884-888-888",67, "Suhata Reka") ?>
</body>
</html>

<?php
      function display_table( $name,$phone,$age, $address)
    {
        echo "<table><tbody>";
        add_row("Name", $name);
        add_row("Phone number", $phone );
        add_row("Age", $age );
        add_row("Address", $address );
        echo "</tbody></table>";
    }
    function add_row($key, $value)
    {
        echo "<tr><td>" . $key . "</td><td>" . $value . "</td></tr>";
    }
?>