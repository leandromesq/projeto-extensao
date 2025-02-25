class MockData {
  static const Map<String, dynamic> mockData = {
    "users": [
      {
        "id": 1,
        "name": "Alice Johnson",
        "email": "alice@example.com",
        "password": "hashedpassword1",
        "profilepic": "alice.jpg",
        "qrcode": "qrcode1.png"
      },
      {
        "id": 2,
        "name": "Bob Smith",
        "email": "bob@example.com",
        "password": "hashedpassword2",
        "profilepic": "bob.jpg",
        "qrcode": "qrcode2.png"
      }
    ],
    "orders": [
      {"id": 1, "total": 45.99, "user_id": 1, "date": "2025-02-24T14:30:00Z"},
      {"id": 2, "total": 78.50, "user_id": 2, "date": "2025-02-23T18:15:00Z"}
    ],
    "items": [
      {"id": 1, "order_id": 1, "name": "Laptop Sleeve", "price": 25.99},
      {"id": 2, "order_id": 1, "name": "Wireless Mouse", "price": 20.00},
      {"id": 3, "order_id": 2, "name": "Mechanical Keyboard", "price": 50.00},
      {"id": 4, "order_id": 2, "name": "USB-C Hub", "price": 28.50}
    ],
    "rachadinhas": [
      {"id": 1, "item_id": 1, "name": "Alice & Bob Share", "price": 12.99},
      {"id": 2, "item_id": 3, "name": "Group Contribution", "price": 25.00}
    ]
  };
}
