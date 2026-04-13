class FinancesMethodsData {
  bool cashEnabled;
  bool bankEnabled;
  String? bankName;
  String? accountNumber;
  String? iban;
  bool walletEnabled;
  String? walletNumber;

  FinancesMethodsData({
    this.cashEnabled = false,
    this.bankEnabled = false,
    this.bankName,
    this.accountNumber,
    this.iban,
    this.walletEnabled = false,
    this.walletNumber,
  });
}
