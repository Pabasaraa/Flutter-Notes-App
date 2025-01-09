import dotenv from 'dotenv';
dotenv.config();

export const validateNote = (req, res, next) => {
  if (!req.body.title) {
    return res.json({ message: 'Title is required' });
  }
  next();
};

export const validateImageUrl = (req, res, next) => {
  if (req.body.imageUrl) {
    const bucketName = process.env.AWS_BUCKET_NAME;
    const s3UrlPattern = new RegExp(
      `^https://${bucketName}\\.s3\\.amazonaws\\.com/.+\\.(jpg|jpeg|png|gif)$`
    );
    if (!s3UrlPattern.test(req.body.imageUrl)) {
      return res.json({ message: 'Invalid image URL' });
    }
  }
  next();
};

// export const validateS3ImageUrlWithEnv = (url) => {
//   const bucketName = process.env.AWS_BUCKET_NAME;
//   const s3UrlPattern = new RegExp(
//     `^https://${bucketName}\\.s3\\.amazonaws\\.com/.+\\.(jpg|jpeg|png|gif)$`
//   );
//   return s3UrlPattern.test(url);
// };
