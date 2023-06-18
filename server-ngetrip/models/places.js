const mongoose = require("mongoose");

let placesSchema = mongoose.Schema({
  name: {
    type: String,
    require: true,
  },
  category: {
    type: String,
    require: true,
  },
  phone: {
    type: String,
    require: true,
  },
  price: {
    type: Number,
    require: true,
  },
  address: { type: String, require: true },
  lang: { type: Array },
  thumbnails: {
    type: Array,
  },
});

module.exports = mongoose.model("Places", placesSchema);
