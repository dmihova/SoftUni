<?php
function validate()
{
    if (preg_match('/[^A-Za-z]/', $_POST['fName'])) {
        die ('First name must contains only letters!');
    };
    if (strlen($_POST['fName']) < 2 || strlen($_POST['fName']) > 20) {
        die ('First name must be between 2 and 20 symbols!');
    }
    if (preg_match('/[^A-Za-z]/', $_POST['lName'])) {
        die ('Last name must contains only letters!');
    };
    if (strlen($_POST['lName']) < 2 || strlen($_POST['lName']) > 20) {
        die ('Last name must be between 2 and 20 symbols!');
    }
    for ($l = 0; $l < count( $_POST['languages'][0]); $l++) {
        if (!preg_match('/[A-Za-z]+/', $_POST['languages'][$l])) {
            die ('Language must contains only letters!');
        };
        if (mb_strlen($_POST['languages'][$l]) < 2 || mb_strlen($_POST['languages'][$l]) > 20) {
            die ('Language must be between 2 and 20 symbols!');
        }
    }
    if (!preg_match('/[A-Za-z0-9]+/', $_POST['company'])) {
        die ('Company must contains only letters and numbers!');
    }
    if (strlen($_POST['company']) < 2 || strlen($_POST['company']) > 20) {
        die ('Company must be between 2 and 20 symbols!');
    }
    if (!preg_match('/^[a-zA-z\d]+@[a-zA-Z\d]+.[a-zA-z]+$/', $_POST['email'])){
        die ('Invalid email!');
    }
    if (preg_match('/[^0-9-\+ ]+/', $_POST['phone'])){
        die ('Invalid phone number!');
    }
    return true;
}
if (isset($_POST['fName'], $_POST['lName'], $_POST['email'], $_POST['phone'], $_POST['gender'], $_POST['birth'],
    $_POST['nationality'], $_POST['company'], $_POST['from'], $_POST['to'], $_POST['proLanguages'], $_POST['langLevel'],
    $_POST['languages'], $_POST['comprehension'], $_POST['reading'], $_POST['writing'], $_POST['license'])):
$fName = $_POST['fName'];
$lName = $_POST['lName'];
$email = $_POST['email'];
$phone = $_POST['phone'];
$gender = $_POST['gender'];
$birthDate = $_POST['birth'];
$nationality = $_POST['nationality'];
$company = $_POST['company'];
$fromDate = $_POST['from'];
$toDate = $_POST['to'];
$proLanguages = $_POST['proLanguages'];
$langLevel = $_POST['langLevel'];
$languages = $_POST['languages'];
$comprehension = $_POST['comprehension'];
$reading = $_POST['reading'];
$writing = $_POST['writing'];
$driverLicenses = $_POST['license'];
if (validate()):
?>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8"/>
    <title>Print tags</title>
    <link rel="stylesheet" href="styles.css"/>
</head>
<body>
<header>
    <h1>CV</h1>
</header>
<table>
    <thead>
    <tr>
        <th colspan="2">Personal Information</th>
    </tr>
    </thead>
    <tbody>
    <tr>
        <td>First Name</td>
        <td><?php echo htmlentities($fName) ?></td>
    </tr>
    <tr>
        <td>Last Name</td>
        <td><?php echo htmlentities($lName) ?></td>
    </tr>
    <tr>
        <td>Email</td>
        <td><?php echo htmlentities($email) ?></td>
    </tr>
    <tr>
        <td>Phone Number</td>
        <td><?php echo htmlentities($phone) ?></td>
    </tr>
    <tr>
        <td>Gender</td>
        <td><?php echo htmlentities($gender) ?></td>
    </tr>
    <tr>
        <td>Birth Date</td>
        <td><?php echo htmlentities($birthDate) ?></td>
    </tr>
    <tr>
        <td>Nationality</td>
        <td><?php echo htmlentities($nationality) ?></td>
    </tr>
    </tbody>
</table>

<table>
    <thead>
    <tr>
        <th colspan="2">Last Work Position</th>
    </tr>
    </thead>
    <tbody>
    <tr>
        <td>Company Name</td>
        <td><?php echo htmlentities($company) ?></td>
    </tr>
    <tr>
        <td>From</td>
        <td><?php echo htmlentities($fromDate) ?></td>
    </tr>
    <tr>
        <td>To</td>
        <td><?php echo htmlentities($toDate) ?></td>
    </tr>
    </tbody>
</table>

<table>
    <thead>
    <tr>
        <th colspan="2">Computer Skills</th>
    </tr>
    </thead>
    <tbody>

    <tr>
        <td>Programming Languages</td>
        <td>
            <table class="innerTable">
                <thead>
                <tr>
                    <th>Language</th>
                    <th>Skill Level</th>
                </tr>
                </thead>
                <tbody>
                <?php for ($i = 0; $i < count($proLanguages); $i++) { ?>
                    <tr>
                        <td><?php echo htmlentities($proLanguages[$i]) ?></td>
                        <td><?php echo htmlentities($langLevel[$i]) ?></td>
                    </tr>
                <?php }; ?>
                </tbody>
            </table>
        </td>
    </tr>
    </tbody>
</table>

<table>
    <thead>
    <tr>
        <th colspan="2">Languages</th>
    </tr>
    </thead>
    <tbody>
    <tr>
        <td>Languages</td>
        <td>
            <table class="innerTable">
                <thead>
                <tr>
                    <th>Language</th>
                    <th>Comprehension</th>
                    <th>Reading</th>
                    <th>Writing</th>
                </tr>
                </thead>
                <tbody>
                <?php for ($i = 0; $i < count($languages); $i++) { ?>
                    <tr>
                        <td><?php echo htmlentities($languages[$i]) ?></td>
                        <td><?php echo htmlentities($comprehension[$i]) ?></td>
                        <td><?php echo htmlentities($reading[$i]) ?></td>
                        <td><?php echo htmlentities($writing[$i]) ?></td>
                    </tr>
                <?php }; ?>
                </tbody>
            </table>
        </td>
    </tr>
    <tr>
        <td>Driver's license</td>
        <td colspan="4">
            <?php for ($i = 0; $i < count($driverLicenses); $i++) {
                if ($i == count($driverLicenses) - 1) {
                    echo htmlentities($driverLicenses[$i]);
                } else {
                    echo htmlentities($driverLicenses[$i]) . ", ";
                }
            } ?>
        </td>
    </tr>
    </tbody>
</table>
<?php
endif;
else:
    die ('All fields must be filled!');
endif;
?>
</body>
</html>