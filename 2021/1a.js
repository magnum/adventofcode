let count = 0;
let prev = false;
fetch('https://adventofcode.com/2021/day/1/input')
.then(function(response) {
    response.text().then(input => {
        input.split("\n").forEach( n => {
            n = parseInt(n)
            if(prev && (n > prev)) count ++;
            //console.log(`${n} > ${prev} ? ${n > prev}, count: ${count}`);
            prev = n;
        })
        console.log(count);
    });
});
