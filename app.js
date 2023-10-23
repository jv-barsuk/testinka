
const express = require('express')
const hbs = require('hbs')
const fs = require("fs")
const app = express()


var testSuite

app.set('view engine', 'hbs')

app.set('views', 'views')



app.get('/', (req, res) => {

    fs.readFile('out.json', (err, data) => {
        if (err) {
            console.error('Error reading the file:', err);
            return;
        }
        testData = JSON.parse(data);
        res.render('test.hbs', testData.scenarios[1])
    });

    
})

app.get('/static/:file', (req, res) => {
    res.sendFile(`${__dirname}/static/${req.params.file}`)
})

app.listen(3000);