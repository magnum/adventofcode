fetch('https://adventofcode.com/2020/day/4/input')
.then(function(response) {
    response.text().then(input => {
        const validations = {
          byr: "0*(19[2-8][0-9]|199[0-9]|200[0-2])",
          iyr: "0*(201[0-9]|2020)",
          eyr: "0*(202[0-9]|2030)",
          hgt: "(1[5-8][0-9]|19[0-3])cm|(59|6[0-9]|7[0-6])in",
          hcl: "^#[a-fA-F0-9]{6}",
          ecl: "amb|blu|brn|gry|grn|hzl|oth",
          pid: "^\\d{9}$"
        }
        
        // parsing passports
        const passports_valid = input.split("\n\n")
        .map( block => block.replaceAll('\n', ' ').split(" ").map( kv => kv.split(":")))
        .filter( passport => { // validating
          return passport.filter( field => {
            if(!validations[field[0]]) return false;
            return (field[1].match( validations[field[0]] || "" ) || []).length > 0;
          }).length >= Object.keys(validations).length;
        })
        console.log(passports_valid)
    });
});