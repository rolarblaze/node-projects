const e = require('express');
const express = require('express')
const mongoose = require('mongoose');
const app = express()

mongoose
    .connect("mongodb://docuser:32docuser@mongo:197.253.4.26:27017/authsource=admin")
    .then(() => console.log("successfully connected!"))
    .catch((e) => console.log(e)) 
const port = 500

app.get('/', (req, res) => {
  res.json([
    {
        name: 'Bob', 
        email: 'wordofword_2@yahoo.com',
        phone: '09099988787',
        state: 'Lagos'
    }
  ])
})

app.listen(port, () => {
  console.log(`Example app listening on port ${port}`)
})