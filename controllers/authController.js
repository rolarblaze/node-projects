const User = require("../models/userModels")

exports.signUp = async (req, res, netx) => {
    try {
        const newUser = await User.create(req.body)
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