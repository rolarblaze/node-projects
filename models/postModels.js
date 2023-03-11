const mongoose  = require("mongoose");

const postSchema = new mongoose.Schema({
    title: {
        type: String,
        require: [true, "post must have a title"],
    },
    body: {
        type: String,
        required: [true, "post must have a body"],
    },
});

// exporting the model  
const Post = mongoose.model("Post", postSchema);
module.exports = Post;