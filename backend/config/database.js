import mongoose from 'mongoose';
import dotenv from 'dotenv';

dotenv.config();

export default async function connectDB() {
  try {
    await mongoose.connect(process.env.MONGO_URI);

    const connection = mongoose.connection;

    connection.once('open', () => {
      console.log('MongoDB database connection established successfully');
    });
  } catch (error) {
    console.error(error.message);
    process.exit(1);
  }
}
