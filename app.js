
const express = require('express')
const hbs = require('hbs')
const fs = require("fs")
const app = express()

const dataFile = 'data/data.json'

app.set('view engine', 'hbs')

app.set('views', 'views')

app.get('/', (req, res) => {
    fs.readFile(dataFile, (err, data) => {
        if (err) {
            console.error('Error reading the file:', err);
            return;
        }
        testData = JSON.parse(data);
        res.render('test.hbs', testData.scenarios[0])
    }); 
})

app.use('/static', express.static('public'))

app.listen(3000);