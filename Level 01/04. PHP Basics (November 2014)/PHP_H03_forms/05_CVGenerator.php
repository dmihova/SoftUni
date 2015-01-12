<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8"/>
    <title>Print tags</title>
    <link rel="stylesheet" href="05_CVGenerator_styles.css"/>
    <script src="05_CVGenerator_functions.js" defer></script>
</head>
<body>
<form method="post" action="05_CVGenerator_functions.php">
    <fieldset id="personalInfo">
        <legend>Personal Info</legend>
        <input type="text" name="fName" placeholder="First Name" required/>
        <input type="text" name="lName" placeholder="Last Name" required/>
        <input type="email" name="email" placeholder="Email" required/>
        <input type="tel" name="phone" placeholder="Phone Number" required/>

        <label for="female">Female</label>
        <input type="radio" name="gender" value="Female" id="female" checked>
        <label for="male">Male</label>
        <input type="radio" name="gender" value="Male" id="male">

        <label for="birth">Birth Date</label>
        <input type="text" name="birth" id="birth" placeholder="dd/mm/yyyy" required/>

        <label for="nationality">Nationality</label>
        <select name="nationality" id="nationality" required>
            <option value="Bulgarian">Bulgarian</option>
            <option value="English">English</option>
            <option value="Nigerien">Nigerien</option>
            <option value="Venezuelan">Venezuelan</option>
        </select>
    </fieldset>

    <fieldset id="last-work">
        <legend>Last Work Position</legend>
        <label for="company">Company Name</label>
        <input type="text" name="company" id="company" required/><br>
        <label for="from">From</label>
        <input type="text" name="from" id="from" placeholder="dd/mm/yyyy" required/><br>
        <label for="to">To</label>
        <input type="text" name="to" id="to" placeholder="dd/mm/yyyy" required/><br>
    </fieldset>

    <fieldset id="comp-skills">
        <legend>Computer Skills</legend>
        <label for="proLangParent">Programming Languages</label>

        <div id="proLangParent">
            <div id="proLang">
                <input type="text" name="proLanguages[]" />
                <select name="langLevel[]">
                    <option disabled="disabled" selected="selected">Skill Level</option>
                    <option value="Beginner">Beginner</option>
                    <option value="Intermediate">Intermediate</option>
                    <option value="Advanced">Advanced</option>
                </select>
            </div>
        </div>
        <input type="button" value="Remove Language" onclick="remProLang()"/>
        <input type="button" value="Add Language" onclick="addProLang()"/>
    </fieldset>

    <fieldset id="other-skills">
        <legend>Other Skills</legend>
        <label for="languagesParent">Languages</label>

        <div id="languagesParent">
            <div id="languages">
                <input type="text" name="languages[]" />
                <select name="comprehension[]" >
                    <option disabled="disabled" selected="selected">Comprehension</option>
                    <option value="Beginner">Beginner</option>
                    <option value="Intermediate">Intermediate</option>
                    <option value="Advanced">Advanced</option>
                </select>
                <select name="reading[]" >
                    <option disabled="disabled" selected="selected">Reading</option>
                    <option value="Beginner">Beginner</option>
                    <option value="Intermediate">Intermediate</option>
                    <option value="Advanced">Advanced</option>
                </select>
                <select name="writing[]" >
                    <option disabled="disabled" selected="selected">Writing</option>
                    <option value="Beginner">Beginner</option>
                    <option value="Intermediate">Intermediate</option>
                    <option value="Advanced">Advanced</option>
                </select><br>
            </div>
        </div>
        <input type="button" value="Remove Language" onclick="remLang()"/>
        <input type="button" value="Add Language" onclick="addLang()"/><br>

        <label for="license">Driver's License</label>

        <div id="license">
            <label for="b">B</label>
            <input type="checkbox" name="license[]" value="B" id="b"/>
            <label for="a">A</label>
            <input type="checkbox" name="license[]" value="A" id="a"/>
            <label for="c">C</label>
            <input type="checkbox" name="license[]" value="C" id="c"/>
        </div>
    </fieldset>

    <input type="submit" value="Generate CV"/>
</form>
</body>
</html>