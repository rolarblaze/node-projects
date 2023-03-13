const mongoose = require("mongoose")

const userSchema = new mongoose.schema({
    username: {
        type: String,
        require: [true, "username is required"],
        unique: true
    },
    password: {
        type: String,
        require: [true, "user password is required"],
    },
})

const User = mongoose.model("User", userSchema);
module.exports = User;