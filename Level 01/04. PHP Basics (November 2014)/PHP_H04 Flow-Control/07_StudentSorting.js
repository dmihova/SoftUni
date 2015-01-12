var nextId = 1;
addRecord();
function addRecord() {
    var newRow = document.createElement("tr");
    newRow.id = "r" + nextId;
    var firstName = document.createElement("input");
    firstName.setAttribute("type", "text");
    firstName.style.marginRight = "5px";
    firstName.setAttribute("name", "firstName[]");
    var secondName = document.createElement("input");
    secondName.setAttribute("type", "text");
    secondName.style.marginRight = "5px";
    secondName.setAttribute("name", "secondName[]");
    var email = document.createElement("input");
    email.setAttribute("type", "email");
    email.style.marginRight = "5px";
    email.setAttribute("name", "emails[]");
    var examScore = document.createElement("input");
    examScore.setAttribute("type", "text");
    examScore.style.marginRight = "5px";
    examScore.setAttribute("name", "scores[]");
    var removeRecord = document.createElement("input");
    removeRecord.setAttribute("type", "button");
    removeRecord.setAttribute("value", "-");

    removeRecord.style.background = "blue";
    removeRecord.style.color = "white";

    newRow.appendChild(document.createElement("td")).appendChild(firstName);
    newRow.appendChild(document.createElement("td")).appendChild(secondName);
    newRow.appendChild(document.createElement("td")).appendChild(email);
    newRow.appendChild(document.createElement("td")).appendChild(examScore);
    newRow.appendChild(document.createElement("td")).appendChild(removeRecord);

    var tbl = document.getElementById('tableBody');
    tbl.appendChild(newRow);
    removeRecord.onclick = function() {
        remRecord(newRow);
    };
    nextId++;
}

function remRecord(row) {
    var tbl = document.getElementById('tableBody');
    tbl.removeChild(row);
}