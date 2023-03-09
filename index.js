const express = require('express')
const app = express()
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