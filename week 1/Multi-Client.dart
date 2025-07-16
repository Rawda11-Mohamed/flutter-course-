import 'dart:io';

void main() {
  // Store product information
  final products = [
    {'name': 'Keyboard', 'price': 100.0},
    {'name': 'Mouse', 'price': 50.0},
    {'name': 'Monitor', 'price': 300.0},
    {'name': 'USB Cable', 'price': 20.0},
    {'name': 'Headphones', 'price': 150.0},
  ];

  print('Welcome to our Simple Store!');

  // Main program loop
  while (true) {
    print('\n=== New Customer ===');
    handleCustomerOrder(products);
    print('\nReady for next customer...');
  }
}

// Function to show the product menu
void showMenu(List<Map<String, dynamic>> products) {
  print('\nAvailable Products:');
  for (int i = 0; i < products.length; i++) {
    print('${i + 1}. ${products[i]['name']} - \$${products[i]['price']}');
  }
}

// Function to calculate tax (13%)
double calculateTax(double subtotal) {
  return subtotal * 0.13;
}

// Function to calculate discount (5% if over $500)
double calculateDiscount(double subtotal) {
  if (subtotal > 500) {
    return subtotal * 0.05;
  }
  return 0.0;
}

// Function to calculate delivery fee ($5 per km)
double calculateDeliveryFee(double distance) {
  return distance * 5;
}

void handleCustomerOrder(List<Map<String, dynamic>> products) {
  // Show product menu using the showMenu function
  showMenu(products);

  // Initialize variables
  double subtotal = 0.0;
  Map<int, int> cart = {};

  // Product selection
  while (true) {
    print('\nEnter product number (1-5) or 0 to finish:');
    String? input = stdin.readLineSync();
    int? choice = int.tryParse(input ?? '');

    if (choice == 0) break;

    if (choice == null || choice < 1 || choice > 5) {
      print('Invalid choice. Please enter 1-5 or 0 to finish.');
      continue;
    }

    print('Enter quantity:');
    String? qtyInput = stdin.readLineSync();
    int? quantity = int.tryParse(qtyInput ?? '');

    if (quantity == null || quantity < 1) {
      print('Invalid quantity. Please try again.');
      continue;
    }

    // Add to cart
    cart[choice] = (cart[choice] ?? 0) + quantity;
  }

  // Check if cart is empty
  if (cart.isEmpty) {
    print('No items selected. Order canceled.');

    return;
  }

  // Calculate subtotal
  for (var entry in cart.entries) {
    int productNumber = entry.key;
    int quantity = entry.value;
    subtotal += products[productNumber - 1]['price'] * quantity;
  }

  // Get customer info
  print('\nEnter your name:');
  String? name = stdin.readLineSync();

  print('Enter your phone number:');
  String? phone = stdin.readLineSync();

  // Calculate tax using the calculateTax function
  double tax = calculateTax(subtotal);

  // Calculate discount using the calculateDiscount function
  double discount = calculateDiscount(subtotal);

  // Delivery option
  double deliveryFee = 0;
  print('\nDo you want delivery? (yes/no)');
  String? deliveryChoice = stdin.readLineSync();

  if (deliveryChoice?.toLowerCase() == 'yes') {
    print('Enter distance in km:');
    String? distanceInput = stdin.readLineSync();
    double distance = double.tryParse(distanceInput ?? '') ?? 0;

    // Calculate delivery fee using the calculateDeliveryFee function
    deliveryFee = calculateDeliveryFee(distance);
  }

  // Calculate total
  double total = subtotal + tax - discount + deliveryFee;

  // Print receipt
  print('\n=== RECEIPT ===');
  print('Customer: $name');
  print('Phone: $phone\n');
  print('Your Order:');

  for (var entry in cart.entries) {
    int productNum = entry.key;
    int quantity = entry.value;
    String productName = products[productNum - 1]['name'];
    double price = products[productNum - 1]['price'];
    print('$productName x $quantity: \$${(price * quantity).toStringAsFixed(2)}');
  }

  print('\nSubtotal: \$${subtotal.toStringAsFixed(2)}');
  print('Tax (13%): \$${tax.toStringAsFixed(2)}');
  print('Discount: \$${discount.toStringAsFixed(2)}');
  if (deliveryFee > 0) print('Delivery: \$${deliveryFee.toStringAsFixed(2)}');
  print('------------------');
  print('TOTAL: \$${total.toStringAsFixed(2)}');
  print('\nThank you for shopping with us!');
}