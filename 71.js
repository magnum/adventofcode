let rules = []
let results = []
fetch('https://adventofcode.com/2020/day/7/input')
.then(response => {
    response.text().then(input => {
        rules = input.split("\n")
        .filter(r => r != "")
        .map(r => {
            let container = r.split("contain ")[0]
            .replace("bags", "")
            .replace("bag", "").trim();
            let contents = r.split("contain ")[1].replace(".", "")
            .split(", ")
            .map(c => c.replace("bags","").replace("bag","").trim())
            return {
                container: container,
                contents: contents,
                rule: r,
            }
        })

        let countRulesThatCanContain = (color) => {
            let founds = rules.filter(r => r.contents.filter(r => r.indexOf(color) != -1).length > 0)
            results = [...results, ...founds]
            founds.forEach( f => countRulesThatCanContain(f.container))
        };

        countRulesThatCanContain("shiny gold");
        console.log([... new Set(results.map( r => r.container))].length)
    });
});

