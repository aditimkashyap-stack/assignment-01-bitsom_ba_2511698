// OP1: insertMany() — insert all 3 documents from sample_documents.json
db.products.insertMany([
  {
    "_id": "ELEC1001",
    "category": "Electronics",
    "name": "VoltEdge 55-inch 4K Smart TV",
    "brand": "VoltEdge",
    "price": 42999,
    "specs": {
      "display": "LED",
      "resolution": "4K",
      "voltage": "110-240V",
      "ports": ["HDMI", "USB", "Optical"]
    },
    "warranty": { "months": 24, "type": "Manufacturer" },
    "tags": ["tv", "smart", "4k"],
    "ratings": [
      { "user": "u101", "stars": 5, "comment": "Great picture quality" },
      { "user": "u204", "stars": 4, "comment": "Value for money" }
    ],
    "in_stock": true
  },
  {
    "_id": "CLOT2001",
    "category": "Clothing",
    "name": "AeroFit Running Jacket",
    "brand": "AeroFit",
    "price": 2999,
    "variants": [
      { "color": "Black", "size": "M", "sku": "AFJ-BLK-M", "stock": 18 },
      { "color": "Blue", "size": "L", "sku": "AFJ-BLU-L", "stock": 9 }
    ],
    "material": { "primary": "Polyester", "blend": "Spandex" },
    "care": ["Machine wash cold", "Do not bleach"],
    "fit": "Regular",
    "in_stock": true
  },
  {
    "_id": "GROC3001",
    "category": "Groceries",
    "name": "Organic Whole Wheat Bread",
    "brand": "DailyHarvest",
    "price": 120,
    "expiry_date": "2024-12-20",
    "nutrition": {
      "serving_size_g": 40,
      "calories": 95,
      "macros": { "carbs_g": 18, "protein_g": 4, "fat_g": 1 }
    },
    "ingredients": ["Whole wheat flour", "Yeast", "Salt", "Water"],
    "allergens": ["Gluten"],
    "batch": { "code": "BREAD-1220-A", "packed_on": "2024-12-10" },
    "in_stock": true
  }
]);
// OP2: find() — retrieve all Electronics products with price > 20000
db.products.find(
  { category: "Electronics", price: { $gt: 20000 } },
  { _id: 1, name: 1, brand: 1, price: 1 }
);
// OP3: find() — retrieve all Groceries expiring before 2025-01-01
db.products.find(
  { category: "Groceries", expiry_date: { $lt: "2025-01-01" } },
  { _id: 1, name: 1, expiry_date: 1, price: 1 }
);
// OP4: updateOne() — add a "discount_percent" field to a specific product
db.products.updateOne(
  { _id: "ELEC1001" },
  { $set: { discount_percent: 10 } }
);
// OP5: createIndex() — create an index on category field and explain why
// Index speeds up queries filtering by category (used in OP2 and OP3),
// reducing full collection scans as the catalog grows.
db.products.createIndex({ category: 1 });
