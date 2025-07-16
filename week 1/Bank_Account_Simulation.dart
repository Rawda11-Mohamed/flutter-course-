import 'dart:io';
String accountName = '';
String accountNumber = '';
String accountType = '';
double accountBalance = 0;

void showMenu() {
  print('1. Deposit');
  print('2. Withdraw');
  print('3. Predict Future Balance (Profit Model)');
  print('4. View Account Summary');
  print('5. Exit');
  stdout.write('Choose an option: ');
}

void deposit() {
  stdout.write('Enter amount to deposit: ');
  double amount = double.tryParse(stdin.readLineSync() ?? '0') ?? 0;

  if (amount > 0) {
    accountBalance += amount;
    print('Deposit successful. New balance: \$${accountBalance.toStringAsFixed(2)}');
  } else {
    print('Invalid amount. Deposit failed.');
  }
}

void withdraw() {
  stdout.write('Enter amount to withdraw: ');
  double amount = double.tryParse(stdin.readLineSync() ?? '0') ?? 0;

  if (amount > 0) {
    if (amount <= accountBalance) {
      accountBalance -= amount;
      print('Withdrawal successful. New balance: \$${accountBalance.toStringAsFixed(2)}');
    } else {
      print('Insufficient balance. Withdrawal denied.');
    }
  } else {
    print('Invalid amount. Withdrawal failed.');
  }
}

void predictFutureBalance() {
  stdout.write('Enter number of years: ');
  int years = int.tryParse(stdin.readLineSync() ?? '0') ?? 0;

  if (years < 0) {
    print('Number of years must be positive.');
    return;
  }

  stdout.write('Enter annual profit rate: ');
  double rate = double.tryParse(stdin.readLineSync() ?? '0') ?? 0;

  if (rate < 0) {
    print('Profit rate must be positive.');
    return;
  }

  double futureBalance = accountBalance * (1 + (rate / 100) * years);
  print('\nPredicted future balance after $years years: \$${futureBalance.toStringAsFixed(2)}');
  print('Rounded balance: \$${futureBalance.round()}');
}

void showSummary() {
  print('\nAccount Summary:');
  print('Name: $accountName');
  print('Account Number: $accountNumber');
  print('Account Type: $accountType');
  print('Current Balance: \$${accountBalance.toStringAsFixed(2)}');
  print('Rounded Balance: \$${accountBalance.round()}');
}

void createAccount() {
  stdout.write('Enter your name: ');
  accountName = stdin.readLineSync() ?? '';

  stdout.write('Enter account number: ');
  accountNumber = stdin.readLineSync() ?? '';

  while (true) {
    stdout.write('Enter account type (savings/checking): ');
    accountType = stdin.readLineSync() ?? '';

    if (accountType == 'savings' || accountType == 'checking') {
      break;
    }
    print('Invalid account type. Please enter "savings" or "checking".');
  }

  stdout.write('Enter initial balance: ');
  accountBalance = double.tryParse(stdin.readLineSync() ?? '0') ?? 0;
}

void main() {
  // Create account
  createAccount();

  // Main program loop
  bool shouldExit = false;

  while (!shouldExit) {
    showMenu();
    int option = int.tryParse(stdin.readLineSync() ?? '0') ?? 0;

    switch (option) {
      case 1:
        deposit();
        break;
      case 2:
        withdraw();
        break;
      case 3:
        predictFutureBalance();
        break;
      case 4:
        showSummary();
        break;
      case 5:
        shouldExit = true;
        print('Thank you for using the banking system. Goodbye!');
        break;
      default:
        print('Invalid option. Please choose 1-5.');
    }
  }
}