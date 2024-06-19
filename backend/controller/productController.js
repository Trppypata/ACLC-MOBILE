const { Product } = require('../models');

const getAllProducts = async (req, res) => {
  try {
    const products = await Product.findAll();
    console.log('Fetched products:', products); // Log the fetched products
    res.status(200).json(products);
  } catch (error) {
    console.error('Failed to fetch products:', error); // Log the error
    res.status(500).json({ error: 'Failed to fetch products' });
  }
};

const getProductById = async (req, res) => {
  const { id } = req.params;
  try {
    const product = await Product.findByPk(id);
    if (product) {
      res.status(200).json(product);
    } else {
      res.status(404).json({ error: 'Product not found' });
    }
  } catch (error) {
    res.status(500).json({ error: 'Failed to fetch product' });
  }
};

const createProduct = async (req, res) => {
  const { name, price, description } = req.body;
  const imageUrl = req.file ? `/uploads/${req.file.filename}` : null;

  try {
    const product = await Product.create({ name, price, description, imageUrl });
    console.log('Product created:', product); // Log the created product
    res.status(201).json(product);
  } catch (error) {
    console.error('Failed to create product:', error); // Log the error
    res.status(500).json({ error: 'Failed to create product' });
  }
};


const updateProduct = async (req, res) => {
  const { id } = req.params;
  const { name, price, description } = req.body;
  const imageUrl = req.file ? `/uploads/${req.file.filename}` : null;

  try {
    const product = await Product.findByPk(id);
    if (product) {
      await product.update({ name, price, description, imageUrl });
      res.status(200).json(product);
    } else {
      res.status(404).json({ error: 'Product not found' });
    }
  } catch (error) {
    res.status(500).json({ error: 'Failed to update product' });
  }
};

const deleteProduct = async (req, res) => {
  const { id } = req.params;
  try {
    const product = await Product.findByPk(id);
    if (product) {
      await product.destroy();
      res.status(200).json({ message: 'Product deleted successfully' });
    } else {
      res.status(404).json({ error: 'Product not found' });
    }
  } catch (error) {
    res.status(500).json({ error: 'Failed to delete product' });
  }
};

module.exports = {
  getAllProducts,
  getProductById,
  createProduct,
  updateProduct,
  deleteProduct,
};
