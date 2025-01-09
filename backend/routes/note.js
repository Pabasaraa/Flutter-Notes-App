import express from 'express';
import {
  createNote,
  getNotes,
  getNote,
  deleteNote,
  updateNote,
} from '../services/note.js';
import { validateImageUrl, validateNote } from '../utils/validator.js';

const router = express.Router();

// Route Definitions
router.post('/', validateNote, validateImageUrl, createNote);
router.get('/', getNotes);
router.get('/:id', getNote);
router.delete('/:id', deleteNote);
router.put('/:id', validateImageUrl, updateNote);

export default router;
