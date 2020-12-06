let answers = [];
fetch('https://adventofcode.com/2020/day/6/input')
.then(function(response) {
    response.text().then(input => {
        answers = input.split("\n\n")
        .map( r => r.split("\n"))
        .map( r => r.filter( r => r != ""))

        // part 1
        let unique_answers_count = answers
        .map(a => [... new Set(a.join("").split(""))])
        .map(a => a.length);
        console.log("unique answers sum: " + unique_answers_count.reduce( (s, c) => s+c));

        // part 2
        let common_answers = answers.map( answer => {
            return [... new Set(answer.join("").split(""))].sort()
            .map( v => {
                return {
                    value: v,
                    count: answer.join("").split("").filter(i => i==v).length
                };
            })
            .filter( v => v.count >= answer.length)
        })
        console.log("common answers sum: "+common_answers.map(a => a.length).reduce( (s,i) => s+i));
    });
});