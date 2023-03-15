const express = require("express");

const postController = require("../controllers/postController");
const protect = require("../middleware/authMiddleWare");

const router = express.Router();

// this route to locaalhost 3000
router
    .route("/")
    .get(protect, postController.getAllPosts)
    .post(protect, postController.createPost);
router
    .route("/:id")
    .get(protect, postController.getOnePost)
    .patch(protect, postController.updatePost)
    .delete(protect, postController.updatePost);