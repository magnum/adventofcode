fetch('https://adventofcode.com/2020/day/4/input')
.then(function(response) {
    response.text().then(input => {
        const validations = [
          {field: "byr", regexp: "0*(19[2-8][0-9]|199[0-9]|200[0-2])"},
          {field: "iyr", regexp: "0*(201[0-9]|2020)"},
          {field: "eyr", regexp: "0*(202[0-9]|2030)"},
          {field: "hgt", regexp: "(1[5-8][0-9]|19[0-3])cm|(59|6[0-9]|7[0-6])in"},
          {field: "hcl", regexp: "^#[a-fA-F0-9]{6}"},
          {field: "ecl", regexp: "amb|blu|brn|gry|grn|hzl|oth"},
          {field: "pid", regexp: "^\\d{9}$"}
        ]
        
        // parsing passports
        let passports = input 
        .split("\n\n")
        .map( p => {
          return p.replaceAll('\n', ' ').split(" ").map( v => v.split(":"));
        })
        .filter( p => { // validating
          return p.filter( f => {
            let validation = validations.filter( v => v.field == f[0])[0]
            if(!validation) return false;
            return (f[1].match(validation.regexp) || []).length > 0;
          }).length >= validations.length;
        })
        console.log(passports)
    });
});