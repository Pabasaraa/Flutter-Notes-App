import express from 'express';
import cors from 'cors';
import bodyParser from 'body-parser';
import dotenv from 'dotenv';

import connectDB from './config/database.js';
import noteRoutes from './routes/note.js';
import imageUpload from './routes/imageUpload.js';

dotenv.config();

const app = express();
app.use(cors());
app.use(bodyParser.json());
connectDB();

// health check
app.get('/', (req, res) => {
  res.json({ message: 'Health check!', success: true });
});

app.use('/notes', noteRoutes);
app.use('/assets', imageUpload);

app.listen(process.env.PORT, () => {
  console.log(`Server is running on port ${process.env.PORT}`);
});
