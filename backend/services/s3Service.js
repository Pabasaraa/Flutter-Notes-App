import { PutObjectCommand, GetObjectCommand } from '@aws-sdk/client-s3';
import { s3Client } from '../config/awsConfig.js';
import { v4 as uuidv4 } from 'uuid';

const bucketName = process.env.AWS_BUCKET_NAME;

export const uploadFile = async (req, res) => {
  const file = req.file;
  const sanitizedFileName = file.originalname.replace(/\s+/g, '');
  const key = `${uuidv4()}-${sanitizedFileName}`;
  const params = {
    Bucket: bucketName,
    Key: key,
    Body: file.buffer,
    ContentType: file.mimetype,
  };

  try {
    await s3Client.send(new PutObjectCommand(params));
    const imageUrl = `https://${bucketName}.s3.amazonaws.com/${key}`;
    res.status(201).json({ imageUrl });
  } catch (error) {
    throw new Error(error);
  }
};
