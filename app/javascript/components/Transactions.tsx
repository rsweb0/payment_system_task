import * as React from "react";
import { Container, Table } from "react-bootstrap";

const Transactions = ({ transactions }) => {
  return (
    <Container fluid className="mt-3">
      <h3 className="text-center">All Transactions</h3>
      <Table striped bordered hover>
        <thead>
          <tr>
            <th>Transaction Id</th>
            <th>Amount</th>
            <th>Type</th>
            <th>Status</th>
            <th>Customer Details</th>
            <th>Datetime</th>
          </tr>
        </thead>
        <tbody>
          {transactions.map((transaction) => (
            <tr>
              <td>{transaction.id}</td>
              <td>{transaction.amount}</td>
              <td>{transaction.type}</td>
              <td>{transaction.status}</td>
              <td>{transaction.customer_email} | {transaction.customer_phone}</td>
              <td>{transaction.created_at}</td>
            </tr>
          ))}
        </tbody>
      </Table>
    </Container>
  )
}

export default Transactions;
