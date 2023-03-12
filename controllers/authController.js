const User = require("../models/userModels")

const bcrypt = require("bcryptjs")

exports.signUp = async (req, res, netx) => {
    const {username, password} = req.body
    const hashpassword = await bcrypt.hash(password, 12)
    try {
        const newUser = await User.create({
            username,
            password: hashpassword
        })
        res.status(201).json({
            status: "success",
            data: {
                user: newUser
            }
        })
    } catch (e) {
        res.status(402).json({
            status: "fail"
        });
    }
}

exports.login = async (req, res) => {
    const {username, password} = req.body
}