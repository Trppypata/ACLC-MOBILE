const express = require('express');
const bcrypt = require('bcrypt');
const { User } = require('../models');
const cors = require('cors');
const router = express.Router();

router.use(cors());

router.post('/register', async (req, res) => {
  try {
    console.log('Request received:', req.body);

    const { name, email, number, password } = req.body;

    const existingUser = await User.findOne({ where: { email } });
    if (existingUser) {
      console.log('User already exists');
      return res.status(400).json({ message: 'User already exists' });
    }

    const hashedPassword = await bcrypt.hash(password, 10);
    const newUser = await User.create({ name, email, number, password: hashedPassword });

    console.log('User created:', newUser);
    res.status(201).json({ message: 'User created', user: newUser });
  } catch (error) {
    console.error('Error creating user:', error);
    res.status(500).json({ error: error.message });
  }
});

module.exports = router;
