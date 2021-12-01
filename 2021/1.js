//const fetch = import("node-fetch");
//import fetch from 'node-fetch'

let count = 0;
let prev = false;
fetch('https://adventofcode.com/2021/day/1/input')
.then(function(response) {
    response.text().then(input => {
        input.split("\n")
        numbers.forEach( n => {
            if(prev && (n > prev)) count ++;
            prev = n;
        })
        console.log(count);
    });
});