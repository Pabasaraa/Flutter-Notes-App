import mongoose from 'mongoose';

const { Schema } = mongoose;

const noteSchema = new Schema({
  title: {
    type: String,
    required: true,
  },
  content: String,
  imageUrl: String,
  createdAt: {
    type: Date,
    default: Date.now,
  },
});

const Note = mongoose.model('Note', noteSchema);
export default Note;
