# Система анализа транзакций клиентов банка
# Описание задачи:
# Банк хочет создать систему для анализа транзакций своих клиентов. Каждый клиент имеет счет, на котором происходят транзакции (пополнения, списания). Банк хочет:
# - Хранить информацию о клиентах и их транзакциях.
# - Анализировать транзакции (например, считать общий доход, расход, баланс).
# - Генерировать отчеты для клиентов.
#
# Необходимо создать классы на Python с функционалом описанным выше:
# Класс Client (Клиент):
# - Хранит информацию о клиенте (имя, ID).
# - Содержит список счетов клиента.
# Класс Account (Счет):
# - Хранит информацию о счете (номер счета, баланс).
# - Содержит список транзакций.
# Класс Transaction (Транзакция):
# - Хранит информацию о транзакции (тип: доход/расход, сумма, дата).
# Класс Bank (Банк):
# - Управляет клиентами и счетами.
# - Предоставляет методы для анализа данных (например, общий доход, расход, баланс).
#
# Дополнительные задания для практики:
# - Добавьте возможность фильтрации транзакций по дате.
# - Реализуйте метод для поиска клиента по ID.
# - Добавьте возможность экспорта транзакций в файл (например, CSV).
# - Реализуйте класс для генерации отчетов (например, PDF или Excel).

import csv
from datetime import datetime

class Transaction:
    def __init__(self, transaction_type, amount, date):
        self.transaction_type = transaction_type
        self.amount = amount
        self.date = date

    def __str__(self):
         return f"{self.date} - {self.transaction_type}: {self.amount}" 

class Account:
    def __init__(self, account_number):
        self.account_number = account_number
        self.balance = 0
        self.transactions = []

    def add_transaction(self, transaction):
        if transaction.transaction_type == 'expense' and self.balance < transaction.amount:
            raise ValueError("Недостаточно средств на счете")

        self.transactions.append(transaction)

        if transaction.transaction_type == 'income':
            self.balance += transaction.amount
        else:
            self.balance -= transaction.amount

    def get_transactions_by_date(self, start_date, end_date):
        return [t for t in self.transactions if start_date <= t.date <= end_date]

    def __str__(self):
        return f"Счет {self.account_number}, Баланс: {self.balance}"


class Client:
    def __init__(self, client_id, name):
        self.client_id = client_id
        self.name = name
        self.accounts = []

    def add_account(self, account):
        self.accounts.append(account)

    def get_total_balance(self):
        return sum(account.balance for account in self.accounts)

    def __str__(self):
        return f"Клиент {self.client_id}: {self.name}"


class Bank:
    def __init__(self):
        self.clients = []

    def add_client(self, client):
        self.clients.append(client)

    def find_client_by_id(self, client_id):
        for client in self.clients:
            if client.client_id == client_id:
                return client
        return None

    def export_transactions_to_csv(self, client_id, filename):
        client = self.find_client_by_id(client_id)
        if not client:
            raise ValueError("Клиент не найден")

        with open(filename, 'w', newline='') as csvfile:
            writer = csv.writer(csvfile)
            writer.writerow(["Дата", "Тип", "Сумма", "Счет"])

            for account in client.accounts:
                for transaction in account.transactions:
                    writer.writerow(
                        [transaction.date, transaction.transaction_type, transaction.amount, account.account_number])

    def generate_report(self, client_id, filename):
        client = self.find_client_by_id(client_id)
        if not client:
            raise ValueError("Клиент не найден")

        with open(filename, 'w') as file:

            file.write(f"Отчет для клиента {client.name} (ID: {client.client_id})\n")
            file.write("=" * 50 + "\n")

            for account in client.accounts:
                file.write(f"Счет: {account.account_number}, Баланс: {account.balance}\n")
                file.write("Транзакции:\n")

                for transaction in account.transactions:
                    file.write(f"  {transaction}\n")
                file.write("\n")


if __name__ == "__main__":
    bank = Bank()
    client1 = Client(1, "Иван Иванов")
    account1 = Account("1234567891011121314")
    account1.add_transaction(Transaction('income', 1000, datetime(2024, 10, 1)))
    account1.add_transaction(Transaction('expense', 200, datetime(2024, 10, 2)))
    client1.add_account(account1)


    client2 = Client(2, "Петр Петров")
    account2 = Account("987654321")
    account2.add_transaction(Transaction('income', 500, datetime(2023, 10, 1)))
    account2.add_transaction(Transaction('expense', 100, datetime(2023, 10, 3)))
    client2.add_account(account2)

    bank.add_client(client1)
    bank.add_client(client2)

    bank.export_transactions_to_csv(1, "transactions_client_1.csv")

    bank.generate_report(1, "report_client_1.txt")
