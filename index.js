const e = require('express');
const express = require('express');
const mongoose = require('mongoose');
const { 
  MONGO_USER, 
  MONGO_PASSWORD, 
  MONGO_IP, 
  MONGO_PORT } = require('./config/config');

  const postRouter = require("./routes/postRoutes");
  const userRouter = require("./routes/userRoute")

const app = express();
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

app.use(express.json());

const port = 500

app.get('/', (req, res) => {
  res.send("<h2> Hello Docker!")
});

app.use("/api/v1/posts", postRouter);
app.use("/api/v1/users", userRouter);

app.listen(port, () => {
  console.log(`Example app listening on port ${port}`)
});