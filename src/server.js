import express from 'express'
import configViewEngine from './configs/viewEngine'
require('dotenv').config()
const port = process.env.PORT || 3000

const app = express()


configViewEngine(app)
app.get('/', (req, res) => {
  res.send('Hello World!')
})

app.get('/', function(req, res) {
    res.sendFile(path.join(__dirname, './FE/4T.html'));
  });

app.listen(port, () => {
  console.log(`Example app listening on port ${port}`)
})