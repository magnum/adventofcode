const fs = require('fs');
const path = require('path'); 
const lines = fs.readFileSync(path.resolve(__dirname, 'day1.txt'), 'utf-8')
.split('\n');
const splits = lines.map((line, i) => line.split(' ').filter(a => a!=''));
const list1 = splits.map((split) => Number(split[0]));
const list2 = splits.map((split) => Number(split[1]));

// Part 1
const results1 = list1.sort().map((num, i) => {
    return Math.abs(num - list2.sort()[i]);
})
console.log("part1", results1.reduce((acc, item) => acc + item, 0));

// Part 2
const results2 = list1.map( a => {
    return a * list2.filter( n => n == a).length;
})
console.log("part2", results2.reduce((acc, item) => acc + item, 0));

