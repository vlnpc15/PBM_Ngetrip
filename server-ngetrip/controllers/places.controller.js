const Places = require("../models/places");
const Validator = require("fastest-validator");

const v = new Validator();

module.exports = {
  create: async (req, res) => {
    try {
      const schema = {
        name: "string|empty:false",
        category: "string|empty:false",
        address: "string|empty:false",
        phone: "string|empty:false",
        lang: "array",
      };

      const validate = v.validate(req.body, schema);

      if (validate.length) {
        return res.status(400).json({
          status: "error",
          message: validate,
        });
      }
      const { name, category, phone, price, address, lang } = req.body;
      const actualPrice = +price;

      const images = [];
      if (req.files)
        for (let i = 0; i < req.files?.length; i++) {
          images.push(`images/${req.files[i].filename}`);
        }

      let coordinate;

      if (lang) {
        coordinate = lang.map(function (item) {
          return parseFloat(`${item}`);
        });
      }

      const data = {
        name,
        thumbnails: images,
        category,
        phone,
        price: actualPrice,
        address,
        lang: coordinate,
      };

      const createPlaces = new Places(data);

      await createPlaces.save();

      return res.status(201).json({
        status: "Success",
        data: createPlaces,
      });
    } catch (error) {
      return res.status(500).json({
        status: "failed",
        message: "Server error",
      });
    }
  },
  addImage: async (req, res) => {
    try {
      const { id } = req.params;

      const images = [];
      if (req.files) {
        for (let i = 0; i < req.files?.length; i++) {
          images.push(`images/${req.files[i].filename}`);
        }
      }

      if (images.length > 0) {
        const place = await Places.findOne({ _id: id });

        place.thumbnails = [...place.thumbnails, ...images];

        await place.save();
      }

      return res.status(201).json({
        status: "Success",
      });
    } catch (error) {
      return res.status(500).json({
        status: "failed",
        message: "Server error",
      });
    }
  },
  get: async (req, res) => {
    try {
      const schema = {
        id: "string|optional",
      };

      const validate = v.validate(req.params, schema);

      if (validate.length) {
        return res.status(400).json({
          status: "error",
          message: validate,
        });
      }
      const { id } = req.params;

      let places;
      if (id) {
        places = await Places.findOne({ _id: id });
      } else {
        places = await Places.find();
      }

      return res.status(200).json({
        status: "Success",
        data: places,
      });
    } catch (error) {
      return res.status(500).json({
        status: "failed",
        message: "Server error",
      });
    }
  },
};
