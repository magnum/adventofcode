fetch('https://adventofcode.com/2020/day/6/input')
.then(function(response) {
    response.text().then(input => {
        answers = input.split("\n\n")
        .map( r => r.split("\n"))
        .map( r => r.filter( r => r != ""))

        // part 1
        console.log(
            answers
            .map(a => [... new Set(a.join("").split(""))])
            .map(a => a.length)
            .reduce( (s, c) => s+c)
        )

        // part 2
        console.log(
            answers.map(answer => [... new Set(answer.join("").split(""))].sort()
                .map( v => answer.join("").split("").filter(i => i==v).length)
                .filter( v => v >= answer.length)
            ).map(a => a.length).reduce( (s,i) => s+i)
        )
    });
});