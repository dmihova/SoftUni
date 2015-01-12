var idProLang = 0;
var idLang = 0;

function addProLang(){
    idProLang++;

    var newDiv = document.createElement("div");
    newDiv.setAttribute('id', "proLang" + idProLang);
    newDiv.innerHTML =
        "<input type=\"text\" name=\"proLanguages[]\" />" +
        "<select name=\"langLevel[]\">" +
        "<option disabled=\"disabled\" selected=\"selected\">Skill Level</option>" +
        "<option value=\"Beginner\">Beginner</option>" +
        "<option value=\"Intermediate\">Intermediate</option>" +
        "<option value=\"Advanced\">Advanced</option>" +
        "</select>";
    document.getElementById('proLangParent').appendChild(newDiv);
}

function remProLang(){
    var inputEl = document.getElementById('proLangParent').lastChild;
    document.getElementById('proLangParent').removeChild(inputEl);
}

function addLang(){
    idLang++;

    var newDiv = document.createElement("div");
    newDiv.setAttribute('id', "languages" + idProLang);
    newDiv.innerHTML =
        "<input type=\"text\" name=\"languages[]\"/>" +
        "<select name=\"comprehension[]\">" +
        "<option disabled=\"disabled\" selected=\"selected\">Comprehension</option>" +
        "<option value=\"Beginner\">Beginner</option>" +
        "<option value=\"Intermediate\">Intermediate</option>" +
        "<option value=\"Advanced\">Advanced</option>" +
        "</select>" +
        "<select name=\"reading[]\">" +
        "<option disabled=\"disabled\" selected=\"selected\">Reading</option>" +
        "<option value=\"Beginner\">Beginner</option>" +
        "<option value=\"Intermediate\">Intermediate</option>" +
        "<option value=\"Advanced\">Advanced</option>" +
        "</select>" +
        "<select name=\"writing[]\">" +
        "<option disabled=\"disabled\" selected=\"selected\">Writing</option>" +
        "<option value=\"Beginner\">Beginner</option>" +
        "<option value=\"Intermediate\">Intermediate</option>" +
        "<option value=\"Advanced\">Advanced</option>" +
        "</select>";

    document.getElementById('languagesParent').appendChild(newDiv);
}

function remLang(){
    var inputEl = document.getElementById('languagesParent').lastChild;
    document.getElementById('languagesParent').removeChild(inputEl);
}