import express from 'express';
import cors from 'cors';
import dotenv from 'dotenv';

import connectDB from './config/database.js';
import noteRoutes from './routes/note.js';
import imageUpload from './routes/imageUpload.js';

dotenv.config();

const app = express();
const PORT = process.env.PORT || 5000;

app.use(cors());
app.use(express.json());
connectDB();

// health check
app.get('/', (req, res) => {
  res.json({ message: 'Health check!', success: true });
});

app.use('/notes', noteRoutes);
app.use('/assets', imageUpload);

// Error handling middleware
app.use((err, req, res, next) => {
  console.error(err.stack);
  res.status(500).json({ message: 'Something went wrong!', success: false });
});

app.listen(PORT, () => {
  console.log(`Server is running on port ${PORT}`);
});
