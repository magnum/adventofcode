// testing chatGPT3: not working but cannot find why...

const fs = require('fs');

const positions1 = [];
const positions2 = [];
const rope = Array(19).fill({x:0, y:0});

const headMove = (direction) => {
  switch (direction) {  
    case "R": rope[0].x += 1; break;  
    case "L": rope[0].x -= 1; break;
    case "U": rope[0].y += 1; break;    
    case "D": rope[0].y -= 1; break;  
  }
}


function tailFollow(i) {
  let dist = {
    x: (rope[i-1].x - rope[i].x),
    y: (rope[i-1].y - rope[i].y)
  };
  console.log(`i: ${i}, dist: {x: ${dist.x}, y: ${dist.y}}`)
  let len = Math.abs(dist.x) + Math.abs(dist.y);
  if (len === 0) return;
  dist.x = Math.round(dist.x / len);
  dist.y = Math.round(dist.y / len);
  rope[i] = {x: rope[i-1].x - dist.x, y: rope[i-1].y - dist.y};
}


fs.readFileSync('day9.test.txt').toString().split("\n")
.forEach(line => {
  const [direction, steps] = line.split(" ")
  for (let i = 0; i < steps; i++) {
    headMove(direction);
    for (let i = 0; i < 9; i++) tailFollow(i+1);
    positions1.push(rope[1]);
    positions2.push(rope[9]);
  }
});

const result1 = [...new Set(positions1)].length
const result2 = [...new Set(positions2)].length
console.log(`part1: ${result1}`);
console.log(`part1: ${result2}`);


