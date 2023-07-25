void main() {
  bool getDateOfBirthFromId(String idNumber) {
    bool isDOBValid = false;
    String dob;
    if (int.parse(idNumber.substring(0, 2)) < DateTime.now().year) {
      dob = '20' + idNumber.substring(0, 6);
    } else {
      dob = '19' + idNumber.substring(0, 6);
    }
    dob += ' 000000';

    try {
      DateTime dateOfBirth = DateTime.parse(dob);
    } catch (_) {
      return false;
    }

    isDOBValid = true;

    return isDOBValid;
  }

  bool isValidId(String idNumber) {
    bool valid = false;

    if (idNumber.length == 13) {
      bool isValidDateOfBirth = getDateOfBirthFromId(idNumber);

      if (!isValidDateOfBirth) {
        return false;
      }

      List<int> digits = idNumber.split('').map(int.parse).toList();
      int providedCheckDigit = digits.removeLast();

      int sumOfOddChars = digits[0] +
          digits[2] +
          digits[4] +
          digits[6] +
          digits[8] +
          digits[10];
      String concatOfEvenChars =
          '${digits[1]}${digits[3]}${digits[5]}${digits[7]}${digits[9]}${digits[11]}';
      int evensx2 = int.parse(concatOfEvenChars) * 2;
      int sumOfDoubleOfConcat =
          evensx2.toString().split('').map(int.parse).reduce((a, b) => a + b);
      int sums = sumOfOddChars + sumOfDoubleOfConcat;
      int lastDigit = sums % 10;
      int calculatedCheckDigit = (10 - lastDigit) % 10;

      valid = calculatedCheckDigit == providedCheckDigit;
    }

    return valid;
  }

  print(isValidId('7912261086085'));
}
