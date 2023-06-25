const mongoose = require("mongoose");
const db = process.env.DATABASE_URL;

const connectToDatabase = async () => {
  try {
    console.log("Connecting to the database...");
    mongoose.set("strictQuery", false); 

    await mongoose.connect(db, {
      useNewUrlParser: true,
      useUnifiedTopology: true,
    });

    console.log("Connection successful");
  } catch (err) {
    console.log("Failed to connect to the database:", err.message);
  }
};

connectToDatabase();
