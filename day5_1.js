let passes = [];
fetch('https://adventofcode.com/2020/day/5/input')
.then(function(response) {
    response.text().then(input => {
        let passes = input.split("\n")
        .map( r => r.trim())
        .filter( r => r!="")
        .map(p => {
            // rows
            let rl = 0;
            let rr = 128;
            let r = null;
            for(let i=0; i<7; i++) {
                p[i] == "F" ? rr -= (rr-rl)/2 : rl += (rr-rl)/2;
                if(rr-rl == 1) r = p[i] == "F" ? rl : rr-1;
            }
            // columns
            let cl = 0;
            let cr = 8;
            c = null;
            for(let i=7; i<10; i++) {
                p[i] == "L" ? cr -= (cr-cl)/2 : cl += (cr-cl)/2;
                if(cr-cl == 1) c = p[i] == "L" ? cl : cr-1;
            }
            return  {
                pass: p,
                row: r,
                column: c,
                id: r*8+c,
            }
        })
        .sort((a, b) => b.id - a.id);
        console.log(passes[0])
    });
});