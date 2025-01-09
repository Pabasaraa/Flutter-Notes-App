import express from 'express';
import multer from 'multer';

const upload = multer({ storage: multer.memoryStorage() });

import {
  createNote,
  getNotes,
  getNote,
  deleteNote,
  updateNote,
} from '../services/note.js';
import { validateImageUrl, validateNote } from '../utils/validator.js';

const router = express.Router();

router.post('/', validateNote, validateImageUrl, createNote);
router.get('/', getNotes);
router.get('/:id', getNote);
router.delete('/:id', deleteNote);
router.put('/:id', validateImageUrl, updateNote);

export default router;
