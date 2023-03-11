const e = require('express');
const express = require('express')
const mongoose = require('mongoose');
const { MONGO_USER, MONGO_PASSWORD, MONGO_IP, MONGO_PORT } = require('./config/config');
const app = express()
const mongo_URL = `mongodb://${MONGO_USER}:${MONGO_PASSWORD}@${MONGO_IP}:${MONGO_PORT}/?
authsource=admin`

const connectWithRetry = () => 
{
  mongoose
    .connect(mongo_URL, {
      useNewUrlParser: true,
      useUnifiedTopology: true,
      useFindAndModified: false
    })
    .then(() => console.log("successfully connected!"))
    .catch((e) => {
      console.log(e)
      setTimeout(connectWithRetry, 5000)
    }); 
}

connectWithRetry(); 

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