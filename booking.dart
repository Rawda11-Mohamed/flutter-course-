import 'dart:io';

void main() {
  List<List<String>> seats = List.generate(5, (_) => List.filled(5, 'E'));
  Map<String, Map<String, String>> bookings = {};

  print('Welcome To Our Theater');

  while (true) {
    print('\npress 1 to book new seat');
    print('press 2 to show the theater seats');
    print('press 3 to show users data');
    print('press 4 to exit');

    stdout.write('input=>');
    String? choice = stdin.readLineSync();

    if (choice == '1') {
      // Book seat
      int? row, col;

      stdout.write("Enter row (1-5) or 'exit' to quit: \ninput=>");
      String? rowInput = stdin.readLineSync();
      if (rowInput == 'exit') continue;
      row = int.tryParse(rowInput ?? '');
      if (row == null || row < 1 || row > 5) {
        print('Invalid row number.');
        continue;
      }

      stdout.write("Enter column (1-5): \ninput=>");
      col = int.tryParse(stdin.readLineSync() ?? '');
      if (col == null || col < 1 || col > 5) {
        print('Invalid column number.');
        continue;
      }

      if (seats[row - 1][col - 1] == 'B') {
        print('Seat already booked!');
        continue;
      }

      stdout.write("Enter your name: \ninput=>");
      String? name = stdin.readLineSync();

      stdout.write("Enter your phone number: \ninput=>");
      String? phone = stdin.readLineSync();

      // Book the seat
      seats[row - 1][col - 1] = 'B';
      String seatKey = '${row},${col}';
      bookings[seatKey] = {'name': name ?? '', 'phone': phone ?? ''};

      print('Seat booked successfully!');

    } else if (choice == '2') {
      // Show theater seats
      print('\nTheater Seats:');
      for (var row in seats) {
        print(row.join(' '));
      }

    } else if (choice == '3') {
      // Show booking data
      print('\nUsers Booking Details:');
      if (bookings.isEmpty) {
        print('No bookings yet.');
      } else {
        bookings.forEach((seat, userData) {
          print('Seat $seat: ${userData['name']} - ${userData['phone']}');
        });
      }

    } else if (choice == '4') {
      print('\nSee You Back');
      break;
    } else {
      print('Invalid choice, try again.');
    }
  }
}
