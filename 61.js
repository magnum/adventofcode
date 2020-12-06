let answers = [];
fetch('https://adventofcode.com/2020/day/6/input')
.then(function(response) {
    response.text().then(input => {
        answers = input.split("\n\n")
        .map( r => r.split("\n"))
        let unique_answers_count = answers
        .map(a => [... new Set(a.join("").split(""))])
        .map(a => a.length);
         
        console.log("unique answers sum: " + unique_answers_count.reduce( (s, c) => s+c));
    });
});


