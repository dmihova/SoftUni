<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>String modifier</title>
    <style>
        table, tr {
            border: black 1px solid;
        }
    </style>
</head>
<body>
<main>
    <form action="#" method="post">
        <table>
            <thead>
            <tr>
                <td>First Name</td>
                <td>Second Name</td>
                <td>Email</td>
                <td colspan="2">Exam score</td>
            </tr>
            </thead>
            <tbody id="tableBody"></tbody>
        </table>
        <input type="button" value="+" / onclick="addRecord()"> <label>Sort
            by: </label> <select name="sortCriteria" id="sortCriteria">
            <option>First Name</option>
            <option>Last Name</option>
            <option>Email</option>
            <option>Exam score</option>
        </select> <label>Order: </label> <select name="sortOrder">
            <option>Descending</option>
            <option>Ascending</option>
        </select> <input type="submit" value="SUBMIT" />
    </form>
</main>
<script src="07_StudentSorting.js"></script>
</body>
</html>