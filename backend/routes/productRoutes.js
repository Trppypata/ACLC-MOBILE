const express = require('express');
const { getAllProducts, getProductById, createProduct, updateProduct, deleteProduct } = require('../controller/productController');
const upload = require('../middlewares/upload'); // Import the upload middleware

const router = express.Router();

router.get('/', getAllProducts);
router.get('/:id', getProductById);
router.post('/', upload.single('image'), createProduct); // Use upload middleware for product creation
router.put('/:id', upload.single('image'), updateProduct); // Use upload middleware for product update
router.delete('/:id', deleteProduct);

module.exports = router;
