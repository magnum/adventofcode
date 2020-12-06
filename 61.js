let answers = [];
fetch('https://adventofcode.com/2020/day/6/input')
.then(function(response) {
    response.text().then(input => {
        answers = input.split("\n\n")
        .map( r => r.split("\n"))
        let unique_answers = answers.map(as => [... new Set(as.join("").split(""))])
        .map(as => as.length)
         
        console.log("unique answers sum: " + unique_answers.reduce( (sum, acount) => sum+acount))
    });
});


