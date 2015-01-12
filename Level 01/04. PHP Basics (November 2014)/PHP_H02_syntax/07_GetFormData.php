<?php
require"07_GetFormData.html";
$name = $_POST['name'];
$age = $_POST['age'];
echo "<style>
input{display: block;width: 200px;margin: 3px;}
#radio1, #radio2{display: inline;width: 15px;}
</style>";

if(isset($_POST['sex']))
{
    $sex = $_POST['sex'];
    echo "<p>My name is $name. I am $age years old. I am $sex.</p>";
}
else{
    echo "please select sex!";
}
?>