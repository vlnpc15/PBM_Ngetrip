const express = require("express");
const { get, create, addImage } = require("../controllers/places.controller");
const { uploadSingle, uploadMultiple } = require("../middlewares/multer");
const { signIn, signUp } = require("../controllers/users.controller");
const router = express.Router();

router.get("/places", get);
router.get("/places/:id", get);
router.post("/login", signIn);
router.post("/register", uploadSingle, signUp);
router.post("/create", uploadMultiple, create);
router.post("/post/:id", uploadMultiple, addImage);

module.exports = router;
