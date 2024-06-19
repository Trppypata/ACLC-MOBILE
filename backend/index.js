const express = require('express');
const cors = require('cors');
const { sequelize } = require('./models');
const authRoutes = require('./routes/auth');
const productRoutes = require('./routes/productRoutes'); // Import product routes

const app = express();
const PORT = 4040;

app.use(cors());
app.use(express.json());
app.use('/auth', authRoutes);
app.use('/api/products', productRoutes); // Use product routes
app.use('/uploads', express.static('uploads')); // Serve static files from uploads directory

sequelize.sync().then(() => {
  app.listen(PORT, () => {
    console.log(`Server is running on port ${PORT}`);
  });
}).catch(error => {
  console.error('Unable to connect to the database:', error);
});
