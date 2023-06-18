const User = require("../models/users");
const Validator = require("fastest-validator");

const v = new Validator();

module.exports = {
  signIn: async (req, res) => {
    try {
      const schema = {
        email: "email|empty:false",
        password: "string|min:6",
      };

      const validate = v.validate(req.body, schema);
      console.log(req.body);

      if (validate.length) {
        return res.status(400).json({
          status: "error",
          message: validate,
        });
      }
      const { email, password } = req.body;
      const user = await User.findOne({ email: email });
      if (user) {
        const checkPassword = password === user.password;
        if (checkPassword) {
          return res.status(200).json({
            status: "Success",
            data: user,
          });
        } else {
          return res.status(401).json({
            status: "failed",
            message: "wrong password",
          });
        }
      } else {
        return res.status(404).json({
          status: "failed",
          message: "not found",
        });
      }
    } catch (error) {
      return res.status(500).json({
        status: "failed",
        message: "Server error",
      });
    }
  },
  signUp: async (req, res) => {
    try {
      const schema = {
        name: "string|empty:false",
        username: "string|empty:false",
        email: "email|empty:false",
        gender: "string|empty:false",
        phone: "string|empty:false",
        bio: "string|optional",
        password: "string|min:6",
      };

      const validate = v.validate(req.body, schema);
      console.log(req.body.profile);

      if (validate.length) {
        return res.status(400).json({
          status: "error",
          message: validate,
        });
      }

      const exist = await User.findOne({
        where: { email: req.body.email },
      });

      if (exist) {
        return res.status(409).json({
          status: "error",
          message: "email already exist",
        });
      }

      const { email, name, username, bio, profile, gender, password } =
        req.body;

      const data = {
        email,
        name,
        username,
        bio,
        profile: req.file?.filename ? `images/${req.file?.filename}` : null,
        gender,
        password,
      };

      const createUser = new User(data);

      await createUser.save();

      return res.status(201).json({
        status: "Success",
        data: createUser,
      });
    } catch (error) {
      console.log(error);
      return res.status(500).json({
        status: "failed",
        message: "Server error",
      });
    }
  },
};
