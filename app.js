
const express = require('express')
const hbs = require('hbs')
const fs = require("fs")
const app = express()


var testSuite

app.set('view engine', 'hbs')

app.set('views', 'views')

let demo = {
    name: 'Rohan',
    age: 26
}
 
fs.readFile('out.json', (err, data) => {
    if (err) {
        console.error('Error reading the file:', err);
        return;
    }
    testSuite = JSON.parse(data);
});


app.get('/', (req, res) => {
    res.render('test.hbs', testSuite.collections[1])
})

app.listen(3000);