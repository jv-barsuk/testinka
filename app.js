
const express = require('express')
const hbs = require('hbs')
const fs = require("fs")
const app = express()

// const dataFile = 'data/data.json'

app.set('view engine', 'hbs')

app.set('views', 'views')

app.get('/', (req, res) => {
    dataFile = `data/${req.query.project}/build/${req.query.scenario}.json`
    fs.readFile(dataFile, (err, data) => {
        if (err) {
            console.error('Error reading the file:', err);
            return;
        }
        try {
            testData = JSON.parse(data);
        } catch(e) {
            console.error('Error reading the file:', err);
            res.send("Test not found")
            return
        }
        console.log(testData.scenarios[0])
        res.render('test.hbs', testData.scenarios[0])
    }); 
})

app.use('/static', express.static('public'))

app.listen(3000);